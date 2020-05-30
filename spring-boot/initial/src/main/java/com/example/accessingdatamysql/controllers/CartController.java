package com.example.accessingdatamysql.controllers;


import com.example.accessingdatamysql.Services.ProductService;
import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.dao.*;
import com.example.accessingdatamysql.models.CartItem;
import com.example.accessingdatamysql.models.Product;
import com.example.accessingdatamysql.models.User;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNullApi;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Set;

@Controller
@RequestMapping("/cart")
@Api(value = "cart", description = "Controller about carts")
public class CartController {


    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductRepositoryWithoutPage productRepositoryWithoutPage;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserRepository userRepository;


    @ApiOperation("Get Cart")
    @GetMapping(path = "/getCart")
    public @ResponseBody
    Set<CartItem> getCart(HttpServletResponse response){


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        return userRepository.findUserByUserID(userID).get().getCart();



    }


    @ApiOperation("Add item to Cart")
    @PostMapping(path = "/addItemToCart")
    public @ResponseBody
    String addItemToCart(@RequestParam Integer productID,@RequestParam Integer amount, HttpServletResponse response){


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        User user = userRepository.findUserByUserID(userID).get();
        Set<CartItem> cart = user.getCart();

        if ( cart != null){

            if(productID != null){

                Product product = productRepositoryWithoutPage.findById(productID).get();
                CartItem item = new CartItem(amount,user,product);

                cart.add(item);

                user.setCart(cart);

                userRepository.save(user);

                return "saved";
            }
            else{
                return "Cart Item is set to null";
            }
        }

        return "User is not found";

    }



}
