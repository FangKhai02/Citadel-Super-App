package com.citadel.backend.dao.Client;

import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.IndividualBeneficiary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IndividualBeneficiaryDao extends JpaRepository<IndividualBeneficiary, Long> {

    List<IndividualBeneficiary> findByClientAndIsDeletedFalse(Client client);

    Optional<IndividualBeneficiary> findByIdAndClientAndIsDeletedFalse(Long beneficiaryId, Client client);

    IndividualBeneficiary findByIdentityCardNumberAndClientAndIsDeletedIsFalse(String identityCardNumber, Client client);
}

