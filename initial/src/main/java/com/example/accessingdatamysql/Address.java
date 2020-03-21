
package com.example.accessingdatamysql;

import javax.jws.soap.SOAPBinding;
import javax.persistence.*;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "address")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressID;
/*    public PostalCodeCity getPostalCodeCity() {
        return postalCodeCity;
    }

    public void setPostalCodeCity(PostalCodeCity postalCodeCity) {
        this.postalCodeCity = postalCodeCity;
    }*/




/*@OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "addressID")
    private User user;*//*


    */
/*@OneToOne
    @JoinColumn(name = "city")
    private PostalCodeCity postalCodeCity;*//*

*/
    private String postalCode;
    private String addressLine;

    public Address() {
    }

    public Address(String postalCode, String addressLine) {
        this.postalCode = postalCode;
        this.addressLine = addressLine;
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

    public Integer getAddressID() {
        return addressID;
    }

    public void setAddressID(Integer addressID) {
        this.addressID = addressID;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

}

