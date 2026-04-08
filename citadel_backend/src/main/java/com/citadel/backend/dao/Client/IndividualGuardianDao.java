package com.citadel.backend.dao.Client;

import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.entity.IndividualGuardian;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IndividualGuardianDao extends JpaRepository<IndividualGuardian, Long> {
    IndividualGuardian findGuardianByIdAndClientAndIsDeletedFalse(Long guardianId, Client client);

    IndividualGuardian findByIdentityCardNumberAndClientAndIsDeletedIsFalse(String identityCardNumber, Client client);
}
