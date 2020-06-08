
package com.example.accessingdatamysql.models;

import com.example.accessingdatamysql.models.embeddedKey.PriceKey;
import com.example.accessingdatamysql.models.embeddedKey.SellsKey;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.search.annotations.*;

import javax.persistence.*;
import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Set;

@Indexed
@Entity // This tells Hibernate to make a table out of this class
@Table(name = "sells")
public class Sells implements Serializable{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer sellingID;



    private Integer quantity;

    private Integer sellerID;


    private Integer productID;



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
    private Set<CartItem> cart;

    @Field(analyze = Analyze.NO)
    @Facet(forField = "currentPrice", encoding = FacetEncodingType.DOUBLE)
    private Double currentPrice;

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

    public User getUser() {return user;}

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getSellerID() {
        return sellerID;
    }
    public Integer getProductID() {
        return productID;
    }


    public Integer getSellingID() {
        return sellingID;
    }

    public void setSellingID(Integer sellingID) {
        this.sellingID = sellingID;
    }

    public void setSellerID(Integer sellerID) {
        this.sellerID = sellerID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }


    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    @JsonIgnore
    public Set<Price> getPriceList() {
        return price;
    }

    public Double getPrice() {
        String date = LocalDateTime.MIN.toString();
        Price tempPrice = null;
        Double discount;
        for (Price p : price) {

            if (p.getPriceID().getDatetime().compareTo(date) > 0) {
                tempPrice = p;
                date = tempPrice.getDate();
            }
        }
        if(tempPrice != null) {


            discount = tempPrice.getDiscount() / 100.;
            setCurrentPrice(tempPrice.getPrice());
            return tempPrice.getPrice() * (1 - discount);
        }
        else
            return null;
    }
    @JsonIgnore
    public Set<CartItem> getCart() {
        return cart;
    }
    @JsonIgnore
    public void setCart(Set<CartItem> cart) {
        this.cart = cart;
    }

    public void setPrice(Set<Price> price) {
        this.price = price;
    }

    public Double getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(Double currentPrice) {
        this.currentPrice = currentPrice;
    }
}




