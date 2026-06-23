package com.entity.repository;

import com.entity.model.QrShareToken;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface QrShareTokenRepository extends JpaRepository<QrShareToken, Long> {
    Optional<QrShareToken> findByToken(String token);
}
