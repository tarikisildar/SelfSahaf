package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.dao.CategoryRepository;
import com.example.accessingdatamysql.dao.ProductRepository;
import com.example.accessingdatamysql.models.Category;
import com.example.accessingdatamysql.models.Product;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/product")
@Api(value = "product", description = "Controller about products and categories")
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @ApiOperation("You can save the product. Selling table not yet implemented")
    @PostMapping(path ="/addBook")
    public @ResponseBody
    String addBook(@RequestParam Integer sellerID, @RequestBody Product product)
    {
        productRepository.save(product);
        return "seller Not Implemented, added book";
    }

    @ApiOperation("add new category, this will have admin auth")
    @PostMapping(path = "/addCategory") // Admin
    public @ResponseBody String addCategory(@RequestParam String name)
    {
        Category category = new Category(name);
        categoryRepository.save(category);
        return "Category Saved";
    }
}
