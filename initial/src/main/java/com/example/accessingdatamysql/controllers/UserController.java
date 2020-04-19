package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.dao.AddressRepository;
import com.example.accessingdatamysql.dao.PostalRepository;
import com.example.accessingdatamysql.dao.UserRepository;
import com.example.accessingdatamysql.models.Address;
import com.example.accessingdatamysql.models.CardInfo;
import com.example.accessingdatamysql.models.PostalCode;
import com.example.accessingdatamysql.models.User;
import com.example.accessingdatamysql.security.UserRole;
import com.google.common.hash.Hashing;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

import static com.example.accessingdatamysql.security.UserRole.*;

@Controller
@RequestMapping(path="/user")
@Api(value = "user", description = "All about users")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostalRepository postalRepository;

    @Autowired
    private AddressRepository addressRepository;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @ApiOperation("Don't post userID, address and card here. Use update for that")
    @PostMapping(path="/add")
    public @ResponseBody String addNewUser (@RequestBody User user, HttpServletResponse response) {

        Optional<User> findUser = userRepository.findUserByEmail(user.getEmail());


        if(findUser.isPresent()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return "This mail is already in use";
        }

        /*if (user.getRole().equals("ROLE_SELLER")) user.setRole(SELLER.name());
        else if (user.getRole().equals("ROLE_ADMIN")) user.setRole(ADMIN.name());
        else user.setRole(USER.name());*/

        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userRepository.save(user);
        return "Saved";
    }

    @ApiOperation("You can update any user variable, if mail is changed; give old mail as param")
    @PostMapping(path= "/update")
    public @ResponseBody String updateUser (@RequestBody User user, HttpServletResponse response) {


        Optional<User> findUser = userRepository.findUserByUserID(user.getUserID());

        if(findUser.isPresent()) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);

            return "Requested User not found";
        }

        if(user.getAddresses() != null) {
            for (Address a : user.getAddresses()) {
                PostalCode postalCode = postalRepository.findByPostalCode(a.getPostalCode().getPostalCode());
                if (postalCode != null) {
                    a.setPostalCode(postalCode);
                }
                findUser.get().getAddresses().add(a);
            }
        }

        Set<CardInfo> cards = new HashSet<>();
        if(user.getCards() != null) {
            for (CardInfo c : user.getCards()) {
                Set<User> s = new HashSet<User>();
                s.add(findUser.get());
                c.setUsers(s);
                cards.add(c);
            }
        }

        if(user.getPassword() != null)
            findUser
                    .get()
                    .setPassword(
                            passwordEncoder.encode(user.getPassword())
                    );


        if(!cards.isEmpty()) findUser.get().setCards(cards);

        userRepository.save(findUser.get());
        return "Saved";

    }

    @ApiOperation("Get user with id")
    @GetMapping(path="/get")
    public @ResponseBody Optional<User> getUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return userRepository.findUserByUserID(((UserDetailsImp) auth.getPrincipal()).getUserID());
    }

    @ApiOperation("Get all users")
    @GetMapping(path="/all")
    public @ResponseBody Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }


    @ApiOperation("Choose seller address from users addresses. Give the pre-saved addressName")
    @PostMapping(path= "/addSellerAddress")
    public @ResponseBody String addSellerAddress(@RequestParam Integer userID, @RequestBody Address address,HttpServletResponse response){
        Optional<User> user = userRepository.findUserByUserID(userID);
        if(user.isPresent()){
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return "Requested user not found";
        }
        PostalCode postalCode = postalRepository.findByPostalCode(address.getPostalCode().getPostalCode());
        if (postalCode != null) {
            address.setPostalCode(postalCode);


            addressRepository.save(address);

            userRepository.save(user.get());
        }
        return "saved";

    }

    @ApiOperation("w/ id for update")
    @PostMapping(path= "/addAddress")

    public @ResponseBody String addAddress(@RequestParam Integer userID, @RequestBody Address address, HttpServletResponse response) {

        Optional<User> user = userRepository.findUserByUserID(userID);

        if(user.isPresent()){
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return "Requested user not found";
        }
        if(user.get().getAddresses() != null) {
                PostalCode postalCode = postalRepository.findByPostalCode(address.getPostalCode().getPostalCode());
                if (postalCode != null) {
                    address.setPostalCode(postalCode);
                }
                user.get().getAddresses().add(address);
        }
        addressRepository.save(address);
        user.get().getAddresses().add(address);
        userRepository.save(user.get());

        return "Saved";

    }
}
