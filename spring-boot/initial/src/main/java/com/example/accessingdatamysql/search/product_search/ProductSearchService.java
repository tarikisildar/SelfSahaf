package com.example.accessingdatamysql.search.product_search;

import com.example.accessingdatamysql.models.Product;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.Query;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.hibernate.search.query.engine.spi.FacetManager;
import org.hibernate.search.query.facet.Facet;
import org.hibernate.search.query.facet.FacetSelection;
import org.hibernate.search.query.facet.FacetingRequest;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class ProductSearchService {

    // TODO: Instead of reindexing every time an API called, can check if the data changed.

    @PersistenceContext
    private EntityManager entityManager;

    public List<Product> findProductByName(String name, int pageNo, int pageSize) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
            System.out.println(e.fillInStackTrace());
        }

        QueryBuilder queryBuilder = fullTextEntityManager
                .getSearchFactory()
                .buildQueryBuilder().forEntity(Product.class)
                .overridesForField( "name", "edgeNGram_query" )
                .get();

        org.apache.lucene.search.Query query = queryBuilder
                .keyword()
                .onFields("name", "author")
                .matching(name)
                .createQuery();

        // wrap Lucene query in a javax.persistence.Query
        javax.persistence.Query jpaQuery =
                fullTextEntityManager.createFullTextQuery(query, Product.class);

        System.out.println(jpaQuery.getResultList().size());
        jpaQuery.setFirstResult(pageNo * pageSize); // Page size starts at 0.
        jpaQuery.setMaxResults(pageSize);

        // execute search
        return jpaQuery.getResultList();
    }

    public List<Product> findProductByCategory(String category, int pageNo, int pageSize) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
            System.out.println(e.fillInStackTrace());
        }

        QueryBuilder queryBuilder = fullTextEntityManager
                .getSearchFactory()
                .buildQueryBuilder().forEntity(Product.class)
                .get();

        org.apache.lucene.search.Query query = queryBuilder
                .keyword()
                .onField("categories.name")
                .matching(category)
                .createQuery();

        // wrap Lucene query in a javax.persistence.Query
        javax.persistence.Query jpaQuery =
                fullTextEntityManager.createFullTextQuery(query, Product.class);

        System.out.println(jpaQuery.getResultList().size());
        jpaQuery.setFirstResult(pageNo * pageSize); // Page size starts at 0.
        jpaQuery.setMaxResults(pageSize);

        return jpaQuery.getResultList();

    }

    public List<Product> findProductByLanguage(String language, int pageNo, int pageSize) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
            System.out.println(e.fillInStackTrace());
        }

        QueryBuilder queryBuilder = fullTextEntityManager
                .getSearchFactory()
                .buildQueryBuilder().forEntity(Product.class)
                .get();

        Query query = queryBuilder
                .keyword()
                .onField("language")
                .matching(language)
                .createQuery();

        javax.persistence.Query jpaQuery =
                fullTextEntityManager.createFullTextQuery(query, Product.class);

        System.out.println(jpaQuery.getResultList().size());
        jpaQuery.setFirstResult(pageNo * pageSize); // Page size starts at 0.
        jpaQuery.setMaxResults(pageSize);

        return jpaQuery.getResultList();

    }

    public List<Product> findProductByPriceRange(double from, double to, int pageNo, int pageSize) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
            System.out.println(e.fillInStackTrace());
        }

        QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder()
                .forEntity(Product.class).get();

        FacetingRequest priceFacetingRequest = queryBuilder.facet()
                .name("priceFaceting")
                .onField("sells.currentPrice")
                .range()
                .from(from).to(to)
                .excludeLimit()
                .createFacetingRequest();

        Query luceneQuery = queryBuilder.all().createQuery(); // match all query
        FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(luceneQuery, Product.class);

        FacetManager facetManager = fullTextQuery.getFacetManager();
        facetManager.enableFaceting(priceFacetingRequest);

        List<Facet> facets = facetManager.getFacets("priceFaceting");

        FacetSelection facetSelection = facetManager.getFacetGroup( "priceFaceting" );
        facetSelection.selectFacets(facets.get(0));

        fullTextQuery.setFirstResult(pageNo * pageSize); // Page size starts at 0.
        fullTextQuery.setMaxResults(pageSize);
        System.out.println(fullTextQuery.getResultList().size());
        return fullTextQuery.getResultList();

    }

    public List<Product> findProductByISBN(String isbn, int pageNo, int pageSize) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(entityManager);
        try {
            fullTextEntityManager.createIndexer().startAndWait();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
            System.out.println(e.fillInStackTrace());
        }

        QueryBuilder queryBuilder = fullTextEntityManager
                .getSearchFactory()
                .buildQueryBuilder().forEntity(Product.class)
                .get();

        Query query = queryBuilder
                .keyword()
                .onField("ISBN")
                .matching(isbn)
                .createQuery();

        javax.persistence.Query jpaQuery =
                fullTextEntityManager.createFullTextQuery(query, Product.class);

        System.out.println(jpaQuery.getResultList().size());
        jpaQuery.setFirstResult(pageNo * pageSize); // Page size starts at 0.
        jpaQuery.setMaxResults(pageSize);

        return jpaQuery.getResultList();

    }
}
