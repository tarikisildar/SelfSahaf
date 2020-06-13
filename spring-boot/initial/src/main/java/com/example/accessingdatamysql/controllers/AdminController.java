package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.CategoryRepository;
import com.example.accessingdatamysql.dao.OrderRepository;
import com.example.accessingdatamysql.dao.UserRepository;
import com.example.accessingdatamysql.models.Category;
import com.example.accessingdatamysql.models.Product;
import com.example.accessingdatamysql.models.Sells;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@Controller
@RequestMapping(path="/admin")
@Api(value = "admin", description = "Admin controls")
public class AdminController {



    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    CategoryRepository categoryRepository;


    @ApiOperation("Get Total Number of Registered Users")
    @GetMapping(path="/getUserCount")
    public @ResponseBody Integer getUserCount(){
        return userRepository.getUserCount();
    }


    @ApiOperation("Get Total Number of Sellers")
    @GetMapping(path="/getSellerCount")
    public @ResponseBody Integer getSellerCount(){
        return userRepository.getSellerCount();
    }



    @ApiOperation("Get Total Number of Orders")
    @GetMapping(path="/getOrderCount")
    public @ResponseBody Integer getOrderCount(){
        return orderRepository.getOrderCount();
    }


    @ApiOperation("Set Discount in Category Event")
    @PostMapping(path="/setDiscount")
    public @ResponseBody String  setDiscount(Integer categoryID, Integer discount){
        Set<Product> products =  categoryRepository.findById(categoryID).get().getProducts();
        for (Product product: products) {
            for (Sells sell: product.getSells()) {
                sell.getPrice().setDiscount(discount);
            }
        }
        return "saved";
    }




}
