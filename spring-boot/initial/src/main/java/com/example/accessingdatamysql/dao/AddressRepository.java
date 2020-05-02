package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.Address;
import org.springframework.data.repository.CrudRepository;

public interface AddressRepository extends CrudRepository<Address, Integer>
{

}
