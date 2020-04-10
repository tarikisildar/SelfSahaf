package com.example.accessingdatamysql.Services;

import com.example.accessingdatamysql.dao.ProductRepository;
import com.example.accessingdatamysql.models.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public class ProductService {
    @Autowired
    ProductRepository productRepository;

    public Iterable<Product> getAll(Integer pageNo, Integer pageSize, String sortBy)
    {
        Pageable paging = PageRequest.of(pageNo, pageSize, Sort.by(sortBy));

        Page<Product> pagedResult = productRepository.findAll(paging);

        if(pagedResult.hasContent()) {
            return pagedResult.getContent();
        }
        else{
            return null;
        }
    }
}
