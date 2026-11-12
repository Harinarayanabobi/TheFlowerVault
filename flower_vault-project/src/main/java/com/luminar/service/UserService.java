package com.luminar.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.luminar.entity.Role;
import com.luminar.entity.User;
import com.luminar.repository.UserRepository;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	public User register(String name, String email, String rawPassword, Role role) {
		if (userRepository.existsByEmail(email)) {
			throw new RuntimeException("Email already registered");
		}
		User user = new User();
		user.setName(name);
		user.setEmail(email);
		user.setPassword(passwordEncoder.encode(rawPassword));
		user.setRole(role);
		return userRepository.save(user);
	}

	public User authenticate(String email, String rawPassword) {
		return userRepository.findByEmail(email).filter(u -> passwordEncoder.matches(rawPassword, u.getPassword()))
				.orElse(null);
	}

	public boolean emailExists(String email) {
		return userRepository.existsByEmail(email);
	}
}