package com.example.accessingdatamysql.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.ManyToAny;

import javax.persistence.*;
import java.util.Set;

@Entity // This tells Hibernate to make a table out of this class
@Table(name = "cardInfo")
public class CardInfo {
    @Id

    private String cardNumber;

    private String ownerSurname;
    private String ownerName;

    @JsonIgnoreProperties("cards")
    @ManyToMany(mappedBy = "cards",fetch = FetchType.LAZY)
    private Set<User> users;

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getOwnerSurname() {
        return ownerSurname;
    }

    public void setOwnerSurname(String ownerSurname) {
        this.ownerSurname = ownerSurname;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }
}
