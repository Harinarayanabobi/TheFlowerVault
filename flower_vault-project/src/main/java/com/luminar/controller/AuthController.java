package com.luminar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luminar.entity.Role;
import com.luminar.entity.User;
import com.luminar.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage() { return "login"; }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        User user = userService.authenticate(email, password);
        if (user == null) {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
        session.setAttribute("loggedInUser", user);
        return user.getRole() == Role.FARMER
                ? "redirect:/farmer/dashboard"
                : "redirect:/";
    }

    @GetMapping("/register")
    public String registerPage() { return "register"; }

    @PostMapping("/register")
    public String register(@RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String password,
                           @RequestParam(defaultValue = "CUSTOMER") String role,
                           Model model) {
        try {
            userService.register(name, email, password, Role.valueOf(role.toUpperCase()));
            return "redirect:/login?registered=true";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}