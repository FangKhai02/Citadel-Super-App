package com.citadel.backend.dao.Corporate;


import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.entity.Corporate.CorporateClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CorporateBeneficiaryDao extends JpaRepository<CorporateBeneficiaries, Long> {
    List<CorporateBeneficiaries> findByCorporateClientAndIsDeletedFalse(CorporateClient corporateClient);

    CorporateBeneficiaries findByIdAndCorporateClientAndIsDeletedFalse(Long corporateBeneficiaryId, CorporateClient corporateClient);

    Optional<CorporateBeneficiaries> findByCorporateGuardianIdAndCorporateClientAndIsDeletedFalse(Long corporateGuardian_id, CorporateClient corporateClient);

    CorporateBeneficiaries findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(CorporateClient corporateClient, String identityCardNumber);

    boolean existsByCorporateClientAndIdentityCardNumberAndIsDeletedFalse(CorporateClient corporateClient, String identityCardNumber);

}
