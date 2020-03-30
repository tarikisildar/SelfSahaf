
package com.example.accessingdatamysql.models;

import com.example.accessingdatamysql.models.embeddedKey.SellsKey;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "sells")
public class Sells {
    @EmbeddedId
    private SellsKey sellerID;

    private Integer quantity;

    @JsonIgnoreProperties("sells")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("productID")
    @JoinColumn(name = "productID", referencedColumnName = "productID")
    private Product product;

    @JsonIgnoreProperties("sells")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("sellerID")
    @JoinColumn(name = "sellerID", referencedColumnName = "userID")
    private User user;

    public SellsKey getSellerID() {
        return sellerID;
    }

    public void setSellerID(SellsKey sellerID) {
        this.sellerID = sellerID;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}

