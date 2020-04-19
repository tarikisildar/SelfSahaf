package com.example.accessingdatamysql.models;

import com.example.accessingdatamysql.models.embeddedKey.PriceKey;
import com.example.accessingdatamysql.models.embeddedKey.RatingKey;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;

@Entity
@Table(name = "ratings")
public class Ratings {

    @EmbeddedId
    private RatingKey ratingID;

    @JsonIgnoreProperties("ratings")
    @ManyToOne
    @JoinColumns(
            {
                    @JoinColumn(updatable=false,insertable=false, name="receiver", referencedColumnName="sellerID"),
                    @JoinColumn(updatable=false,insertable=false, name="productID", referencedColumnName="productID"),

            })
    private OrderDetail orderDetail;



    @JsonIgnoreProperties("ratings")
    @ManyToOne
    @JoinColumn(updatable=false,insertable=false, name="raterID", referencedColumnName="buyerID")
    private Order order;

    private String datetime;
    private Integer rating;
    @Column(length = 255)
    private String comment;



    public RatingKey getRatingID() {
        return ratingID;
    }

    public void setRatingID(RatingKey ratingID) {
        this.ratingID = ratingID;
    }

    public OrderDetail getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(OrderDetail orderDetail) {
        this.orderDetail = orderDetail;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }



}

