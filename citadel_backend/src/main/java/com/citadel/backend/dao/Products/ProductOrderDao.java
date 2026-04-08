package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Products.ProductDividendSchedule;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.vo.Agent.AgentPersonalSalesDetailsVo;
import com.citadel.backend.vo.Commission.CommissionProductOrderVo;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderInterfaceVo;
import com.citadel.backend.vo.Product.PhysicalTrustDeedReminderVo;
import com.citadel.backend.vo.Transaction.TransactionVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface ProductOrderDao extends JpaRepository<ProductOrder, Long> {
    List<ProductOrder> findAllByClient(Client client);

    List<ProductOrder> findAllByCorporateClient(CorporateClient client);

    Optional<ProductOrder> findByOrderReferenceNumberAndClient(String orderReferenceNumber, Client client);

    Optional<ProductOrder> findByOrderReferenceNumberAndCorporateClient(String orderReferenceNumber, CorporateClient corporateClient);

    Optional<ProductOrder> findByOrderReferenceNumber(String orderReferenceNumber);

    ProductOrder findByOrderReferenceNumberAndStatusAndStatusApprover(String orderReferenceNumber, ProductOrder.ProductOrderStatus status, CmsAdmin.ApproverStatus statusApprover);

    @Query("SELECT po FROM ProductOrder po " +
            "WHERE po.status = :status " +
            "AND po.payoutFrequency = :payoutFrequency " +
            "AND po.structureType = :structureType " +
            "AND (po.periodEndingDate IS NULL OR po.periodEndingDate < :currentDate) " +
            "AND (po.periodStartingDate IS NULL OR po.periodEndingDate < :currentDate) " +
            "AND (po.lastDividendCalculationDate IS NULL OR po.lastDividendCalculationDate < po.periodEndingDate)")
    List<ProductOrder> findAllProductOrdersForDividendCalculation(@Param("status") ProductOrder.ProductOrderStatus status,
                                                                  @Param("payoutFrequency") ProductDividendSchedule.FrequencyOfPayout payoutFrequency,
                                                                  @Param("structureType") ProductDividendSchedule.StructureType structureType,
                                                                  @Param("currentDate") LocalDate currentDate);

    @Query("SELECT po FROM ProductOrder po " +
            "WHERE po.status = :status " +
            "AND po.endTenure < :queryDate")
    List<ProductOrder> findAllProductOrdersForMaturityCalculation(@Param("status") ProductOrder.ProductOrderStatus status,
                                                                  @Param("queryDate") LocalDate queryDate);

    @Query("SELECT po.id FROM ProductOrder po WHERE po.client = :client")
    List<Long> findAllByClientForDividendHistory(@Param("client") Client client);

    @Query("SELECT po.id FROM ProductOrder po WHERE po.corporateClient = :corporateClient")
    List<Long> findAllByCorporateClientForDividendHistory(@Param("corporateClient") CorporateClient corporateClient);

    @Query("SELECT new com.citadel.backend.vo.Transaction.TransactionVo(" +
            "po.id, " +
            "po.product.code, " +
            "po.agreementFileName, " +
            "po.paymentDate, " +
            "po.purchasedAmount, " +
            "po.bank.bankName, " +
            "po.agreementFileName) " +
            "FROM ProductOrder po " +
            "WHERE po.client.id = :clientId " +
            "AND po.paymentStatus = :status")
    List<TransactionVo> findAllPlacementTransactionsByClient(@Param("clientId") Long clientId,
                                                             @Param("status") Status status);

    @Query("SELECT new com.citadel.backend.vo.Transaction.TransactionVo(" +
            "po.id, " +
            "po.product.code, " +
            "po.agreementFileName, " +
            "po.paymentDate, " +
            "po.purchasedAmount, " +
            "po.bank.bankName, " +
            "po.agreementFileName) " +
            "FROM ProductOrder po " +
            "WHERE po.corporateClient.id = :corporateClientId " +
            "AND po.paymentStatus = :status")
    List<TransactionVo> findAllByCorporateClientAndPaymentStatus(@Param("corporateClientId") Long corporateClientId,
                                                                 @Param("status") Status status);

    @Query("SELECT new com.citadel.backend.vo.Commission.CommissionProductOrderVo(" +
            "po.id, " +
            "po.agency.id, " +
            "po.agency.agencyName, " +
            "po.productOrderType, " +
            "po.submissionDate, " +
            "po.agreementDate, " +
            "po.clientName, " +
            "po.agreementFileName, " +
            "po.purchasedAmount, " +
            "po.product.id) " +
            "FROM ProductOrder po " +
            "WHERE po.agency.id = :agencyId " +
            "AND po.agreementDate IS NOT NULL " +
            "AND po.agreementDate BETWEEN :startDate AND :endDate " +
            "AND po.status =:status " +
            "AND po.product.id IN :productIdList")
    List<CommissionProductOrderVo> findProductOrdersByAgencyAndByDateRange(@Param("agencyId") Long agencyId,
                                                                           @Param("startDate") LocalDate startDate,
                                                                           @Param("endDate") LocalDate endDate,
                                                                           @Param("status") ProductOrder.ProductOrderStatus status,
                                                                           @Param("productIdList") Set<Long> productIdList);

    @Query("SELECT new com.citadel.backend.vo.Commission.CommissionProductOrderVo(" +
            "po.id, " +
            "po.agency.id, " +
            "po.agency.agencyName, " +
            "po.productOrderType, " +
            "po.submissionDate, " +
            "po.agreementDate, " +
            "po.clientName, " +
            "po.agreementFileName, " +
            "po.purchasedAmount, " +
            "po.product.id) " +
            "FROM ProductOrder po " +
            "WHERE po.startTenure = :comparingDate " +
            "AND po.product.id = :productId " +
            "AND (po.status = 'ACTIVE' OR po.status = 'MATURED') " +
            "AND :comparingDate <= po.endTenure " +
            "AND po.productOrderType = :productOrderType " +
            "AND po.agency.id IN :agencyId")
    List<CommissionProductOrderVo> findProductOrdersByAgencyAndByYearInterval(@Param("comparingDate") LocalDate comparingDate,
                                                                              @Param("productId") Long productId,
                                                                              @Param("productOrderType") ProductOrderType productOrderType,
                                                                              @Param("agencyId") List<Long> agencyId);

    @Query("SELECT new com.citadel.backend.vo.Commission.CommissionProductOrderVo(" +
            "po.id, " +
            "po.agency.id, " +
            "po.agency.agencyName, " +
            "po.productOrderType, " +
            "po.submissionDate, " +
            "po.agreementDate, " +
            "po.clientName, " +
            "po.agreementFileName, " +
            "po.purchasedAmount, " +
            "po.product.id) " +
            "FROM ProductOrder po " +
            "WHERE po.agent.id = :agentId " +
            "AND po.agreementDate IS NOT NULL " +
            "AND po.agreementDate BETWEEN :startDate AND :endDate " +
            "AND po.status =:status " +
            "AND po.product.id IN :productIdList")
    List<CommissionProductOrderVo> findProductOrdersByAgentAndByDateRange(@Param("agentId") Long agentId,
                                                                          @Param("startDate") LocalDate startDate,
                                                                          @Param("endDate") LocalDate endDate,
                                                                          @Param("status") ProductOrder.ProductOrderStatus status,
                                                                          @Param("productIdList") Set<Long> productIdList);

    @Query("SELECT new com.citadel.backend.vo.Commission.CommissionProductOrderVo(" +
            "po.id, " +
            "po.agency.id, " +
            "po.agency.agencyName, " +
            "po.productOrderType, " +
            "po.submissionDate, " +
            "po.agreementDate, " +
            "po.clientName, " +
            "po.agreementFileName, " +
            "po.purchasedAmount, " +
            "po.product.id) " +
            "FROM ProductOrder po " +
            "WHERE po.startTenure = :comparingDate " +
            "AND po.product.id = :productId " +
            "AND (po.status = 'ACTIVE' OR po.status = 'MATURED') " +
            "AND :comparingDate <= po.endTenure " +
            "AND po.productOrderType = :productOrderType " +
            "AND po.agent.id = :agentId")
    List<CommissionProductOrderVo> findProductOrdersByAgentAndByYearInterval(@Param("comparingDate") LocalDate comparingDate,
                                                                             @Param("productId") Long productId,
                                                                             @Param("productOrderType") ProductOrderType productOrderType,
                                                                             @Param("agentId") Long agentId);

    List<ProductOrder> findProductOrdersByAgentAndClientAgreementStatusAndWitnessAgreementStatus(Agent agent, Status status, Status status1);

    @Query("SELECT SUM(po.purchasedAmount) FROM ProductOrder po " +
            "WHERE po.agent.id = :agentId " +
            "AND po.agreementDate IS NOT NULL " +
            "AND po.agreementDate BETWEEN :startDate AND :endDate " +
            "AND po.status = :status ")
    Optional<Double> findTotalSalesByAgentAndByPeriod(@Param("agentId") Long agentId,
                                                      @Param("startDate") LocalDate startDate,
                                                      @Param("endDate") LocalDate endDate,
                                                      @Param("status") ProductOrder.ProductOrderStatus status);

    @Query("SELECT COUNT(po) FROM ProductOrder po " +
            "WHERE po.agent.id = :agentId " +
            "AND po.agreementDate IS NOT NULL " +
            "AND po.agreementDate BETWEEN :startDate AND :endDate " +
            "AND po.status = :status")
    Optional<Long> findTotalProductsSoldByAgentByDateRange(@Param("agentId") Long agentId,
                                                           @Param("startDate") LocalDate startDate,
                                                           @Param("endDate") LocalDate endDate,
                                                           @Param("status") ProductOrder.ProductOrderStatus status);

    @Query("SELECT new com.citadel.backend.vo.Agent.AgentPersonalSalesDetailsVo(" +
            "po.id, " +
            "po.productOrderType, " +
            "po.clientName, " +
            "COALESCE(CONCAT('', c.clientId), cc.corporateClientId), " +
            "po.product.code, " +
            "po.agreementFileName, " +
            "po.purchasedAmount, " +
            "po.status, " +
            "po.agreementDate) " +
            "FROM ProductOrder po " +
            "LEFT JOIN po.client c " +
            "LEFT JOIN po.corporateClient cc " +
            "WHERE po.agent.id = :agentId " +
            "AND po.status IN :status " +
            "AND po.agreementDate IS NOT NULL " +
            "AND po.agreementDate BETWEEN :startDate AND :endDate " +
            "ORDER BY po.agreementDate DESC")
    List<AgentPersonalSalesDetailsVo> findProductOrdersSoldByAgentAndByDateRange(@Param("agentId") Long agentId,
                                                                                 @Param("startDate") LocalDate startDate,
                                                                                 @Param("endDate") LocalDate endDate,
                                                                                 @Param("status") List<String> status);

    ProductOrder findByAgreementFileName(String agreementFileName);

    @Query("""
            SELECT po.id as id, po.agreementFileName as agreementFileName
            FROM ProductOrder po
            WHERE po.witnessAgreementStatus = 'SUCCESS'
            AND po.receivedPhysicalSignedAgreementFiles IS FALSE
            AND po.witnessSignatureDate IS NOT NULL
            AND po.witnessSignatureDate <= :cutoffDate
            AND po.physicalSignedAgreementFilesReminderSent IS FALSE
            """)
    List<PhysicalTrustDeedReminderInterfaceVo> findProductOrdersForPhysicalTrustDeedReminder(@Param("cutoffDate") LocalDate cutoffDate);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query("UPDATE ProductOrder po SET po.physicalSignedAgreementFilesReminderSent = true WHERE po.id = :id")
    void updatePhysicalSignedAgreementFilesReminderSentById(@Param("id") Long id);

    @Transactional
    @Modifying(clearAutomatically = true)
    @Query("UPDATE ProductOrder po SET po.clientName = :clientName WHERE po.client = :client")
    void updateClientNameByClient(@Param("clientName") String clientName, @Param("client") Client client);

    @Query("SELECT CASE WHEN COUNT(po) > 0 THEN true ELSE false END FROM ProductOrder po " +
            "WHERE po.bank.id = :bankId " +
            "AND po.status NOT IN ('MATURED', 'WITHDRAWN')")
    boolean existsByBankIdAndStatusNotMaturedOrWithdrawn(@Param("bankId") Long bankId);

}