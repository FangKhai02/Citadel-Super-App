package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.AgentCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.AgentCommissionHistory;
import com.citadel.backend.vo.Commission.AgentEarningCommissionVo;
import com.citadel.backend.vo.Enum.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AgentCommissionHistoryDao extends JpaRepository<AgentCommissionHistory, Long> {

    @Query("SELECT ach FROM AgentCommissionHistory ach WHERE ach.agentId = :agentId AND ach.agentCommissionCalculationHistory.referenceNumber = :referenceNumber")
    Optional<AgentCommissionHistory> findByAgentIdAndCommissionCalculationHistoryReferenceNumber(@Param("agentId") String agentId, @Param("referenceNumber") String referenceNumber);

    @Query("SELECT ach FROM AgentCommissionHistory ach " +
            "WHERE ach.agentId = :agentId " +
            "AND ach.paymentStatus = :status " +
            "AND ach.commissionAmount > 0 " +
            "ORDER BY ach.paymentDate DESC")
    List<AgentCommissionHistory> findByAgentIdAndPaymentStatus(@Param("agentId") String agentId,
                                                               @Param("status") Status status);

    @Query("SELECT new com.citadel.backend.vo.Commission.AgentEarningCommissionVo(" +
            "ach.commissionPercentage, " +
            "ach.commissionAmount, " +
            "ach.paymentDate) " +
            "FROM AgentCommissionHistory ach " +
            "WHERE ach.agentId = :agentId " +
            "AND ach.commissionType = :commissionType " +
            "AND ach.paymentStatus = :status " +
            "AND ach.agentCommissionCalculationHistory.productOrderId = :productOrderId " +
            "ORDER BY ach.id DESC")
    List<AgentEarningCommissionVo> findByAgentIdAndCommissionTypeAndProductOrderId(@Param("agentId") String agentId,
                                                                             @Param("commissionType") AgentCommissionHistory.CommissionType commissionType,
                                                                             @Param("status") Status status,
                                                                             @Param("productOrderId") Long productOrderId);

    @Query("SELECT ach FROM AgentCommissionHistory ach " +
            "WHERE ach.agentId = :agentId " +
            "AND ach.commissionType = :commissionType " +
            "AND ach.agentCommissionCalculationHistory.calculatedDate BETWEEN :startDate AND :endDate " +
            "ORDER BY ach.agentCommissionCalculationHistory.calculatedDate ASC")
    List<AgentCommissionHistory> findAllByCommissionTypeAndByDateRange(@Param("agentId") String agentId,
                                                                       @Param("commissionType") AgentCommissionHistory.CommissionType commissionType,
                                                                       @Param("startDate") LocalDate startDate,
                                                                       @Param("endDate") LocalDate endDate);

    @Query("SELECT ach FROM AgentCommissionHistory ach " +
            "WHERE ach.agentId = :agentId " +
            "AND ach.commissionType = :commissionType " +
            "AND ach.agentCommissionCalculationHistory.calculatedDate BETWEEN :startDate AND :endDate " +
            "AND ach.paymentStatus = :status " +
            "ORDER BY ach.agentCommissionCalculationHistory.calculatedDate ASC")
    List<AgentCommissionHistory> findAllByCommissionTypeAndPaymentStatusAndByDateRange(@Param("agentId") String agentId,
                                                                                       @Param("commissionType") AgentCommissionHistory.CommissionType commissionType,
                                                                                       @Param("startDate") LocalDate startDate,
                                                                                       @Param("endDate") LocalDate endDate,
                                                                                       @Param("status") Status status);

    Optional<AgentCommissionHistory> findFirstByAgentIdAndAgentCommissionCalculationHistoryOrderByIdDesc(String agentId,AgentCommissionCalculationHistory agentCommissionCalculationHistory);

}
