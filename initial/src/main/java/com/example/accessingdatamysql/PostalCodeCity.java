/*
package com.example.accessingdatamysql;
import javax.persistence.*;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "postalcodecity")
public class PostalCodeCity {

 public CityCountry getCityCountry() {
         return cityCountry;
     }

     public void setCityCountry(CityCountry cityCountry) {
         this.cityCountry = cityCountry;
     }
    @OneToOne
    @JoinColumn(name = "city")
    private CityCountry cityCountry;


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String postalCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    private String city;

    @OneToOne(mappedBy = "postalCodeCity")
    private Address address;

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
*/
