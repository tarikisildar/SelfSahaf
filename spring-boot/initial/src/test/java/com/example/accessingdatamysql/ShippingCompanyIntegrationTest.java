package com.example.accessingdatamysql;

import com.example.accessingdatamysql.dao.ShippingRepository;
import com.example.accessingdatamysql.dao.UserRepository;
import com.example.accessingdatamysql.models.ShippingCompany;
import com.example.accessingdatamysql.models.User;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.context.junit4.SpringRunner;

import java.nio.charset.StandardCharsets;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@DataJpaTest
public class ShippingCompanyIntegrationTest {



    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private ShippingRepository shippingRepository;


    @Test
    public void whenFindByCompanyName_thenReturnCompany(){

        String companyName = "John Doe Enterprise";
        float price = (float) 5.1;
        String website = "www.john-doe.com";
        ShippingCompany company = new ShippingCompany(companyName, price, website);

        entityManager.persist(company);
        entityManager.flush();


        Optional<ShippingCompany> found = shippingRepository.findShippingCompanyByCompanyName(company.getCompanyName());


        assertThat(found.get().getCompanyName()).isEqualTo(company.getCompanyName());
    }




}
