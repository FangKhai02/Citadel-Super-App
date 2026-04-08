package com.citadel.backend.dao;

import com.citadel.backend.entity.EsmsHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EsmsHistoryDao extends JpaRepository<EsmsHistory, Long> {
}
