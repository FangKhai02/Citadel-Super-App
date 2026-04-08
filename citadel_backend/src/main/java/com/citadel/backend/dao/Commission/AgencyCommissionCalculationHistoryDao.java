package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgencyCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.ProductCommissionHistory;
import com.citadel.backend.vo.Enum.ProductOrderType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgencyCommissionCalculationHistoryDao extends JpaRepository<AgencyCommissionCalculationHistory, Long> {

    @Query("SELECT SUM(a.purchasedAmount) " +
            "FROM AgencyCommissionCalculationHistory a " +
            "WHERE a.agencyId = :agencyId " +
            "AND a.productId = :productId " +
            "AND a.orderAgreementDate BETWEEN :startDate AND :endDate " +
            "AND a.productOrderType = :productOrderType")
    Optional<Double> calculateTotalPurchasedAmountByAgencyAndProductAndDateRange(@Param("agencyId") Long agencyId,
                                                                                 @Param("productId") Long productId,
                                                                                 @Param("startDate") LocalDate startDate,
                                                                                 @Param("endDate") LocalDate endDate,
                                                                                 @Param("productOrderType") ProductOrderType productOrderType);

    @Query("SELECT a from AgencyCommissionCalculationHistory a WHERE a.generatedCommissionFile = false")
    List<AgencyCommissionCalculationHistory> findAllByGeneratedCommissionFileIsFalse();

    List<AgencyCommissionCalculationHistory> findAllByProductCommissionHistory(ProductCommissionHistory productCommissionHistory);

    AgencyCommissionCalculationHistory findByReferenceNumber(String referenceNumber);

    Optional<AgencyCommissionCalculationHistory> findFirstByAgencyIdAndProductOrderId(Long agencyId, Long productOrderId);
}