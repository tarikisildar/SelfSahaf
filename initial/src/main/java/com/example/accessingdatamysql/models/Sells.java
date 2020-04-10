
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



    @JsonIgnoreProperties("sells")
    @OneToMany(mappedBy = "sells", cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private Set<Price> price;

    public Sells() {
    }


    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

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
    public Set<Price> getPrice() {
        return price;
    }

    public void setPrice(Set<Price> price) {
        this.price = price;
    }
}

