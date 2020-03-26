package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import javax.persistence.*;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "user")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userID;

    private String name;

    private String password;

    private String surname;

    private String dob;

    private String phoneNumber;

    private String email;

    private int isAdmin;

    public User(){

    }

    public User(String name, String password, String surname, String dob, String phoneNumber, String email) {
        this.name = name;
        this.password = password;
        this.surname = surname;
        this.dob = dob;
        this.phoneNumber = phoneNumber;
        this.email = email;
    }

    @OneToOne
    @JoinColumn(name = "sellerAddressID")
    private Address sellerAddressID;

    @JsonIgnoreProperties("users")
    @ManyToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinTable(
            name = "cardowner",
            joinColumns = @JoinColumn(name = "userID"),
            inverseJoinColumns = @JoinColumn(name = "cardnumber")
    )
    private Set<CardInfo> cards;
/*

    @JsonIgnoreProperties("users")
    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinTable(
            name = "sells",
            joinColumns = @JoinColumn(name = "userID"),
            inverseJoinColumns = @JoinColumn(name = "sellerID")
    )
    private Set<Sells> sells;
    public Set<CardInfo> getCards() {
        return cards;
    }
*/

    @OneToMany(cascade = CascadeType.ALL)
    @JoinTable(
            name = "useraddress",
            joinColumns = @JoinColumn(name = "userID"),
            inverseJoinColumns = @JoinColumn(name = "addressID")
    )
    private Set<Address> addresses;

    public void setCards(Set<CardInfo> cards) {
        this.cards = cards;
    }
/*

    public Set<Sells> getSells() {
        return sells;
    }

    public void setSells(Set<Sells> sells) {
        this.sells = sells;
    }
*/

    public Set<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(Set<Address> addresses) {
        this.addresses = addresses;
    }

    public Address getSellerAddressID() {
        return sellerAddressID;
    }

    public void setSellerAddressID(Address sellerAddressID) {
        this.sellerAddressID = sellerAddressID;
    }


    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }
    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

}