package com.luminar.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import com.luminar.entity.Cart;
import com.luminar.entity.CartItem;
import com.luminar.entity.Flower;
import com.luminar.entity.Order;
import com.luminar.entity.OrderItem;
import com.luminar.entity.User;
import com.luminar.repository.CartRepository;
import com.luminar.repository.FlowerRepository;
import com.luminar.repository.OrderRepository;

import jakarta.transaction.Transactional;

@Service
public class OrderService {

    private final CartRepository cartRepository;
    private final FlowerRepository flowerRepository;
    private final OrderRepository orderRepository;

    public OrderService(CartRepository cartRepository,
                        FlowerRepository flowerRepository,
                        OrderRepository orderRepository) {
        this.cartRepository = cartRepository;
        this.flowerRepository = flowerRepository;
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order placeOrder(User customer, String name, String phone, String address) {
        Cart cart = cartRepository.findByCustomerId(customer.getId())
                .orElseThrow(() -> new RuntimeException("No cart for user"));

        if (cart.getItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        Order order = new Order();
        order.setCustomer(customer);
        order.setDeliveryName(name);
        order.setDeliveryPhone(phone);
        order.setDeliveryAddress(address);
        order.setStatus("PLACED");

        BigDecimal total = BigDecimal.ZERO;

        for (CartItem ci : cart.getItems()) {
            Flower f = ci.getFlower();
            if (f.getStockQuantity() < ci.getQuantity()) {
                throw new RuntimeException("Insufficient stock for " + f.getName());
            }

            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setFlower(f);
            oi.setQuantity(ci.getQuantity());
            oi.setUnitPrice(f.getPrice());
            order.getItems().add(oi);

            f.setStockQuantity(f.getStockQuantity() - ci.getQuantity());
            flowerRepository.save(f);

            total = total.add(f.getPrice().multiply(BigDecimal.valueOf(ci.getQuantity())));
        }

        order.setTotalAmount(total);
        Order saved = orderRepository.save(order);

        // clear cart (orphanRemoval deletes cart_items)
        cart.getItems().clear();
        cartRepository.save(cart);

        return saved;
    }

    public Order findById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    public List<Order> findByCustomer(User customer) {
        return orderRepository.findByCustomerIdOrderByIdDesc(customer.getId());
    }
    
    public List<Order> findOrdersByFarmer(User farmer) {
        return orderRepository.findOrdersByFarmerId(farmer.getId());
    }

    @Transactional
    public void updateStatus(Long orderId, String status) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(status);
        orderRepository.save(order);
    }
}