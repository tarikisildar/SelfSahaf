/*
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
    @OneToMany(mappedBy = "sells",fetch = FetchType.LAZY)
    private Set<Product> products;

    @JsonIgnoreProperties("sells")
    @OneToMany(mappedBy = "sells",fetch = FetchType.LAZY)
    private Set<User> users;

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
*/
