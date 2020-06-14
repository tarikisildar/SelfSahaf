package com.example.accessingdatamysql;


import com.example.accessingdatamysql.dao.ProductRepository;
import com.example.accessingdatamysql.dao.ProductRepositoryWithoutPage;
import com.example.accessingdatamysql.dao.UserRepository;
import com.example.accessingdatamysql.models.Product;
import com.example.accessingdatamysql.models.Sells;
import com.example.accessingdatamysql.models.User;
import com.example.accessingdatamysql.models.enums.ProductCondition;
import com.example.accessingdatamysql.models.enums.ProductStatus;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.junit4.SpringRunner;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;
import com.google.common.hash.Hashing;

import static org.junit.Assert.assertTrue;

@RunWith(SpringRunner.class)
@DataJpaTest
public class ProductRepositoryIntegrationTest {


    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private ProductRepository productRepository;


    @Test
    public void whenFindBySellerID_thenReturnProduct(){

        String passSha;


        passSha = Hashing.sha256().hashString("12345", StandardCharsets.UTF_8).toString();

        User onur = new User("onur", passSha, "soyad","2020-20-20", "5555555", "abc@abc.mail");

        entityManager.persist(onur);
        entityManager.flush();

        String description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
        String name = "Test Book";
        String language = "türkçe";
        String author = "John Doe";
        String publisher = "John doe";
        String ISBN = "978-3-16-148410-0";
        ProductCondition condition = ProductCondition.SECONDHAND;
        ProductStatus status = ProductStatus.ACTIVE;
        Product book = new Product(description, name, language, author,
                publisher, ISBN, condition,  status);

        entityManager.persist(book);
        entityManager.flush();


        Sells sell = new Sells();
        sell.setProductID(book.getProductID());
        sell.setSellerID(onur.getUserID());
        sell.setQuantity(1);
        sell.setCurrentPrice(1.0);


        entityManager.persist(sell);
        entityManager.flush();

        Sort.Direction direction = Sort.Direction.ASC;
        Pageable paging = PageRequest.of(0, 10);

        Page<Product> found = productRepository.findAllActive(ProductStatus.ACTIVE, paging);


        assertTrue(found.toList().size() > 0);

    }


}
