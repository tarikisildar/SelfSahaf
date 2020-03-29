package com.example.accessingdatamysql.models;

import javax.persistence.*;

@Entity
@Table(name = "order")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer orderID;

    @OneToOne
    @JoinColumn(name = "userID")
    private User buyerID;

    @OneToOne
    @JoinColumn(name = "cardNumber")
    private CardInfo cardNumber;

    private String datetime;

    @OneToOne
    @JoinColumn(name = "addressID")
    private Address receiverAddressID;


}
