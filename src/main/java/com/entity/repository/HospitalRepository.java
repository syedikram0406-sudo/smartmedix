package com.entity.repository;

import com.entity.model.Hospital;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface HospitalRepository extends JpaRepository<Hospital, Long> {
    List<Hospital> findByStatus(String status);
    List<Hospital> findByCityContainingIgnoreCase(String city);
    List<Hospital> findByStatusAndCityContainingIgnoreCase(String status, String city);
}
