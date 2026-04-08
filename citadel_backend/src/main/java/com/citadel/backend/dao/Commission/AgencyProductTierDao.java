package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgencyProductTier;
import com.citadel.backend.vo.Enum.ProductOrderType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AgencyProductTierDao extends JpaRepository<AgencyProductTier, Long> {

    AgencyProductTier findByAgencyIdAndProductIdAndProductOrderTypeAndYear(Long agencyId, Long productId, ProductOrderType productOrderType, Integer year);

    @Query("SELECT a.commission FROM AgencyProductTier a WHERE a.agencyId = :agencyId AND a.productId = :productId AND a.productOrderType = :productOrderType AND a.year = :year")
    Optional<Double> findCommissionByAgencyIdAndProductIdAndProductOrderTypeAndYear(@Param("agencyId") Long agencyId,
                                                                                    @Param("productId") Long productId,
                                                                                    @Param("productOrderType") ProductOrderType productOrderType,
                                                                                    @Param("year") Integer year);
}
