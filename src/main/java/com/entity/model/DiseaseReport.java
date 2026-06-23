package com.entity.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "disease_reports")
public class DiseaseReport {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String disease;

    @Column(nullable = false)
    private String city;

    @Column(nullable = false)
    private LocalDate reportDate;

    public DiseaseReport() {}

    public DiseaseReport(String disease, String city, LocalDate reportDate) {
        this.disease = disease;
        this.city = city;
        this.reportDate = reportDate;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getDisease() { return disease; }
    public void setDisease(String disease) { this.disease = disease; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public LocalDate getReportDate() { return reportDate; }
    public void setReportDate(LocalDate reportDate) { this.reportDate = reportDate; }
}
