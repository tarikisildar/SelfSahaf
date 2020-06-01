package com.example.accessingdatamysql.controllers;

import com.example.accessingdatamysql.auth.UserDetailsImp;
import com.example.accessingdatamysql.dao.*;
import com.example.accessingdatamysql.models.*;
import com.example.accessingdatamysql.models.enums.OrderStatus;
import com.example.accessingdatamysql.models.enums.ProductStatus;
import com.example.accessingdatamysql.thirdparty.PaypalPayment;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;
import io.swagger.annotations.Api;
import javax.servlet.http.HttpServletResponse;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Controller
@RequestMapping("/order")
@Api(value = "order", description = "Controller about order")
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

    @Autowired
    private ShippingRepository shippingRepository;

    @Autowired
    private ShippingInfoRepository shippingInfoRepository;


    @Autowired
    private UserRepository userRepository;


    @Autowired
    private CartRepository cartRepository;


    private PaypalPayment paypal = PaypalPayment.getInstance();

    @ApiOperation("Confirm Order")
    @PostMapping(path="/confirmOrder")
    @Transactional(rollbackFor=Exception.class)
    public @ResponseBody String confirmOrder(@RequestParam Integer addressID, @RequestParam Integer shippingCompanyID,
                                            @RequestBody CardInfo card, HttpServletResponse response){

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        User user = userRepository.findUserByUserID(userID).get();
        Address address = addressRepository.findAddressByAddressID(addressID).get();
        ShippingCompany shippingCompany = shippingRepository.findShippingCompanyByShippingCompanyID(shippingCompanyID).get();


        Set<CartItem> cart = user.getCart();
        LocalDateTime datetime = LocalDateTime.ofInstant(Instant.now(), ZoneOffset.ofHoursMinutes(3,0));
        String formattedDatetime = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss").format(datetime);




        if(isCartValid(cart)){


                /*validate card if validated return true*/
            System.out.println("Hello");
            if(true) {

                System.out.println("Hello");
                card = cardRepository.save(card);

                ShippingInfo shippingInfo = new ShippingInfo();
                shippingInfo.setShippingCompanyID(shippingCompany);
                shippingInfo.setDelivered(false);
                shippingInfo.setTrackingNumber("0000");

                shippingInfo = shippingInfoRepository.save(shippingInfo);

                System.out.println(user.getUserID());
                System.out.println(card.getCardNumber());


                /*Set<User> userSet = new HashSet<User>();
                userSet.add(user);

                Set<CardInfo> cardSet = new HashSet<CardInfo>();
                cardSet.add(card);*/

                Order order = new Order();
                order.setBuyerID(user);
                order.setCardNumber(card);
                order.setDatetime(formattedDatetime);
                order.setReceiverAddressID(address);

                orderRepository.save(order);

                for (CartItem item : cart) {

                    Sells sells = item.getSells();
                    Product product = sells.getProduct();
                    Integer newQuantity = sells.getQuantity() - item.getAmount();

                    if (product.getStatus() != ProductStatus.ACTIVE) {
                        throw new RuntimeException("Product is not active,  transaction rollback");
                    } else if (newQuantity < 0) {
                        throw new RuntimeException("Not enough stock, transaction rollback");
                    }

                    /* Product Soldout */
                    if (newQuantity == 0) {
                        product.setStatus(ProductStatus.DEACTIVE);
                    }

                    /* Update the product quantity */
                    sells.setQuantity(newQuantity);

                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setQuantity(item.getAmount());
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(product);
                    orderDetail.setUser(sells.getUser());
                    orderDetail.setShippingInfo(shippingInfo);
                    orderDetail.setRefund(OrderStatus.ACTIVE);



                    /*Change refund to enum
                     * throw new RuntimeException("throwing exception to test transaction rollback");*/
                    /*orderDetail.setRefund(0);*/

                    orderDetailRepository.save(orderDetail);
                    productRepository.save(product);
                    sellerRepository.save(sells);
                    cartRepository.deleteByUserIDAndSellID(userID, item.getCartItemID().getSellID());



                }

                return "confirmed";
            }
            else{
                return "Card could not be confirmed";
            }






        }

        return "Cart is not valid.";

    }

    public boolean isCartValid(Set<CartItem> cart){

        for(CartItem item : cart){

            Sells sells = item.getSells();
            Integer amount = item.getAmount();

            if(sells.getProduct().getStatus() != ProductStatus.ACTIVE){
                return false;
            }
            else if (sells.getQuantity() < amount)
            {
                return false;
            }

        }


        return true;

    }


    @ApiOperation("Rate Order")
    @PostMapping(path = "/rateSeller")
    public @ResponseBody String rateSeller(@RequestParam Integer orderID,@RequestParam Integer rating, HttpServletResponse response)
    {
        if(rating < 1 || rating > 5)
        {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return "rating must be between 1 and 5";
        }
        Order order = orderRepository.findById(orderID).get();
        OrderDetail orderDetail = orderDetailRepository.findById(orderID).get();

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer userID = ((UserDetailsImp) auth.getPrincipal()).getUserID();

        if(order.getBuyerID().getUserID() != userID)
        {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return "You can only rate your order";
        }

        User seller = userRepository.findById(orderDetail.getOrderDetailID().getSellerID()).get();
        seller.setRatedCount(seller.getRatedCount()+1);
        seller.setRating(seller.getRating()+rating);
        return "You gave " + rating + " stars to " + seller.getName();
    }

    @ApiOperation("Get Rating of seller")
    @GetMapping(path = "/getRating")
    public @ResponseBody Integer getRating(@RequestParam Integer sellerID)
    {
        User seller = userRepository.findById(sellerID).get();
        return Math.round(seller.getRating()/seller.getRatedCount());
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
