package com.entity.service;

import com.entity.model.Patient;
import com.entity.model.QrShareToken;
import com.entity.repository.QrShareTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class QrShareTokenService {

    @Autowired
    private QrShareTokenRepository qrShareTokenRepository;

    public QrShareToken generateToken(Patient patient) {
        QrShareToken token = new QrShareToken();
        token.setPatient(patient);
        return qrShareTokenRepository.save(token);
    }

    public Optional<Patient> validateAndConsume(String tokenStr) {
        Optional<QrShareToken> tokenOpt = qrShareTokenRepository.findByToken(tokenStr);
        if (tokenOpt.isPresent()) {
            QrShareToken token = tokenOpt.get();
            if (token.isValid()) {
                token.setUsed(true);
                qrShareTokenRepository.save(token);
                return Optional.of(token.getPatient());
            }
        }
        return Optional.empty();
    }
}
