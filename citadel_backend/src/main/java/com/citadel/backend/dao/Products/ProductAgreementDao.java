package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductAgreement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProductAgreementDao extends JpaRepository<ProductAgreement, Long> {
    @Query("SELECT pa.name FROM ProductAgreement pa WHERE pa.id = :id")
    Optional<String> getAgreementFileNameById(Long id);

    ProductAgreement findByName(String agreementTemplateName);

    @Query("SELECT pa.overwriteAgreementKey FROM ProductAgreement pa WHERE pa.name = :agreementTemplateName")
    String findOverrideAgreementKey(String agreementTemplateName);
}
