package com.example.accessingdatamysql.models.embeddedKey;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class CartItemKey implements Serializable {



    @Column
    private Integer cartUserID;


    @Column
    private Integer productID;


    @Column
    private Integer sellerID;



    public CartItemKey(){

    }

    public CartItemKey(Integer userID, Integer productID, Integer sellerID){

        this.cartUserID = userID;
        this.productID = productID;
        this.sellerID = sellerID;

    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof CartItemKey)) return false;
        CartItemKey that = (CartItemKey) o;
        return Objects.equals(getCartUserID(), that.getCartUserID()) &&
                Objects.equals(getProductID(), that.getProductID()) &&
                Objects.equals(getSellerID(), that.getSellerID());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getCartUserID(), getProductID(), getSellerID());
    }


    public Integer getSellerID() {
        return sellerID;
    }

    public void setSellerID(Integer sellerID) {
        this.sellerID = sellerID;
    }

    public Integer getCartUserID() {
        return cartUserID;
    }

    public void setCartUserID(Integer cartUserID) {
        this.cartUserID = cartUserID;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }


}
