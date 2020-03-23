
package com.example.accessingdatamysql.models;

import javax.persistence.*;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "address")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressID;
/*    public PostalCode getPostalCodeCity() {
        return postalCodeCity;
    }

    public void setPostalCodeCity(PostalCode postalCodeCity) {
        this.postalCodeCity = postalCodeCity;
    }*/




/*@OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "addressID")
    private User user;*//*


    */
/*@OneToOne
    @JoinColumn(name = "city")
    private PostalCode postalCodeCity;*//*

*/
    private String addressName;
    private String addressLine;
    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name = "postalCode")
    private PostalCode postalCode;

    public PostalCode getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(PostalCode postalCode) {
        this.postalCode = postalCode;
    }

    public Address() {
    }

    public Address(String addressLine) {
        this.addressLine = addressLine;
    }

    public Address(String addressLine, PostalCode postalCode) {
        this.addressLine = addressLine;
        this.postalCode= postalCode;
    }

/*
    @OneToOne(mappedBy = "sellerAddressID")
    public User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
*/

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }

    public Integer getAddressID() {
        return addressID;
    }

    public void setAddressID(Integer addressID) {
        this.addressID = addressID;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

}

