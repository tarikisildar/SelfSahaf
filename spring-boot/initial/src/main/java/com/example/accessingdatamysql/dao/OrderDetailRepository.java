package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.OrderDetail;
import org.springframework.data.repository.CrudRepository;

public interface OrderDetailRepository extends CrudRepository<OrderDetail, Integer>{

}
