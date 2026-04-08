package com.citadel.backend.dao.Corporate;


import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Corporate.CorporateClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CorporateClientDao extends JpaRepository<CorporateClient, Long> {
    CorporateClient findByClientAndIsDeletedFalse(Client client);

    CorporateClient findByReferenceNumberAndIsDeletedFalse(String referenceNumber);

    Optional<CorporateClient> findByClientAndCorporateClientIdAndIsDeletedIsFalse(Client client, String corporateClientId);

    Optional<CorporateClient> findByCorporateClientIdAndIsDeletedIsFalse(String corporateClientId);

    Optional<CorporateClient> findByCorporateClientIdAndAgentAndIsDeletedIsFalse(String corporateClientId, Agent agent);

    @Query("SELECT c FROM CorporateClient c " +
            "WHERE c.corporateDetails.registrationNumber = :registrationNumber " +
            "AND c.isDeleted = false " +
            "AND c.client = :client")
    CorporateClient findByRegistrationNumberAndClientAndIsDeletedIsFalse(String registrationNumber, Client client);

    @Query("SELECT c FROM CorporateClient c " +
            "WHERE c.corporateDetails.registrationNumber = :registrationNumber " +
            "AND c.isDeleted = false")
    CorporateClient findByCorporateRegistrationNumberAndIsDeletedIsFalse(String registrationNumber);
}
