package com.citadel.backend.dao;

import com.citadel.backend.entity.FaceIdImageValidate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FaceIdImageValidateDao extends JpaRepository<FaceIdImageValidate, Long> {

}
