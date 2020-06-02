package com.example.accessingdatamysql.dao;

import com.example.accessingdatamysql.models.CartItem;
import com.example.accessingdatamysql.models.Order;
import com.example.accessingdatamysql.models.OrderDetail;
import org.aspectj.weaver.ast.Or;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderDetailRepository extends CrudRepository<OrderDetail, Integer>{
    @Query("SELECT ord FROM OrderDetail ord WHERE ord.orderDetailID.sellerID = ?1")
    List<OrderDetail> findOrderDetailBySellerID(Integer sellerID);

    @Query("SELECT ord.order FROM OrderDetail ord WHERE ord.orderDetailID.sellerID = ?1")
    List<Order> findOrdersBySellerID(Integer sellerID);

    @Query("SELECT ord FROM OrderDetail ord WHERE ord.orderDetailID.orderID = ?1 AND ord.orderDetailID.productID = ?2")
    OrderDetail findOrderDetailByOrderIDAndProductID(Integer orderID, Integer productID);

    @Query("SELECT ord FROM OrderDetail ord WHERE ord.orderDetailID.orderID = ?1")
    List<OrderDetail> findOrderDetailsByOrderID(Integer orderID);
}
