package com.entity.service;

import com.entity.model.HealthScore;
import com.entity.model.Patient;
import com.entity.repository.HealthScoreRepository;
import com.entity.repository.PatientRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class HealthScoreService {

    @Autowired
    private HealthScoreRepository healthScoreRepository;

    @Autowired
    private PatientRepository patientRepository;

    private final Random random = new Random();

    @PostConstruct
    public void seedInitialData() {
        List<Patient> patients = patientRepository.findAll();
        for (Patient patient : patients) {
            if (healthScoreRepository.findByPatientOrderByDateAsc(patient).isEmpty()) {
                // Seed last 10 days of health scores
                for (int i = 9; i >= 0; i--) {
                    LocalDate date = LocalDate.now().minusDays(i);
                    generateRandomScore(patient, date);
                }
            }
        }
    }

    public HealthScore getLatestScore(Patient patient) {
        return healthScoreRepository.findTopByPatientOrderByDateDesc(patient)
                .orElseGet(() -> generateRandomScore(patient, LocalDate.now()));
    }

    public List<HealthScore> getHistory(Patient patient) {
        return healthScoreRepository.findByPatientOrderByDateAsc(patient);
    }

    private HealthScore generateRandomScore(Patient patient, LocalDate date) {
        int diet = 60 + random.nextInt(35);
        int exercise = 50 + random.nextInt(45);
        int medication = 80 + random.nextInt(20);
        int overall = (diet + exercise + medication) / 3;

        List<String> tips = new ArrayList<>();
        if (diet < 75) tips.add("Add more greens to your meals.");
        if (exercise < 70) tips.add("Try a 20-minute walk today.");
        if (medication < 90) tips.add("Consistency is key for your meds.");
        if (tips.isEmpty()) tips.add("Excellent job! Keep it up.");
        tips.add("Stay hydrated! Drink 8 glasses of water.");

        String insights = String.join("|", tips);
        HealthScore score = new HealthScore(patient, overall, diet, exercise, medication, insights, date);
        return healthScoreRepository.save(score);
    }

    public List<String> getInsightsList(HealthScore score) {
        if (score == null || score.getInsights() == null) return List.of("No insights available.");
        return List.of(score.getInsights().split("\\|"));
    }
}
