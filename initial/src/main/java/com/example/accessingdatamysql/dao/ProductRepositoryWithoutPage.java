package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductRepositoryWithoutPage extends CrudRepository<Product,Integer> {
    @Query("SELECT p FROM Product p WHERE name = ?1")
    List<Product> findProductBySellerID(String name);
}
