package com.entity.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
public class DietPlan {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    private String breakfast;
    private String lunch;
    private String dinner;
    private String healthyDrinks;
    private int stepsTarget;
    private int exerciseMinutes;
    
    private int dietScore; // Doctor assigned
    private int exerciseScore; // Doctor assigned
    private int durationDays; // How long to follow the diet

    private LocalDateTime dateCreated;

    public DietPlan() {}

    public DietPlan(Patient patient, Doctor doctor, String breakfast, String lunch, String dinner, String healthyDrinks, int stepsTarget, int exerciseMinutes, int dietScore, int exerciseScore, int durationDays, LocalDateTime dateCreated) {
        this.patient = patient;
        this.doctor = doctor;
        this.breakfast = breakfast;
        this.lunch = lunch;
        this.dinner = dinner;
        this.healthyDrinks = healthyDrinks;
        this.stepsTarget = stepsTarget;
        this.exerciseMinutes = exerciseMinutes;
        this.dietScore = dietScore;
        this.exerciseScore = exerciseScore;
        this.durationDays = durationDays;
        this.dateCreated = dateCreated;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Doctor getDoctor() { return doctor; }
    public void setDoctor(Doctor doctor) { this.doctor = doctor; }

    public String getBreakfast() { return breakfast; }
    public void setBreakfast(String breakfast) { this.breakfast = breakfast; }

    public String getLunch() { return lunch; }
    public void setLunch(String lunch) { this.lunch = lunch; }

    public String getDinner() { return dinner; }
    public void setDinner(String dinner) { this.dinner = dinner; }

    public String getHealthyDrinks() { return healthyDrinks; }
    public void setHealthyDrinks(String healthyDrinks) { this.healthyDrinks = healthyDrinks; }

    public int getStepsTarget() { return stepsTarget; }
    public void setStepsTarget(int stepsTarget) { this.stepsTarget = stepsTarget; }

    public int getExerciseMinutes() { return exerciseMinutes; }
    public void setExerciseMinutes(int exerciseMinutes) { this.exerciseMinutes = exerciseMinutes; }

    public int getDietScore() { return dietScore; }
    public void setDietScore(int dietScore) { this.dietScore = dietScore; }

    public int getExerciseScore() { return exerciseScore; }
    public void setExerciseScore(int exerciseScore) { this.exerciseScore = exerciseScore; }

    public LocalDateTime getDateCreated() { return dateCreated; }
    public void setDateCreated(LocalDateTime dateCreated) { this.dateCreated = dateCreated; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public String getFormattedDate() {
        if (dateCreated == null) return "";
        return dateCreated.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
