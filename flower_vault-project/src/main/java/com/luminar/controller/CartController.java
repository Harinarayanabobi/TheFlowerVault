package com.luminar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luminar.entity.User;
import com.luminar.service.CartService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    private User currentUser(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }

    @GetMapping("/view")
    public String view(HttpSession session, Model model) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("cartItems", cartService.getItems(user));
        model.addAttribute("cartTotal", cartService.getTotal(user));
        return "cart";
    }

    @PostMapping("/add")
    public String add(@RequestParam Long flowerId,
                      @RequestParam(defaultValue = "1") int quantity,
                      HttpSession session) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        try {
            cartService.addToCart(user, flowerId, quantity);
        } catch (RuntimeException e) {
            // in a real app: flash message
            return "redirect:/flower/" + flowerId + "?error=" + e.getMessage();
        }
        return "redirect:/cart/view";
    }

    @GetMapping("/remove/{id}")
    public String remove(@PathVariable Long id, HttpSession session) {
        if (currentUser(session) == null) return "redirect:/login";
        cartService.removeItem(id);
        return "redirect:/cart/view";
    }
}