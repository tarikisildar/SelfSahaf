package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "order")
public class Order {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer orderID;


    @JsonIgnoreProperties("orders")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "buyerID", referencedColumnName = "userID")
    private User buyer;

    @ManyToOne
    @JoinColumn(name = "cardNumber")
    private CardInfo cardNumber;


    private String datetime;



    @OneToOne
    @JoinColumn(name = "receiverAddressID", referencedColumnName = "addressID")
    private Address receiverAddressID;

    public Integer getOrderID() {
        return orderID;
    }

    public void setOrderID(Integer orderID) {
        this.orderID = orderID;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }

    public CardInfo getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(CardInfo cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public Address getReceiverAddressID() {
        return receiverAddressID;
    }

    public void setReceiverAddressID(Address receiverAddressID) {
        this.receiverAddressID = receiverAddressID;
    }


}
