package com.entity.service;

import com.entity.model.Hospital;
import com.entity.repository.HospitalRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class HospitalService {

    @Autowired
    private HospitalRepository hospitalRepository;

    @PostConstruct
    public void seedSampleData() {
        if (hospitalRepository.count() > 0) return;

        hospitalRepository.save(new Hospital("SmartMedix City Hospital", "Mumbai", "Andheri West",
                "Plot 15, SV Road, Andheri West, Mumbai 400058", "+91-22-2626-1000", "cityhospital@smartmedix.in",
                20, 8, 30, 15, 100, 45));

        hospitalRepository.save(new Hospital("SmartMedix Super Specialty", "Delhi", "Saket",
                "J-Block, Saket, New Delhi 110017", "+91-11-2956-2000", "superspecialty@smartmedix.in",
                30, 12, 40, 22, 150, 78));

        hospitalRepository.save(new Hospital("SmartMedix Children's Hospital", "Bangalore", "Koramangala",
                "80 Feet Road, Koramangala, Bangalore 560034", "+91-80-4125-3000", "children@smartmedix.in",
                10, 4, 15, 8, 60, 32));

        hospitalRepository.save(new Hospital("SmartMedix Trauma Center", "Hyderabad", "Banjara Hills",
                "Road No 12, Banjara Hills, Hyderabad 500034", "+91-40-2335-4000", "trauma@smartmedix.in",
                25, 3, 35, 10, 80, 20));

        hospitalRepository.save(new Hospital("SmartMedix General Hospital", "Chennai", "T Nagar",
                "Usman Road, T Nagar, Chennai 600017", "+91-44-2434-5000", "general@smartmedix.in",
                15, 7, 25, 18, 120, 65));

        hospitalRepository.save(new Hospital("SmartMedix Care Hospital", "Pune", "Kothrud",
                "Paud Road, Kothrud, Pune 411038", "+91-20-2546-6000", "care@smartmedix.in",
                12, 5, 20, 12, 70, 40));
    }

    public List<Hospital> findAll() {
        return hospitalRepository.findAll();
    }

    public List<Hospital> findActive() {
        return hospitalRepository.findByStatus("Active");
    }

    public List<Hospital> searchByCity(String city) {
        if (city == null || city.trim().isEmpty()) {
            return findActive();
        }
        return hospitalRepository.findByStatusAndCityContainingIgnoreCase("Active", city.trim());
    }

    public Optional<Hospital> findById(Long id) {
        return hospitalRepository.findById(id);
    }

    public Hospital save(Hospital hospital) {
        hospital.setLastUpdated(LocalDateTime.now());
        return hospitalRepository.save(hospital);
    }
}
