package com.citadel.backend.dao;

import com.citadel.backend.entity.PepInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PepInfoDao extends JpaRepository<PepInfo, Long> {
}
