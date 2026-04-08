package com.citadel.backend.dao.Corporate;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateShareholder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CorporateShareholderDao extends JpaRepository<CorporateShareholder, Long> {
    Optional<CorporateShareholder> findByIdAndCorporateClientAndIsDeletedIsFalse(Long corporateShareholderId, CorporateClient corporateClient);

    List<CorporateShareholder> findAllByCorporateClientAndIsDeletedIsFalse(CorporateClient corporateClient);

    List<CorporateShareholder> findAllByCorporateClientAndStatusAndIsDeletedIsFalse(CorporateClient corporateClient, CorporateShareholder.CorporateShareholderStatus status);

    CorporateShareholder findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(CorporateClient corporateClient, String identityCardNumber);
}
