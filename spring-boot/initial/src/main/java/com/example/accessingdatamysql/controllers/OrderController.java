package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.dao.*;
import com.example.accessingdatamysql.models.*;
import com.example.accessingdatamysql.models.enums.ProductStatus;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Set;

public class OrderController {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private CardRepository cardRepository;

    @Autowired
    private SellerRepository sellerRepository;


    @ApiOperation("Confirm Order")
    @PostMapping(path="/confirmOrder")
    @Transactional
    public @ResponseBody String confirmOrder(@RequestParam Integer addressID, @RequestParam Integer shippingCompanyID,
                                            @RequestBody CardInfo card, HttpServletResponse response){

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        User user = userRepository.findUserByUserID(userID).get();
        Address address = addressRepository.findAddressByAddressID(addressID).get();
        Set<CartItem> cart = user.getCart();
        LocalDateTime datetime = LocalDateTime.ofInstant(Instant.now(), ZoneOffset.ofHoursMinutes(3,0));
        String formattedDatetime = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss").format(datetime);




        if(isCartValid(cart)){


                /*validate card if validated return true*/

            cardRepository.save(card);

            ShippingInfo shippingInfo = new ShippingInfo();
            shippingInfo.setShippingCompanyID(shippingCompany);


            Order order = new Order();
            order.setBuyerID(user);
            order.setCardNumber(card);
            order.setDatetime(formattedDatetime);
            order.setReceiverAddressID(address);

            for(CartItem item : cart){

                Sells sells = item.getSells();
                Product product = sells.getProduct();
                Integer newQuantity = sells.getQuantity() - item.getAmount();

                if(product.status != ProductStatus.ACTIVE){
                    throw new RuntimeException("Product is not active,  transaction rollback");
                }
                else if (newQuantity < 0)
                {
                    throw new RuntimeException("Not enough stock, transaction rollback");
                }

                /* Product Soldout */
                if(newQuantity == 0){
                    product.setStatus(ProductStatus.DEACTIVE);
                }

                /* Update the product quantity */
                sells.setQuantity(newQuantity);

                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setQuantity(item.getAmount());
                orderDetail.setOrder(order);
                orderDetail.setProduct(product);
                orderDetail.setUser(sells.getUser());
                orderDetail.setShippingInfo();


                /*Change refund to enum
                * throw new RuntimeException("thowing exception to test transaction rollback");*/
                /*orderDetail.setRefund(0);*/

                orderDetailRepository.save(orderDetail);
                productRepository.save(product);
                sellerRepository.save(sells);



            }

            orderRepository.save(order);

            return "confirmed";


        }


    }

    public boolean isCartValid(Set<CartItem> cart){

        for(CartItem item : cart){

            Sells sells = item.getSells();
            Integer amount = item.getAmount();

            if(sells.getProduct().status != ProductStatus.ACTIVE){
                return false;
            }
            else if (sells.getQuantity() < amount)
            {
                return false;
            }

        }


        return true;

    }





    @ApiOperation("Get given orders")
    @GetMapping(path="/givenOrders")
    public @ResponseBody Iterable<Order> getGivenOrders()
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Get taken orders")
    @GetMapping(path="/takenOrders")
    public @ResponseBody Iterable<Order> getTakenOrders()
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Cancel Order")
    @PostMapping(path="/cancel")
    public @ResponseBody String cancelOrder(@RequestParam Integer orderID)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Change Address")
    @PostMapping(path="/updateAddress")
    public @ResponseBody String updateAddress(@RequestParam Integer orderID, Address address)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Return Request")
    @PostMapping(path="/returnRequest")
    public @ResponseBody String returnRequest(@RequestParam Integer orderID, List<MultipartFile> file, String message)
    {
        throw new NotImplementedException();
    }

    @ApiOperation("Return Request")
    @PostMapping(path="/returnConfirm")
    public @ResponseBody String confirmReturnRequest(@RequestParam Integer orderID, String message, boolean confirm)
    {
        throw new NotImplementedException();
    }
}
