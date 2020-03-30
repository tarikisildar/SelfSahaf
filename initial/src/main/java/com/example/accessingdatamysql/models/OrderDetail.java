package com.example.accessingdatamysql.models;


import com.example.accessingdatamysql.models.embeddedKey.OrderDetailKey;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.sun.org.apache.xpath.internal.operations.Bool;

import javax.persistence.*;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "orderdetails")
public class OrderDetail {


    @EmbeddedId
    private OrderDetailKey orderDetailID;

    private Integer quantity;
    private Integer refund;



    @OneToOne
    @MapsId("orderID")
    @JoinColumn(name = "orderID")
    private Order order;


    @OneToOne
    @MapsId("shippingInfoID")
    @JoinColumn(name = "shippingInfoID")
    private ShippingInfo shippingInfo;


    @JsonIgnoreProperties("orderdetails")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("sellerID")
    @JoinColumn(name = "sellerID", referencedColumnName = "userID")
    private User user;

    @JsonIgnoreProperties("orderdetails")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("productID")
    @JoinColumn(name = "productID", referencedColumnName = "productID")
    private Product product;




    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getRefund() {
        return refund;
    }

    public void setRefund(Integer refund) {
        this.refund = refund;
    }

    public OrderDetailKey getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(OrderDetailKey orderDetailID) {
        this.orderDetailID = orderDetailID;
    }


}
