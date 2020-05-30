package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.OrderRepository;
import com.example.accessingdatamysql.dao.ProductRepository;
import com.example.accessingdatamysql.models.Address;
import com.example.accessingdatamysql.models.Order;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.util.List;

public class OrderController {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderRepository orderRepository;


    @ApiOperation("Get given orders")
    @GetMapping(path="/givenOrders")
    public @ResponseBody Iterable<Order> getGivenOrders()
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Get taken orders")
    @GetMapping(path="/takenOrders")
    public @ResponseBody Iterable<Order> getTakenOrders()
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Cancel Order")
    @PostMapping(path="/cancel")
    public @ResponseBody String cancelOrder(@RequestParam Integer orderID)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Change Address")
    @PostMapping(path="/updateAddress")
    public @ResponseBody String updateAddress(@RequestParam Integer orderID, Address address)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Return Request")
    @PostMapping(path="/returnRequest")
    public @ResponseBody String returnRequest(@RequestParam Integer orderID, List<MultipartFile> file, String message)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Return Request")
    @PostMapping(path="/returnConfirm")
    public @ResponseBody String confirmReturnRequest(@RequestParam Integer orderID, String message, boolean confirm)
    {
        throw new NotImplementedException();
    }
}
