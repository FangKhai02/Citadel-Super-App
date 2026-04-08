package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductAgreement;
import com.citadel.backend.entity.Products.ProductAgreementPivot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductAgreementPivotDao extends JpaRepository<ProductAgreementPivot, Long> {
    @Query("""
            SELECT pivot.productAgreement.name FROM ProductAgreementPivot pivot
            WHERE pivot.product.id = :productId AND pivot.productAgreement.clientType = :clientType
            """)
    String findProductAgreementTemplateName(Long productId, ProductAgreement.ClientType clientType);
}
