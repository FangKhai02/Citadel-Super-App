package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgentCommissionConfiguration;
import com.citadel.backend.vo.Commission.AgentCommissionConfigurationVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AgentCommissionConfigurationDao extends JpaRepository<AgentCommissionConfiguration, Long> {

    @Query("SELECT new com.citadel.backend.vo.Commission.AgentCommissionConfigurationVo(" +
            "a.product.id, " +
            "a.productOrderType, " +
            "a.year, " +
            "a.mgrCommission, " +
            "a.p2pCommission, " +
            "a.smCommission, " +
            "a.avpCommission, " +
            "a.vpCommission) " +
            "FROM AgentCommissionConfiguration a " +
            "WHERE a.year IS NULL " +
            "AND a.productOrderType IS NOT NULL")
    List<AgentCommissionConfigurationVo> findAllMonthlyAgentCommissionConfigurations();

    @Query("SELECT new com.citadel.backend.vo.Commission.AgentCommissionConfigurationVo(" +
            "a.product.id, " +
            "a.productOrderType, " +
            "a.year, " +
            "a.mgrCommission, " +
            "a.p2pCommission, " +
            "a.smCommission, " +
            "a.avpCommission, " +
            "a.vpCommission) " +
            "FROM AgentCommissionConfiguration a " +
            "WHERE a.year IS NOT NULL " +
            "AND a.productOrderType IS NOT NULL")
    List<AgentCommissionConfigurationVo> findAllYearlyAgentCommissionConfigurations();
}
