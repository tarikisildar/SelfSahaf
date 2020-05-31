package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.CartItem;
import com.example.accessingdatamysql.models.Product;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CartRepository extends CrudRepository<CartItem,Integer>{

    @Query("SELECT cart FROM CartItem cart WHERE cart.cartItemID.cartUserID = ?1")
    List<CartItem> findCartItemsByUserID(Integer userID);
}
