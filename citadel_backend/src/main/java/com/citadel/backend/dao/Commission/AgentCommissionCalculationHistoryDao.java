package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgentCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.ProductCommissionHistory;
import com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgentCommissionCalculationHistoryDao extends JpaRepository<AgentCommissionCalculationHistory, Long> {

    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.mgrCommissionPercentage, " +
            "acch.mgrCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.mgrId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND acch.productOrderId = :productOrderId")
    List<AgentProductOrderCommissionDetailsVo> getAgentCommissionDetailsByAgentIdAndByProductOrder(@Param("agentId") Long agentId,
                                                                                                   @Param("startDate") LocalDate startDate,
                                                                                                   @Param("endDate") LocalDate endDate,
                                                                                                   @Param("productOrderId") Long productOrderId);

    // MGR
    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.mgrCommissionPercentage, " +
            "acch.mgrCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.mgrId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "ORDER BY acch.calculatedDate DESC")
    List<AgentProductOrderCommissionDetailsVo> getMgrCommissionDetailsByAgentIdAndByDateRange(@Param("agentId") Long agentId,
                                                                                              @Param("startDate") LocalDate startDate,
                                                                                              @Param("endDate") LocalDate endDate);

    // P2P
    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.p2pCommissionPercentage, " +
            "acch.p2pCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.p2pId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND acch.p2pCommissionAmount <> 0 " +
            "ORDER BY acch.calculatedDate DESC")
    List<AgentProductOrderCommissionDetailsVo> getP2pCommissionDetailsByAgentIdAndByDateRange(@Param("agentId") Long agentId,
                                                                                              @Param("startDate") LocalDate startDate,
                                                                                              @Param("endDate") LocalDate endDate);

    // SM
    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.smCommissionPercentage, " +
            "acch.smCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.smId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND acch.smCommissionAmount <> 0 " +
            "ORDER BY acch.calculatedDate DESC")
    List<AgentProductOrderCommissionDetailsVo> getSmCommissionDetailsByAgentIdAndByDateRange(@Param("agentId") Long agentId,
                                                                                             @Param("startDate") LocalDate startDate,
                                                                                             @Param("endDate") LocalDate endDate);

    // AVP
    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.avpCommissionPercentage, " +
            "acch.avpCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.avpId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND acch.avpCommissionAmount <> 0 " +
            "ORDER BY acch.calculatedDate DESC")
    List<AgentProductOrderCommissionDetailsVo> getAvpCommissionDetailsByAgentIdAndByDateRange(@Param("agentId") Long agentId,
                                                                                              @Param("startDate") LocalDate startDate,
                                                                                              @Param("endDate") LocalDate endDate);

    // VP
    @Query("SELECT new com.citadel.backend.vo.Agent.AgentProductOrderCommissionDetailsVo(" +
            "acch.productId, " +
            "acch.productOrderId, " +
            "acch.vpCommissionPercentage, " +
            "acch.vpCommissionAmount, " +
            "acch.calculatedDate, " +
            "acch.orderAgreementNumber, " +
            "p.code, " +
            "p.name, " +
            "po.paymentStatus, " +
            "po.paymentDate) " +
            "FROM AgentCommissionCalculationHistory acch " +
            "JOIN Product p ON acch.productId = p.id " +
            "JOIN ProductOrder po ON acch.productOrderId = po.id " +
            "WHERE acch.vpId = :agentId " +
            "AND acch.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND acch.vpCommissionAmount <> 0 " +
            "ORDER BY acch.calculatedDate DESC")
    List<AgentProductOrderCommissionDetailsVo> getVpCommissionDetailsByAgentIdAndByDateRange(@Param("agentId") Long agentId,
                                                                                             @Param("startDate") LocalDate startDate,
                                                                                             @Param("endDate") LocalDate endDate);

    @Query("SELECT a FROM AgentCommissionCalculationHistory a WHERE a.generatedCommissionFile = false")
    List<AgentCommissionCalculationHistory> findAllByGeneratedCommissionFileIsFalse();

    List<AgentCommissionCalculationHistory> findAllByProductCommissionHistory(ProductCommissionHistory productCommissionHistory);

    AgentCommissionCalculationHistory findByReferenceNumber(String referenceNumber);

    Optional<AgentCommissionCalculationHistory> findFirstByProductOrderIdAndMgrIdOrderByIdDesc(Long productOrderId, Long mgrId);
}
