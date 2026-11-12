package com.luminar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luminar.entity.Order;
import com.luminar.entity.User;
import com.luminar.service.CartService;
import com.luminar.service.OrderService;

import jakarta.servlet.http.HttpSession;

@Controller
public class CheckoutController {

    private final CartService cartService;
    private final OrderService orderService;

    public CheckoutController(CartService cartService, OrderService orderService) {
        this.cartService = cartService;
        this.orderService = orderService;
    }

    private User currentUser(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }

    @GetMapping("/checkout")
    public String checkoutPage(HttpSession session, Model model) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        if (cartService.getItems(user).isEmpty()) return "redirect:/cart/view";
        model.addAttribute("cartTotal", cartService.getTotal(user));
        return "checkout";
    }

    @PostMapping("/checkout")
    public String placeOrder(@RequestParam String name,
                             @RequestParam String phone,
                             @RequestParam String address,
                             HttpSession session) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        Order order = orderService.placeOrder(user, name, phone, address);
        return "redirect:/order/confirmation/" + order.getId();
    }

    @GetMapping("/order/confirmation/{id}")
    public String confirmation(@PathVariable Long id, HttpSession session, Model model) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        Order order = orderService.findById(id);
        if (!order.getCustomer().getId().equals(user.getId())) {
            return "redirect:/";
        }
        model.addAttribute("order", order);
        return "order-confirmation";
    }

    @GetMapping("/orders")
    public String myOrders(HttpSession session, Model model) {
        User user = currentUser(session);
        if (user == null) return "redirect:/login";
        model.addAttribute("orders", orderService.findByCustomer(user));
        return "my-orders";
    }
}