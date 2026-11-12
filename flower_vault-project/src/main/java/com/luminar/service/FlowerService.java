package com.luminar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.luminar.entity.Flower;
import com.luminar.entity.User;
import com.luminar.repository.FlowerRepository;

@Service
public class FlowerService {

    private final FlowerRepository flowerRepository;

    public FlowerService(FlowerRepository flowerRepository) {
        this.flowerRepository = flowerRepository;
    }

    public List<Flower> findAll() {
        return flowerRepository.findAllByOrderByIdDesc();
    }

    public Flower findById(Long id) {
        return flowerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Flower not found"));
    }

    public List<Flower> findByFarmer(User farmer) {
        return flowerRepository.findByFarmerOrderByIdDesc(farmer);
    }

    public Flower save(Flower flower) {
        return flowerRepository.save(flower);
    }

    public void delete(Long id) {
        flowerRepository.deleteById(id);
    }
}