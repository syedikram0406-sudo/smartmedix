package com.entity.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    @GetMapping("/")
    public String root() {
        return "redirect:/auth/login";
    }

    @GetMapping("/home")
    public String home() {
        return "redirect:/auth/login";
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "WORKING";
    }
}