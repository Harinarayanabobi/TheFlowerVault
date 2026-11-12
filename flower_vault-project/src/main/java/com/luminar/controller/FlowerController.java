package com.luminar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.luminar.entity.Flower;
import com.luminar.service.FlowerService;

@Controller
public class FlowerController {

    private final FlowerService flowerService;

    public FlowerController(FlowerService flowerService) {
        this.flowerService = flowerService;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("flowers", flowerService.findAll());
        return "home";
    }

    @GetMapping("/flower/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Flower flower = flowerService.findById(id);
        model.addAttribute("flower", flower);
        return "flower-detail";
    }
}