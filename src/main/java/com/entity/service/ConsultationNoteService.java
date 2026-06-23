package com.entity.service;

import com.entity.model.ConsultationNote;
import com.entity.repository.ConsultationNoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ConsultationNoteService {

    @Autowired
    private ConsultationNoteRepository consultationNoteRepository;

    public ConsultationNote save(ConsultationNote note) {
        return consultationNoteRepository.save(note);
    }

    public List<ConsultationNote> findByPatientId(Long patientId) {
        return consultationNoteRepository.findByPatientId(patientId);
    }

    public List<ConsultationNote> findByDoctorAndPatient(Long doctorId, Long patientId) {
        return consultationNoteRepository.findByDoctorIdAndPatientId(doctorId, patientId);
    }
}
