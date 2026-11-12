package com.luminar.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.luminar.entity.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
	Optional<CartItem> findByCartIdAndFlowerId(Long cartId, Long flowerId);
}