package com.luminar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.luminar.entity.Flower;
import com.luminar.entity.Role;
import com.luminar.entity.User;
import com.luminar.service.FlowerService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/farmer")
public class FarmerController {

    private final FlowerService flowerService;

    public FarmerController(FlowerService flowerService) {
        this.flowerService = flowerService;
    }

    private User currentFarmer(HttpSession session) {
        User u = (User) session.getAttribute("loggedInUser");
        return (u != null && u.getRole() == Role.FARMER) ? u : null;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User farmer = currentFarmer(session);
        if (farmer == null) return "redirect:/login";
        model.addAttribute("flowers", flowerService.findByFarmer(farmer));
        return "farmer/dashboard";
    }

    @PostMapping("/flower/add")
    public String add(@ModelAttribute Flower flower, HttpSession session) {
        User farmer = currentFarmer(session);
        if (farmer == null) return "redirect:/login";
        flower.setFarmer(farmer);
        flowerService.save(flower);
        return "redirect:/farmer/dashboard";
    }

    @GetMapping("/flower/edit/{id}")
    public String editPage(@PathVariable Long id, HttpSession session, Model model) {
        User farmer = currentFarmer(session);
        if (farmer == null) return "redirect:/login";
        Flower flower = flowerService.findById(id);
        if (!flower.getFarmer().getId().equals(farmer.getId())) {
            return "redirect:/farmer/dashboard";
        }
        model.addAttribute("flower", flower);
        return "farmer/edit-flower";
    }

    @PostMapping("/flower/edit/{id}")
    public String edit(@PathVariable Long id,
                       @ModelAttribute Flower form,
                       HttpSession session) {
        User farmer = currentFarmer(session);
        if (farmer == null) return "redirect:/login";
        Flower existing = flowerService.findById(id);
        if (!existing.getFarmer().getId().equals(farmer.getId())) {
            return "redirect:/farmer/dashboard";
        }
        existing.setName(form.getName());
        existing.setDescription(form.getDescription());
        existing.setPrice(form.getPrice());
        existing.setStockQuantity(form.getStockQuantity());
        existing.setImageUrl(form.getImageUrl());
        flowerService.save(existing);
        return "redirect:/farmer/dashboard";
    }

    @GetMapping("/flower/delete/{id}")
    public String delete(@PathVariable Long id, HttpSession session) {
        User farmer = currentFarmer(session);
        if (farmer == null) return "redirect:/login";
        Flower flower = flowerService.findById(id);
        if (flower.getFarmer().getId().equals(farmer.getId())) {
            flowerService.delete(id);
        }
        return "redirect:/farmer/dashboard";
    }
}