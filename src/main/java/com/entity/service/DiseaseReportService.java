package com.entity.service;

import com.entity.model.DiseaseReport;
import com.entity.repository.DiseaseReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.time.LocalDate;
import java.util.*;

@Service
public class DiseaseReportService {

    @Autowired
    private DiseaseReportRepository diseaseReportRepository;

    @PostConstruct
    public void seedSampleData() {
        if (diseaseReportRepository.count() > 0) return;

        String[] diseases = {"Flu", "COVID-19", "Dengue", "Typhoid", "Malaria", "Chickenpox"};
        String[] cities = {"Mumbai", "Delhi", "Bangalore", "Hyderabad", "Chennai", "Pune", "Kolkata"};
        Random rand = new Random(42);

        List<DiseaseReport> reports = new ArrayList<>();
        for (int day = 0; day < 30; day++) {
            LocalDate date = LocalDate.now().minusDays(day);
            // More cases for Flu and Dengue to simulate outbreaks
            int fluCases = 3 + rand.nextInt(day < 10 ? 8 : 3);
            for (int i = 0; i < fluCases; i++) {
                reports.add(new DiseaseReport("Flu", cities[rand.nextInt(cities.length)], date));
            }
            int dengueCases = 2 + rand.nextInt(day < 7 ? 6 : 2);
            for (int i = 0; i < dengueCases; i++) {
                reports.add(new DiseaseReport("Dengue", cities[rand.nextInt(3)], date));
            }
            // Other diseases at lower rates
            for (String disease : new String[]{"COVID-19", "Typhoid", "Malaria", "Chickenpox"}) {
                int cases = rand.nextInt(day < 15 ? 4 : 2);
                for (int i = 0; i < cases; i++) {
                    reports.add(new DiseaseReport(disease, cities[rand.nextInt(cities.length)], date));
                }
            }
        }
        diseaseReportRepository.saveAll(reports);
    }

    public Map<String, Object> getTrends() {
        Map<String, Object> result = new LinkedHashMap<>();
        LocalDate since30 = LocalDate.now().minusDays(30);
        LocalDate since7 = LocalDate.now().minusDays(7);

        // Disease counts (last 30 days)
        List<Object[]> diseaseCounts = diseaseReportRepository.countByDiseaseSince(since30);
        List<Map<String, Object>> diseases = new ArrayList<>();
        for (Object[] row : diseaseCounts) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("name", row[0]);
            entry.put("count", row[1]);
            diseases.add(entry);
        }
        result.put("diseases", diseases);

        // City counts (last 30 days)
        List<Object[]> cityCounts = diseaseReportRepository.countByCitySince(since30);
        List<Map<String, Object>> cities = new ArrayList<>();
        for (Object[] row : cityCounts) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("name", row[0]);
            entry.put("count", row[1]);
            cities.add(entry);
        }
        result.put("cities", cities);

        // Alerts: compare last 7 days vs previous 7 days
        List<Object[]> recent = diseaseReportRepository.countByDiseaseSince(since7);
        List<Object[]> older = diseaseReportRepository.countByDiseaseSince(LocalDate.now().minusDays(14));
        Map<String, Long> recentMap = new LinkedHashMap<>();
        for (Object[] row : recent) recentMap.put((String) row[0], (Long) row[1]);
        Map<String, Long> olderMap = new LinkedHashMap<>();
        for (Object[] row : older) olderMap.put((String) row[0], (Long) row[1]);

        List<Map<String, Object>> alerts = new ArrayList<>();
        for (Map.Entry<String, Long> entry : recentMap.entrySet()) {
            String disease = entry.getKey();
            long recentCount = entry.getValue();
            long olderCount = olderMap.getOrDefault(disease, 0L) - recentCount;
            if (olderCount <= 0) olderCount = 1;
            double changePercent = ((double)(recentCount - olderCount) / olderCount) * 100;
            Map<String, Object> alert = new LinkedHashMap<>();
            alert.put("disease", disease);
            alert.put("recentCases", recentCount);
            alert.put("trend", changePercent > 20 ? "RISING" : changePercent < -20 ? "FALLING" : "STABLE");
            alert.put("changePercent", Math.round(changePercent));
            alerts.add(alert);
        }
        result.put("alerts", alerts);

        // Disease by city breakdown
        List<Object[]> dcCounts = diseaseReportRepository.countByDiseaseCitySince(since30);
        List<Map<String, Object>> breakdown = new ArrayList<>();
        for (Object[] row : dcCounts) {
            Map<String, Object> entry = new LinkedHashMap<>();
            entry.put("disease", row[0]);
            entry.put("city", row[1]);
            entry.put("count", row[2]);
            breakdown.add(entry);
        }
        result.put("breakdown", breakdown);

        result.put("totalCases", diseaseReportRepository.countByReportDateAfter(since30));
        result.put("period", "Last 30 Days");

        return result;
    }

    public void reportDisease(String disease, String city, int count) {
        List<DiseaseReport> reports = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            reports.add(new DiseaseReport(disease, city, LocalDate.now()));
        }
        diseaseReportRepository.saveAll(reports);
    }
}
