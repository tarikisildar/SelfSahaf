package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.PostalCodeCity;
import org.springframework.data.repository.CrudRepository;

public interface PostalRepository extends CrudRepository<PostalCodeCity, Integer>
{

}
