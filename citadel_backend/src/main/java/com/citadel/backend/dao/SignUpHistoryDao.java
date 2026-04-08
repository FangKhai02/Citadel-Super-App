package com.citadel.backend.dao;

import com.citadel.backend.entity.SignUpHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SignUpHistoryDao extends JpaRepository<SignUpHistory, Long> {
    SignUpHistory findByEmail(String email);
}
