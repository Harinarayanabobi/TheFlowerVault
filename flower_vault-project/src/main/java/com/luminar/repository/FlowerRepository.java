package com.luminar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.luminar.entity.Flower;
import com.luminar.entity.User;

public interface FlowerRepository extends JpaRepository<Flower, Long> {
	List<Flower> findByFarmerOrderByIdDesc(User farmer);

	List<Flower> findAllByOrderByIdDesc();
}