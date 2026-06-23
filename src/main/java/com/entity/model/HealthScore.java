package com.entity.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class HealthScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    private int overallScore; // 0-100
    private int dietScore;
    private int exerciseScore;
    private int medicationScore;

    @Column(length = 1000)
    private String insights; // JSON or comma-separated tips

    private LocalDate date;

    public HealthScore() {}

    public HealthScore(Patient patient, int overallScore, int dietScore, int exerciseScore, int medicationScore, String insights, LocalDate date) {
        this.patient = patient;
        this.overallScore = overallScore;
        this.dietScore = dietScore;
        this.exerciseScore = exerciseScore;
        this.medicationScore = medicationScore;
        this.insights = insights;
        this.date = date;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public int getOverallScore() { return overallScore; }
    public void setOverallScore(int overallScore) { this.overallScore = overallScore; }

    public int getDietScore() { return dietScore; }
    public void setDietScore(int dietScore) { this.dietScore = dietScore; }

    public int getExerciseScore() { return exerciseScore; }
    public void setExerciseScore(int exerciseScore) { this.exerciseScore = exerciseScore; }

    public int getMedicationScore() { return medicationScore; }
    public void setMedicationScore(int medicationScore) { this.medicationScore = medicationScore; }

    public String getInsights() { return insights; }
    public void setInsights(String insights) { this.insights = insights; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
}
