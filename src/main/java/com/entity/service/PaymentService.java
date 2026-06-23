package com.entity.service;

import com.entity.model.Payment;
import com.entity.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    public Payment save(Payment payment) {
        return paymentRepository.save(payment);
    }

    public List<Payment> findByPatientId(Long patientId) {
        return paymentRepository.findByBillPatientId(patientId);
    }

    public java.util.Optional<Payment> findByBillId(Long billId) {
        return paymentRepository.findFirstByBillIdOrderByIdDesc(billId);
    }

    public List<Payment> findAll() {
        return paymentRepository.findAll();
    }

    public Map<String, Double> getRevenueBreakdown(LocalDateTime start, LocalDateTime end) {
        List<Payment> payments = paymentRepository.findByStatusAndPaymentDateBetween("SUCCESS", start, end);
        return payments.stream()
                .collect(Collectors.groupingBy(
                        p -> p.getBill().getServiceType(),
                        Collectors.summingDouble(Payment::getAmountPaid)));
    }

    public Map<String, Double> getMonthlyRevenueHistory(int monthsCount) {
        Map<String, Double> history = new LinkedHashMap<>();
        LocalDateTime now = LocalDateTime.now();

        for (int i = monthsCount - 1; i >= 0; i--) {
            LocalDateTime month = now.minusMonths(i);
            LocalDateTime start = month.with(TemporalAdjusters.firstDayOfMonth()).with(LocalTime.MIN);
            LocalDateTime end = month.with(TemporalAdjusters.lastDayOfMonth()).with(LocalTime.MAX);

            double total = paymentRepository.findByStatusAndPaymentDateBetween("SUCCESS", start, end)
                    .stream()
                    .mapToDouble(Payment::getAmountPaid)
                    .sum();

            String monthName = start.getMonth().getDisplayName(java.time.format.TextStyle.SHORT, java.util.Locale.ENGLISH);
            history.put(monthName, total);
        }
        return history;
    }
}
