package com.entity.repository;

import com.entity.model.ConsultationNote;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ConsultationNoteRepository extends JpaRepository<ConsultationNote, Long> {
    List<ConsultationNote> findByPatientId(Long patientId);

    List<ConsultationNote> findByDoctorIdAndPatientId(Long doctorId, Long patientId);
}
