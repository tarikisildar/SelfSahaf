package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "product")
public class Product
{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer productID;
    @Column(length = 255)
    private String description;
    @Column(length = 45)
    private String name;
    @Column(length = 15)
    private String language;
    @Column(length = 45)
    private String author;
    @Column(length = 45)
    private String publisher;
    @Column(length = 45)
    private String ISBN;


    @Column(name = "allPath")
    private String path;

    public Product() {
    }

    public Product(String description, String name, String language, String author, String publisher, String ISBN) {
        this.description = description;
        this.name = name;
        this.language = language;
        this.author = author;
        this.publisher = publisher;
        this.ISBN = ISBN;
    }




    @JsonIgnoreProperties("products")
    @ManyToMany(cascade = CascadeType.MERGE,fetch = FetchType.EAGER)
    @JoinTable(
            name = "productcategory",
            joinColumns = @JoinColumn(name = "productID"),
            inverseJoinColumns = @JoinColumn(name = "categoryID")
    )
    private Set<Category> categories;


    @JsonIgnoreProperties("product")
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL,fetch = FetchType.EAGER)

    private Set<Sells> sells;


    @JsonIgnoreProperties("product")
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    private Set<OrderDetail> orderDetails;

    public String getPath() {
        if(path != null)
            return path;
        else{
            return null;
        }
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Set<Sells> getSells()
    {
        return  sells;
    }

    public void setSells(Set<Sells> sells) {
        this.sells = sells;
    }
    @JsonIgnore
    public Set<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(Set<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public Set<Category> getCategories() {
        return categories;
    }

    public void setCategories(Set<Category> categories) {
        this.categories = categories;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }
}
