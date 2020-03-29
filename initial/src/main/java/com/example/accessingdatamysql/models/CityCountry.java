/*

package com.example.accessingdatamysql;
import javax.persistence.*;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "citycountry")
public class CityCountry {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String city;
    private String country;

    @OneToOne(mappedBy = "city")
    private PostalCodeCity postalCodeCity;


    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public PostalCodeCity getPostalCodeCity() {
        return postalCodeCity;
    }

    public void setPostalCodeCity(PostalCodeCity postalCodeCity) {
        this.postalCodeCity = postalCodeCity;
    }
}

*/
