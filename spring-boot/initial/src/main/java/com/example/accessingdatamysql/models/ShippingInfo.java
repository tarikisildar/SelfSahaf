package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "shippinginfo")
public class ShippingInfo {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer shippingInfoID;

    private boolean delivered;
    @Column(length = 45)
    private String trackingNumber;

    @OneToOne
    @JoinColumn(name = "shippingCompanyID")
    private ShippingCompany shippingCompanyID;

    public ShippingInfo(){

    }

    public ShippingInfo(Integer shippingInfoID, boolean delivered, String trackingNumber, ShippingCompany shippingCompanyID) {
        this.shippingInfoID = shippingInfoID;
        this.delivered = delivered;
        this.trackingNumber = trackingNumber;
        this.shippingCompanyID = shippingCompanyID;
    }

    public Integer getShippingInfoID() {
        return shippingInfoID;
    }

    public void setShippingInfoID(Integer shippingInfoID) {
        this.shippingInfoID = shippingInfoID;
    }

    public boolean isDelivered() {
        return delivered;
    }

    public void setDelivered(boolean delivered) {
        this.delivered = delivered;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public ShippingCompany getShippingCompanyID() {
        return shippingCompanyID;
    }

    public void setShippingCompanyID(ShippingCompany shippingCompanyID) {
        this.shippingCompanyID = shippingCompanyID;
    }

}
