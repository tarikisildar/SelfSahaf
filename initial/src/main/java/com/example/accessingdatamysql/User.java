package com.example.accessingdatamysql;

import javax.persistence.*;

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

    @OneToOne
    @JoinColumn(name = "sellerAddressID")
    private Address sellerAddressID;


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

    public void setSurName(String surname) {
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

    public void setDoB(String DoB) {
        this.dob = dob;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNumber = phoneNumber;
    }


}