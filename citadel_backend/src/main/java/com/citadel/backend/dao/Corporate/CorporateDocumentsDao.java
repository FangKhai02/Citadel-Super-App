package com.citadel.backend.dao.Corporate;

import com.citadel.backend.entity.Corporate.CorporateDetails;
import com.citadel.backend.entity.Corporate.CorporateDocuments;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CorporateDocumentsDao extends JpaRepository<CorporateDocuments, Long> {
    List<CorporateDocuments> findAllByCorporateDetailsAndIsDeletedIsFalse(CorporateDetails corporateDetails);
}
