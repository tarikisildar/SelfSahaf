package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.ShippingCompany;
import org.springframework.data.repository.CrudRepository;

public interface ShippingRepository extends CrudRepository<ShippingCompany,Integer> {
    ShippingCompany findShippingCompanyByCompanyName(String name);
}
