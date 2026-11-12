package com.luminar.service;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.luminar.entity.Cart;
import com.luminar.entity.CartItem;
import com.luminar.entity.Flower;
import com.luminar.entity.User;
import com.luminar.repository.CartItemRepository;
import com.luminar.repository.CartRepository;
import com.luminar.repository.FlowerRepository;

import jakarta.transaction.Transactional;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final FlowerRepository flowerRepository;

    public CartService(CartRepository cartRepository,
                       CartItemRepository cartItemRepository,
                       FlowerRepository flowerRepository) {
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.flowerRepository = flowerRepository;
    }

    @Transactional
    public Cart getOrCreateCart(User customer) {
        return cartRepository.findByCustomerId(customer.getId())
                .orElseGet(() -> cartRepository.save(new Cart(customer)));
    }

    @Transactional
    public void addToCart(User customer, Long flowerId, int quantity) {
        Cart cart = getOrCreateCart(customer);
        Flower flower = flowerRepository.findById(flowerId)
                .orElseThrow(() -> new RuntimeException("Flower not found"));

        CartItem item = cartItemRepository
                .findByCartIdAndFlowerId(cart.getId(), flowerId)
                .orElseGet(() -> {
                    CartItem ci = new CartItem();
                    ci.setCart(cart);
                    ci.setFlower(flower);
                    ci.setQuantity(0);
                    return ci;
                });

        int newQty = item.getQuantity() + quantity;
        if (newQty > flower.getStockQuantity()) {
            throw new RuntimeException("Only " + flower.getStockQuantity() + " in stock");
        }
        item.setQuantity(newQty);
        cartItemRepository.save(item);
    }

    public List<CartItem> getItems(User customer) {
        return cartRepository.findByCustomerId(customer.getId())
                .map(Cart::getItems)
                .orElse(Collections.emptyList());
    }

    public BigDecimal getTotal(User customer) {
        return getItems(customer).stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    @Transactional
    public void removeItem(Long cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }
}