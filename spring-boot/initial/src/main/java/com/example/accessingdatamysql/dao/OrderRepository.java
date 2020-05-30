package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.Order;
import org.springframework.data.repository.CrudRepository;

public interface OrderRepository extends CrudRepository<Order, Integer>{

}
