package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.Product;
import org.springframework.data.repository.CrudRepository;

public interface ProductRepository extends CrudRepository<Product, Integer> {

}
