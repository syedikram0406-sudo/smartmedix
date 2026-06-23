package com.entity.controller;

import com.entity.model.Payment;
import com.entity.service.PaymentService;
import com.entity.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminPaymentController {

    @Autowired
    private PaymentService paymentService;

    @GetMapping("/transactions")
    public String viewAllTransactions(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";

        List<Payment> transactions = paymentService.findAll();
        
        double totalRevenue = transactions.stream().mapToDouble(Payment::getAmountPaid).sum();
        double consultationRevenue = transactions.stream()
            .filter(t -> "CONSULTATION".equalsIgnoreCase(t.getBill().getServiceType()))
            .mapToDouble(Payment::getAmountPaid).sum();
        double technicianRevenue = transactions.stream()
            .filter(t -> "LAB".equalsIgnoreCase(t.getBill().getServiceType()))
            .mapToDouble(Payment::getAmountPaid).sum();

        model.addAttribute("transactions", transactions);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("consultationRevenue", consultationRevenue);
        model.addAttribute("technicianRevenue", technicianRevenue);
        
        return "admin/transactions";
    }

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("role"));
    }
}
