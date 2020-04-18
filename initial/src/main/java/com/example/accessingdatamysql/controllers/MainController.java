package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.*;
import com.example.accessingdatamysql.models.*;
import com.example.accessingdatamysql.security.PasswordConfig;
import com.google.common.hash.Hashing;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Optional;
import java.util.Set;

@Controller // This means that this class is a Controller
@RequestMapping(path="/demo") // This means URL's start with /demo (after Application path)
@Api(value = "asdas", description = "Dont use this. Will be deleted soon")
public class MainController {
    @Autowired // This means to get the bean called userRepository
    // Which is auto-generated by Spring, we will use it to handle the data
    private UserRepository userRepository;
    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private PostalRepository postalRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private CardRepository cardRepository;

    private final PasswordEncoder passwordEncoder;

    @Autowired
    public MainController(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping(path="/add") // Map ONLY POST Requests
    public @ResponseBody String addNewUser (@RequestBody User user) {


        Optional<User> user1 = userRepository.findUserByEmail(user.getEmail());


        if(!user1.isPresent()) return "This mail is already in use";

        String passSha;
        String pass;
        if(user.getPassword() != null)
            pass = user.getPassword();
        else return "pass";

        passSha = Hashing.sha256().hashString(user.getPassword(), StandardCharsets.UTF_8).toString();
        user.setPassword(passSha);


        userRepository.save(user);
        return "Saved";
    }

    @PostMapping(path= "/updateUser")
    public @ResponseBody String updateUser (@RequestBody User user) {

        Optional<User> user1 = userRepository.findUserByEmail(user.getEmail());

        if(!user1.isPresent()) return "Requested user not found";

        for(Address a: user.getAddresses()) {
            PostalCode postalCode = postalRepository.findByPostalCode(a.getPostalCode().getPostalCode());
            if(postalCode != null) a.setPostalCode(postalCode);
            user1.get().getAddresses().add(a);
        }

        Set<CardInfo> cards = new HashSet<>();

        for(CardInfo c : user.getCards()) {
            Set<User> s = new HashSet<>();
            s.add(user1.get());
            c.setUsers(s);
            cards.add(c);
        }

        if(user.getPassword() != null) {
            String passSha = Hashing.sha256().hashString(user.getPassword(), StandardCharsets.UTF_8).toString();
            user1.get().setPassword(passSha);
        }


        user1.get().setCards(cards);
        userRepository.save(user1.get());
        return "Saved";
    }

    @GetMapping(path="/all")
    public @ResponseBody Iterable<User> getAllUsers() {

        // This returns a JSON or XML with the users
        return userRepository.findAll();
    }
    @GetMapping(path="/alladdress")
    public @ResponseBody Iterable<Address> getAllAddress() {
        // This returns a JSON or XML with the users
        return addressRepository.findAll();
    }

    @GetMapping(path="/allproducts")
    public @ResponseBody Iterable<Product> getAllProducts() {
        // This returns a JSON or XML with the users
        return productRepository.findAll();
    }


    @PostMapping(path= "/addSellerAddress")
    public @ResponseBody String addSellerAddress(@RequestParam Integer userID, @RequestParam String addressName){
            Optional<User> user = userRepository.findUserByUserID(userID);

            if(user.isPresent()) return "Requested user not found";

            Address address = new Address();
            //Address[] addresses = user.getAddresses();
            boolean found = false;

            for(Address a : user.get().getAddresses()){

                if(addressName.equals(a.getAddressName())) {
                    address.setAddressID(a.getAddressID());
                    found = true;
                }

            }

            if(!found) return "address not found";

            user.get().setSellerAddressID(address);
            userRepository.save(user.get());

            return "Saved";
    }

    @PostMapping(path= "/addAddress")
    public @ResponseBody String addAddress(@RequestParam Integer userID, @RequestBody Address address){
        Optional<User> user = userRepository.findUserByUserID(userID);

        if(user.isPresent()) return "Requested user not found";

        addressRepository.save(address);

        user.get().getAddresses().add(address);
        userRepository.save(user.get());
        return "Saved.";
    }
    @PostMapping(path ="/addBook")
    public @ResponseBody String addBook(@RequestParam Integer sellerID, @RequestBody Product product)
    {
        productRepository.save(product);
        return "seller Not Implemented, added book";
    }

    @PostMapping(path = "/addCategory") // Admin
    public @ResponseBody String addCategory(@RequestParam String name)
    {
        Category category = new Category(name);
        categoryRepository.save(category);
        return "Category Saved";
    }
    /*
    @PostMapping(path="/addpostal")
    public @ResponseBody String addPostal(@RequestBody PostalCode postalCodeCity){
        postalRepository.save(postalCodeCity);
        return "saved";
    }*/
}