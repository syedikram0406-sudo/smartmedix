package com.entity.service;

import com.entity.model.Doctor;
import com.entity.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    public Doctor save(Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    public List<Doctor> findAll() {
        return doctorRepository.findAll();
    }

    public Optional<Doctor> findById(Long id) {
        return doctorRepository.findById(id);
    }

    public void deleteById(Long id) {
        doctorRepository.deleteById(id);
    }

    public List<Doctor> findByDepartment(String department) {
        return doctorRepository.findByDepartment(department);
    }

    public List<Doctor> findByStatus(String status) {
        return doctorRepository.findByStatus(status);
    }

    public long count() {
        return doctorRepository.count();
    }

    public long countActive() {
        return doctorRepository.countByStatus("Active");
    }

    public void updateAvailability(Long doctorId, String status) {
        doctorRepository.findById(doctorId).ifPresent(doctor -> {
            doctor.setAvailabilityStatus(status);
            doctorRepository.save(doctor);
        });
    }
}
