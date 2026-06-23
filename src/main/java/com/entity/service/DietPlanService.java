package com.entity.service;

import com.entity.model.DietPlan;
import com.entity.model.Doctor;
import com.entity.model.Patient;
import com.entity.repository.DietPlanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class DietPlanService {

    @Autowired
    private DietPlanRepository dietPlanRepository;

    public void prescribeDiet(Patient patient, Doctor doctor, String breakfast, String lunch, String dinner, String healthyDrinks, int steps, int exercise, int dScore, int eScore, int duration) {
        DietPlan plan = new DietPlan(patient, doctor, breakfast, lunch, dinner, healthyDrinks, steps, exercise, dScore, eScore, duration, LocalDateTime.now());
        dietPlanRepository.save(plan);
    }

    public DietPlan getLatestPlan(Patient patient) {
        return dietPlanRepository.findTopByPatientOrderByDateCreatedDesc(patient);
    }

    public List<DietPlan> getHistory(Patient patient) {
        return dietPlanRepository.findByPatientOrderByDateCreatedDesc(patient);
    }
}
