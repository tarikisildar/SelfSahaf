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
    private CartItemKey cartItemID = new CartItemKey();

    @Column
    private Integer amount;



    @JsonIgnoreProperties("cart")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("cartUserID")
    @JoinColumn(name = "cartUserID", referencedColumnName = "userID")
    private User user;


    @JsonIgnoreProperties("cart")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("productID")
    @JoinColumn(name = "productID", referencedColumnName = "productID")
    private Product product;

    public CartItem() {
    }

    public CartItem(Integer amount, User user, Product product) {
        this.amount = amount;
        this.setUser(user);
        this.setProduct(product);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public CartItemKey getCartItemID() {
        return cartItemID;
    }

    public void setCartItemID(CartItemKey cartItemID) {
        this.cartItemID = cartItemID;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
