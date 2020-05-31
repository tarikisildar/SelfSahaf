package com.example.accessingdatamysql.storage;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;


public interface StorageService {

    void init();

    String storeAll(List<MultipartFile> files, Integer productID, Integer sellerID);

    String storeMain(MultipartFile file, Integer productID, Integer sellerID);



    String store(MultipartFile file, String path);

    Stream<Path> loadAll();

    Path load(String filename);

    Resource loadAsResource(String filename);

    void deleteAll();

    List<Resource> loadAllResources(String productID, String sellerID);

}