package com.example.accessingdatamysql.models;


import com.example.accessingdatamysql.models.embeddedKey.OrderDetailKey;
import com.example.accessingdatamysql.models.enums.OrderStatus;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.persistence.*;
import java.io.Serializable;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "orderdetails")
public class OrderDetail implements Serializable {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderDetailID;

    private Integer quantity;


    @Enumerated(EnumType.STRING)
    @Column(length=45)
    private OrderStatus status;



    @ManyToOne(fetch = FetchType.LAZY)
//    @MapsId("orderID")
    @JoinColumn(name = "orderID", referencedColumnName = "orderID")
    private Order order;


    @ManyToOne(fetch = FetchType.LAZY)
//    @MapsId("shippingInfoID")
    @JoinColumn(name = "shippingInfoID", referencedColumnName = "shippingInfoID")
    private ShippingInfo shippingInfo;


    @JsonIgnoreProperties("orderdetails")
    @ManyToOne(fetch = FetchType.LAZY)
//    @MapsId("sellerID")
    @JoinColumn(name = "sellerID", referencedColumnName = "userID")
    private User user;

    @JsonIgnoreProperties("orderdetails")
    @ManyToOne(fetch = FetchType.LAZY)
//    @MapsId("productID")
    @JoinColumn(name = "productID", referencedColumnName = "productID")
    private Product product;




    @JsonIgnore
    public Order getOrder() {
        return order;
    }
    @JsonIgnore
    public void setOrder(Order order) {
        this.order = order;
    }
    @JsonIgnore
    public ShippingInfo getShippingInfo() {
        return shippingInfo;
    }
    @JsonIgnore
    public void setShippingInfo(ShippingInfo shippingInfo) {
        this.shippingInfo = shippingInfo;
    }
    @JsonIgnore
    public User getUser() {
        return user;
    }
    @JsonIgnore
    public void setUser(User user) {
        this.user = user;
    }
    @JsonIgnore
    public Product getProduct() {
        return product;
    }
    @JsonIgnore
    public void setProduct(Product product) {
        this.product = product;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }

    public Integer getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(Integer orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

}
