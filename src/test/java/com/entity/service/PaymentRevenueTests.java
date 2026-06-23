package com.entity.service;

import com.entity.model.Bill;
import com.entity.model.Payment;
import com.entity.repository.PaymentRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

class PaymentRevenueTests {

    @Mock
    private PaymentRepository paymentRepository;

    @InjectMocks
    private PaymentService paymentService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetRevenueBreakdown() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime start = now.minusDays(30);

        Bill bill1 = new Bill();
        bill1.setServiceType("CONSULTATION");
        Payment p1 = new Payment();
        p1.setBill(bill1);
        p1.setAmountPaid(100.0);
        p1.setStatus("SUCCESS");

        Bill bill2 = new Bill();
        bill2.setServiceType("LAB");
        Payment p2 = new Payment();
        p2.setBill(bill2);
        p2.setAmountPaid(50.0);
        p2.setStatus("SUCCESS");

        Bill bill3 = new Bill();
        bill3.setServiceType("CONSULTATION");
        Payment p3 = new Payment();
        p3.setBill(bill3);
        p3.setAmountPaid(75.0);
        p3.setStatus("SUCCESS");

        when(paymentRepository.findByStatusAndPaymentDateBetween(eq("SUCCESS"), any(), any()))
                .thenReturn(Arrays.asList(p1, p2, p3));

        Map<String, Double> breakdown = paymentService.getRevenueBreakdown(start, now);

        assertEquals(2, breakdown.size());
        assertEquals(175.0, breakdown.get("CONSULTATION"));
        assertEquals(50.0, breakdown.get("LAB"));
    }
}
