package com.example.accessingdatamysql.models;

import com.example.accessingdatamysql.models.embeddedKey.CartItemKey;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.ManyToAny;
import org.springframework.data.annotation.Id;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "cart")
public class CartItem {



    @EmbeddedId
    private CartItemKey cartItemID;

    @Column
    private Integer amount;



    @JsonIgnoreProperties("cart")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("cartUserID")
    @JoinColumn(name = "cartUserID", referencedColumnName = "userID")
    private User user;



    @JsonIgnoreProperties("cart")
    @ManyToOne(fetch = FetchType.LAZY)

    @JoinColumns( {
            @JoinColumn(name = "sellerID", referencedColumnName = "sellerID", insertable = false, updatable = false),
            @JoinColumn(name = "productID", referencedColumnName = "productID", insertable = false, updatable = false)

    })
    private Sells sells;

    public CartItem() {

    }

    public CartItem(User user, Sells sells) {
        this.user = user;
        this.sells = sells;
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Sells getSells() {
        return sells;
    }

    public void setSells(Sells sells) {
        this.sells = sells;
    }

}
