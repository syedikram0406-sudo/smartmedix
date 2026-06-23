package com.entity.repository;

import com.entity.model.DiseaseReport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.time.LocalDate;
import java.util.List;

public interface DiseaseReportRepository extends JpaRepository<DiseaseReport, Long> {

    @Query("SELECT d.disease, COUNT(d) FROM DiseaseReport d WHERE d.reportDate >= :since GROUP BY d.disease ORDER BY COUNT(d) DESC")
    List<Object[]> countByDiseaseSince(LocalDate since);

    @Query("SELECT d.city, COUNT(d) FROM DiseaseReport d WHERE d.reportDate >= :since GROUP BY d.city ORDER BY COUNT(d) DESC")
    List<Object[]> countByCitySince(LocalDate since);

    @Query("SELECT d.disease, d.city, COUNT(d) FROM DiseaseReport d WHERE d.reportDate >= :since GROUP BY d.disease, d.city ORDER BY COUNT(d) DESC")
    List<Object[]> countByDiseaseCitySince(LocalDate since);

    long countByReportDateAfter(LocalDate date);
}
