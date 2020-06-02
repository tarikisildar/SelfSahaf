package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
@Entity
@Table(name = "refunds")
public class RefundRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer refundID;

    @JsonIgnoreProperties("refunds")
    @ManyToOne
    @JoinColumns(
            {
                    @JoinColumn(name="receiverID", referencedColumnName="sellerID"),
                    @JoinColumn(name="productID", referencedColumnName="productID")
            })
    private OrderDetail orderDetail;

    @JsonIgnoreProperties("refunds")
    @ManyToOne
    @JoinColumn(name="buyerID", referencedColumnName="userID")
    private User user;

    private String datetime;

    private String path;


    @Column(length = 255)
    private String message;

    public RefundRequest() {
    }

    public RefundRequest(OrderDetail orderDetail, String datetime, String path, String message) {
        this.orderDetail = orderDetail;
        this.datetime = datetime;
        this.path = path;
        this.message = message;
    }

    public RefundRequest(OrderDetail orderDetail, String datetime, String message) {
        this.orderDetail = orderDetail;
        this.datetime = datetime;
        this.message = message;
    }

    public Integer getRefundID() {
        return refundID;
    }
    @JsonIgnore
    public void setRefundID(Integer refundID) {
        this.refundID = refundID;
    }
    @JsonIgnore
    public OrderDetail getOrderDetail() {
        return orderDetail;
    }
    @JsonIgnore
    public void setOrderDetail(OrderDetail orderDetail) {
        this.orderDetail = orderDetail;
    }
    @JsonIgnore
    public User getUser() {
        return user;
    }
    @JsonIgnore
    public void setUser(User user) {
        this.user = user;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
