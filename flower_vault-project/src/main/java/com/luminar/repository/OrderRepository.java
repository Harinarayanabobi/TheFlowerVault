package com.luminar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.luminar.entity.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByCustomerIdOrderByIdDesc(Long customerId);

    // Fetch distinct orders that contain at least one item belonging to this farmer
    @Query("SELECT DISTINCT o FROM Order o JOIN o.items i WHERE i.flower.farmer.id = :farmerId ORDER BY o.id DESC")
    List<Order> findOrdersByFarmerId(@Param("farmerId") Long farmerId);
}