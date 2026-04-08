package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.Products.ProductEarlyRedemptionHistory;
import com.citadel.backend.vo.Enum.RedemptionMethod;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Transaction.TransactionVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface ProductEarlyRedemptionHistoryDao extends JpaRepository<ProductEarlyRedemptionHistory, Long> {
    List<ProductEarlyRedemptionHistory> findAllByProductOrderIn(List<ProductOrder> productOrderList);

    ProductEarlyRedemptionHistory findByOrderReferenceNumberAndWithdrawalMethodAndStatusIn(String orderReferenceNumber, RedemptionMethod withdrawalMethod, List<Status> withdrawalStatus);

    Optional<ProductEarlyRedemptionHistory> findByRedemptionReferenceNumber(String redemptionReferenceNumber);

    boolean existsByOrderReferenceNumberAndWithdrawalMethodAndStatusIn(String orderReferenceNumber, RedemptionMethod withdrawalMethod, List<Status> withdrawalStatus);

    boolean existsByOrderReferenceNumberAndStatus(String orderReferenceNumber, Status withdrawalStatus);

    @Query("SELECT new com.citadel.backend.vo.Transaction.TransactionVo(" +
            "pr.id, " +
            "pr.productOrder.product.code, " +
            "pr.productOrder.agreementFileName, " +
            "pr.paymentDate, " +
            "pr.amount, " +
            "pr.productOrder.bank.bankName, " +
            "pr.productOrder.agreementFileName) " +
            "FROM ProductEarlyRedemptionHistory pr " +
            "WHERE pr.paymentStatus = :status " +
            "AND pr.productOrder.id IN (:productOrderId)")
    List<TransactionVo> findEarlyRedemptionTransactions(@Param("status") Status status,
                                                        @Param("productOrderId") Set<Long> productOrderId);

    @Query(value = "SELECT * FROM product_early_redemption_history " +
            "WHERE product_order_id = :productOrderId ORDER BY created_at DESC LIMIT 1", nativeQuery = true)
    ProductEarlyRedemptionHistory findMostRecentRecord(@Param("productOrderId") Long productOrderId);

    ProductEarlyRedemptionHistory findByIdAndStatus(Long id, Status status);

    ProductEarlyRedemptionHistory findByIdAndStatusAndBankResultCsvIsNotNull(Long id, Status status);

    List<ProductEarlyRedemptionHistory> findByAgentAndClientSignatureStatusAndWitnessSignatureStatusOrderByClientSignatureDateAsc(Agent agent, Status clientSignatureStatus, Status witnessSignatureStatus);
}
