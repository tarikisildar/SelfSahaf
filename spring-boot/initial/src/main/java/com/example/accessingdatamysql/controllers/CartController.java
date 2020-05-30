package com.example.accessingdatamysql.controllers;


import com.example.accessingdatamysql.Services.ProductService;
import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.dao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNullApi;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/cart")
@Api(value = "cart", description = "Controller about carts")
public class CartController {


    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UserRepository userRepository;


    @ApiOperation("Get Cart")
    @GetMapping(path = "/getCart")
    public @ResponseBody
    Cart getCart(HttpServletResponse response){


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        Cart cart = cartRepository.findUserByUserID(userID).get();

        return cart;


    }


    @ApiOperation("Add item to Cart")
    @PostMapping(path = "/addItemToCart")
    public @ResponseBody
    String addItemToCart(CartItem cartItem, HttpServletResponse response){


        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        User user = cartRepository.findUserByUserID(userID).get();

        if ( user != null){

            if(cartItem != null){

                user.addItemToCart(cartItem);

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
