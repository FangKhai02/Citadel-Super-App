package com.citadel.backend.dao.Corporate;

import com.citadel.backend.entity.Corporate.CorporateDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CorporateDetailsDao extends JpaRepository<CorporateDetails, Long> {
    CorporateDetails findByRegistrationNumberAndIsDeletedFalse(String registrationNumber);

    @Query("SELECT cd FROM CorporateDetails cd WHERE cd.registrationNumber = :registrationNumber AND cd.isDeleted = false AND cd.status != 'DRAFT'")
    CorporateDetails findByRegistrationNumberAndIsDeletedFalseAndStatusNotDraft(@Param("registrationNumber") String registrationNumber);
}
