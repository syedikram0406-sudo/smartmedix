package com.entity.repository;

import com.entity.model.DietPlan;
import com.entity.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DietPlanRepository extends JpaRepository<DietPlan, Long> {
    List<DietPlan> findByPatientOrderByDateCreatedDesc(Patient patient);
    DietPlan findTopByPatientOrderByDateCreatedDesc(Patient patient);
}
