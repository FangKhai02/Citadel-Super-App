package com.citadel.backend.dao.Corporate;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateGuardian;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CorporateGuardianDao extends JpaRepository<CorporateGuardian, Long> {
    CorporateGuardian findByIdAndCorporateClientAndIsDeletedFalse(Long id, CorporateClient corporateClient);

    List<CorporateGuardian> findAllByCorporateClientAndIsDeletedIsFalse(CorporateClient corporateClient);

    CorporateGuardian findByCorporateClientAndIdentityCardNumber(CorporateClient corporateClient, String identityCardNumber);
}
