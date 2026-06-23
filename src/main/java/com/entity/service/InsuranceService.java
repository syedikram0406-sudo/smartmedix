package com.entity.service;

import com.entity.model.Insurance;
import com.entity.repository.InsuranceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class InsuranceService {

    @Autowired
    private InsuranceRepository insuranceRepository;

    public List<Insurance> findAll() {
        return insuranceRepository.findAll();
    }

    public Optional<Insurance> findById(Long id) {
        return insuranceRepository.findById(id);
    }

    public List<Insurance> findByPatientId(Long patientId) {
        return insuranceRepository.findByPatientId(patientId);
    }

    public List<Insurance> findPending() {
        return insuranceRepository.findByStatus("Pending");
    }

    public Insurance save(Insurance insurance) {
        return insuranceRepository.save(insurance);
    }

    public void deleteById(Long id) {
        insuranceRepository.deleteById(id);
    }
}
