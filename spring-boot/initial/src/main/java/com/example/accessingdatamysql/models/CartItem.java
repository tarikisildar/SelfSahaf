package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.ManyToAny;
import org.springframework.data.annotation.Id;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "cart")
public class CartItem {


    @JsonIgnoreProperties("cart")
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("cartUserID")
    @JoinColumn(name = "cartUserID", referencedColumnName = "userID")
    @Id
    private User user;

    @Column
    private Integer amount;
    @Column
    private Product product;


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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
