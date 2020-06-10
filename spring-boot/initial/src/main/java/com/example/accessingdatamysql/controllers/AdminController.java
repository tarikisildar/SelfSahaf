package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(path="/admin")
@Api(value = "admin", description = "Admin controls")
public class AdminController {



    @Autowired
    private UserRepository userRepository;



    @ApiOperation("Get Total Number of Registered Users")
    @GetMapping(path="/getUserCount")
    public @ResponseBody Integer getUserCount(){
        return userRepository.getUserCount();
    }



}
