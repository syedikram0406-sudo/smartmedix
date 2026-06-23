package com.entity.repository;

import com.entity.model.HealthScore;
import com.entity.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface HealthScoreRepository extends JpaRepository<HealthScore, Long> {
    List<HealthScore> findByPatientOrderByDateAsc(Patient patient);
    Optional<HealthScore> findTopByPatientOrderByDateDesc(Patient patient);
}
