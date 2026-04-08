package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductAgreementSchedule;
import com.citadel.backend.entity.Products.ProductAgreementSchedulePivot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProductAgreementSchedulePivotDao extends JpaRepository<ProductAgreementSchedulePivot, Long> {

    @Query("SELECT pivot.productAgreementSchedule FROM ProductAgreementSchedulePivot pivot WHERE pivot.productType.id = :productTypeId")
    List<ProductAgreementSchedule> findSchedulesByProductType(@Param("productTypeId") Long productTypeId);

    @Query("SELECT pivot.productAgreementSchedule FROM ProductAgreementSchedulePivot pivot " +
            "WHERE pivot.productType.id = :productTypeId " +
            "AND pivot.productAgreementSchedule.submissionDueDate >= :submissionDate " +
            "AND pivot.productAgreementSchedule.approvalDueDate >= :approvalDate " +
            "ORDER BY pivot.productAgreementSchedule.approvalDueDate ASC")
    List<ProductAgreementSchedule> findSchedulesByProductTypeV2(@Param("productTypeId") Long productTypeId,
                                                                @Param("submissionDate") LocalDate submissionDate,
                                                                @Param("approvalDate") LocalDate approvalDate);
}
