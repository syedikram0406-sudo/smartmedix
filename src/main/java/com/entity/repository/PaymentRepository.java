package com.entity.repository;

import com.entity.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByBillPatientId(Long patientId);
    Optional<Payment> findFirstByBillIdOrderByIdDesc(Long billId);
    List<Payment> findByStatusAndPaymentDateBetween(String status, java.time.LocalDateTime start, java.time.LocalDateTime end);
}
