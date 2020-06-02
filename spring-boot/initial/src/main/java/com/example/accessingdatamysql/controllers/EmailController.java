package com.example.accessingdatamysql.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.mail.*;
import javax.mail.internet.*;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;


@Controller
@RequestMapping(path="/email")
@Api(value = "email", description = "All about mail")
public class EmailController {

    @Autowired
    private JavaMailSender javaMailSender;


    @ApiOperation("Send email to a user")
    @PostMapping(value = "/sendemail")
    public @ResponseBody String sendEmail(String email) throws IOException, MessagingException {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setFrom("selfsahaf.ss@gmail.com");
        msg.setTo(email);

        msg.setSubject("Testing from Spring Boot");
        msg.setText("Hello World \n Spring Boot Email");

        javaMailSender.send(msg);
        return "Email sent successfully";
    }


}