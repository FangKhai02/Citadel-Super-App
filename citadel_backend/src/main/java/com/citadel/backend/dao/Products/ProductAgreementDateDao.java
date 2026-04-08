package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductAgreementDate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductAgreementDateDao extends JpaRepository<ProductAgreementDate, Long> {
    @Query(value = "SELECT date_of_month FROM product_agreement_date " +
            "WHERE product_type_id = :productTypeId " +
            "AND date_of_month >= :dayOfMonth " +
            "ORDER BY date_of_month " +
            "LIMIT 1", nativeQuery = true)
    Integer findAgreementDateOfMonth(@Param("productTypeId") Long productTypeId, @Param("dayOfMonth") Integer dayOfMonth);
}
