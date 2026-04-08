package com.citadel.backend.dao.Corporate;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateShareholder;
import com.citadel.backend.entity.Corporate.CorporateShareholdersPivot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CorporateShareholdersPivotDao extends JpaRepository<CorporateShareholdersPivot, Long> {
    List<CorporateShareholdersPivot> findAllByCorporateClientAndIsDeletedFalse(CorporateClient corporateClient);

    CorporateShareholdersPivot findByCorporateShareholderIdAndCorporateClientAndIsDeletedIsFalse(Long id, CorporateClient corporateClient);

    List<CorporateShareholdersPivot> findByCorporateShareholderAndIsDeletedIsFalse(CorporateShareholder corporateShareholder);

    CorporateShareholdersPivot findByCorporateClientAndCorporateShareholderAndIsDeletedIsFalse(CorporateClient corporateClient, CorporateShareholder corporateShareholder);
}
