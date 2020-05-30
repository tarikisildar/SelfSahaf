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
    @MapsId
    @JoinColumns( {
            @JoinColumn(name = "sellerID", referencedColumnName = "sellerID"),
            @JoinColumn(name = "productID", referencedColumnName = "productID"),

    })
    private Sells sells;


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


}
