package com.example.accessingdatamysql.models;

import com.example.accessingdatamysql.models.embeddedKey.PriceKey;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name = "price")
public class Price {

    @EmbeddedId
    private PriceKey priceID;




    @JsonIgnoreProperties("prices")
    @ManyToOne

    @JoinColumns(
            {
                    @JoinColumn(updatable=false,insertable=false, name="sellerID", referencedColumnName="sellerID"),
                    @JoinColumn(updatable=false,insertable=false, name="productID", referencedColumnName="productID"),
            })
    private Sells seller;



    private Integer price;



    public PriceKey getPriceID() {
        return priceID;
    }

    public void setPriceID(PriceKey priceID) {
        this.priceID = priceID;
    }


    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Sells getSeller() {
        return seller;
    }

    public void setSeller(Sells seller) {
        this.seller = seller;
    }


}
