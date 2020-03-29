package com.example.accessingdatamysql.models;

import javax.persistence.*;

@Entity
@Table(name = "shippinginfo")
public class ShippingInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer shippingInfoID;

    private boolean delivered;

    private String trackingNumber;

    @OneToOne
    @JoinColumn(name = "shippingCompanyID")
    private ShippingCompany shippingCompanyID;


}
