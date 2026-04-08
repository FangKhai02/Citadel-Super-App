package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgencyCommissionConfiguration;
import com.citadel.backend.vo.Commission.AgencyMonthlyCommissionConfigurationVo;
import com.citadel.backend.vo.Commission.AgencyYearlyCommissionConfigurationVo;
import com.citadel.backend.vo.Enum.ProductOrderType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface AgencyCommissionConfigurationDao extends JpaRepository<AgencyCommissionConfiguration, Long> {
    //For Agency monthly commission
    @Query("""
                SELECT a.commission
                FROM AgencyCommissionConfiguration a
                WHERE a.product.id = :productId
                  AND a.productOrderType = :productOrderType
                  AND (
                      (:threshold < a.threshold AND a.condition = 'BELOW') OR
                      (:threshold >= a.threshold AND a.condition = 'ABOVE')
                  )
            """)
    Optional<Double> findCommissionRateByProductAndProductTypeAndThreshold(@Param("productId") Long productId,
                                                                           @Param("productOrderType") ProductOrderType productOrderType,
                                                                           @Param("threshold") Double threshold);

    @Query("SELECT a.product.id FROM AgencyCommissionConfiguration a " +
            "WHERE a.year IS NULL AND a.threshold IS NOT NULL AND a.condition IS NOT NULL")
    Set<Long> findAllProductIdWithMonthlyConfigurations();

    @Query("SELECT new com.citadel.backend.vo.Commission.AgencyMonthlyCommissionConfigurationVo(" +
            "a.threshold, " +
            "a.year, " +
            "a.commission) " +
            "FROM AgencyCommissionConfiguration a " +
            "WHERE a.product.id = :productId " +
            "AND a.productOrderType = :productOrderType " +
            "AND a.condition = :conditionType")
    AgencyMonthlyCommissionConfigurationVo findByProductIdAndProductOrderTypeAndConditionType(@Param("productId") Long productId,
                                                                                              @Param("productOrderType") ProductOrderType productOrderType,
                                                                                              @Param("conditionType") AgencyCommissionConfiguration.AgencyCommissionConfigCondition conditionType);

    @Query("SELECT new com.citadel.backend.vo.Commission.AgencyYearlyCommissionConfigurationVo(" +
            "a.product.id, " +
            "a.productOrderType, " +
            "a.year, " +
            "a.commission) " +
            "FROM AgencyCommissionConfiguration a " +
            "WHERE a.year IS NOT NULL " +
            "AND a.productOrderType IS NOT NULL")
    List<AgencyYearlyCommissionConfigurationVo> findAllYearlyCommissionConfigurations();

    @Query("SELECT a.commission FROM AgencyCommissionConfiguration " +
            "a WHERE a.product.id = :productId " +
            "AND a.productOrderType = :productOrderType " +
            "AND a.condition = :conditionType " +
            "AND a.threshold <= :totalSales")
    Optional<Double> findCommissionRateForTier2(@Param("productId") Long productId,
                                                @Param("productOrderType") ProductOrderType productOrderType,
                                                @Param("conditionType") AgencyCommissionConfiguration.AgencyCommissionConfigCondition conditionType,
                                                @Param("totalSales") Double totalSales);
}