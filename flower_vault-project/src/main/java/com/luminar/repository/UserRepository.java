package com.luminar.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.luminar.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
	Optional<User> findByEmail(String email);

	boolean existsByEmail(String email);
}