package com.entity.repository;

import com.entity.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface DoctorRepository extends JpaRepository<Doctor, Long> {
    List<Doctor> findByDepartment(String department);

    List<Doctor> findByStatus(String status);

    long countByStatus(String status);
}
