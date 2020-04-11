package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.Product;
import com.example.accessingdatamysql.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface ProductRepository extends PagingAndSortingRepository<Product, Integer>
{


}
