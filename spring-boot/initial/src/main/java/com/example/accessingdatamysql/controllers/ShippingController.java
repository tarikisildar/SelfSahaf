package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.ShippingRepository;
import com.example.accessingdatamysql.models.ShippingCompany;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/shipping")
@Api(value = "product", description = "Controller about shipment")
public class ShippingController {

    @Autowired
    ShippingRepository shippingRepository;

    @ApiOperation("Add Shipping Company")
    @PostMapping("/addCompany")
    public @ResponseBody String addShippingCompany(@RequestParam String companyName, @RequestParam String website, @RequestParam float price)
    {
        ShippingCompany comp = shippingRepository.findShippingCompanyByCompanyName(companyName);
        if(comp == null)
            comp = new ShippingCompany(companyName,price,website);
        else{
            comp.setCompanyName(companyName);
            comp.setWebsite(website);
            comp.setPrice(price);
        }
        shippingRepository.save(comp);
        return "saved";
    }

    @ApiOperation("Remove Shipping Company")
    @DeleteMapping("/removeCompany")
    public @ResponseBody String removeShippingCompany(@RequestParam String companyName)
    {
        ShippingCompany comp = shippingRepository.findShippingCompanyByCompanyName(companyName);
        shippingRepository.delete(comp);
        return "deleted";
    }

}
