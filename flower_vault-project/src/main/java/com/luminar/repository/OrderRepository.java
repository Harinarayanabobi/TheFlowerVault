package com.luminar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.luminar.entity.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
	List<Order> findByCustomerIdOrderByIdDesc(Long customerId);
}