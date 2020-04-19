package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.Services.ProductService;
import com.example.accessingdatamysql.dao.*;
import com.example.accessingdatamysql.models.*;
import com.example.accessingdatamysql.models.embeddedKey.PriceKey;
import com.example.accessingdatamysql.models.embeddedKey.SellsKey;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/product")
@Api(value = "product", description = "Controller about products and categories")
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ProductRepositoryWithoutPage productRepositoryWithoutPage;

    @Autowired
    private ProductService service;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SellerRepository sellerRepository;

    @Autowired
    private UserRepository userRepository;


    @ApiOperation("You can save the product. Selling table not yet implemented")
    @PostMapping(path ="/addBook")
    public @ResponseBody
    String addBook(@RequestParam Integer sellerID,@RequestParam Integer price, @RequestParam Integer quantity, @RequestBody Product product) {
        Product pr = productRepository.save(product);

        Sells sells = new Sells();
        SellsKey sellsKey = new SellsKey();
        sellsKey.setProductID(pr.getProductID());
        sellsKey.setSellerID(sellerID);

        sells.setSellerID(sellsKey);

        Price price1 = new Price();
        LocalDateTime datetime = LocalDateTime.ofInstant(Instant.now(), ZoneOffset.ofHoursMinutes(3,0));
        String formatted = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss").format(datetime);
        price1.setPriceID(new PriceKey(pr.getProductID(),sellerID, formatted));
        price1.setPrice(price);
        Set<Price> prices = new HashSet<Price>();

        prices.add(price1);
        sells.setPrice(prices);
        sells.setQuantity(quantity);

        sells.setProduct(pr);
        Optional<User> user = userRepository.findUserByUserID(sellerID);
        sells.setUser(user.get());
        sellerRepository.save(sells);
        return "A new selling created";
    }

    @ApiOperation("add new category, this will have admin auth")
    @PostMapping(path = "/addCategory") // Admin
    public @ResponseBody String addCategory(@RequestParam String name) {
        Category category = new Category(name);
        categoryRepository.save(category);
        return "Category Saved";
    }
    @ApiOperation("get categories")
    @PostMapping(path = "/getCategories")
    public @ResponseBody Iterable<Category> getCategories()
    {
        return categoryRepository.findAll();
    }

    @ApiOperation("Get Products")
    @GetMapping(path = "/getBooks")
    public @ResponseBody
    Iterable<Product> getProducts(@RequestParam(defaultValue = "0") Integer pageNo,
                                  @RequestParam(defaultValue = "2") Integer pageSize,
                                  @RequestParam(defaultValue = "productID") String sortBy) {
        Iterable<Product> list = service.getAll(pageNo,pageSize,sortBy);
        return list;
        //return productRepository.findAll(pageable);
    }

    @GetMapping(path = "/getSellerBooks")
    public @ResponseBody
    List<Product> getSellerProducts(@RequestParam Integer  sellerID) {
        return productRepositoryWithoutPage.findProductBySellerID(sellerID);
        //return productRepository.findAll(pageable);
    }


}
