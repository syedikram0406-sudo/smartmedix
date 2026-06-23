package com.entity.service;

import com.entity.model.Bill;
import com.entity.repository.BillRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BillService {

    @Autowired
    private BillRepository billRepository;

    public Bill save(Bill bill) {
        return billRepository.save(bill);
    }

    public List<Bill> findByPatientId(Long patientId) {
        return billRepository.findByPatientId(patientId);
    }

    public List<Bill> findUnpaidByPatientId(Long patientId) {
        return billRepository.findByPatientIdAndStatus(patientId, "UNPAID");
    }

    public Optional<Bill> findById(Long id) {
        return billRepository.findById(id);
    }

    public List<Bill> findAll() {
        return billRepository.findAll();
    }
}
