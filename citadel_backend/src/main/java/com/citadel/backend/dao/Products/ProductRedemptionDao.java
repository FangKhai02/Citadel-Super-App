package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductRedemption;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.Products.ProductRolloverHistory;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Transaction.TransactionVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface ProductRedemptionDao extends JpaRepository<ProductRedemption, Long> {

    boolean existsProductRedemptionByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    ProductRedemption findByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    @Query("SELECT new com.citadel.backend.vo.Transaction.TransactionVo(" +
            "pr.id, " +
            "pr.productOrder.product.code, " +
            "pr.productOrder.agreementFileName, " +
            "pr.paymentDate, " +
            "pr.amount, " +
            "pr.productOrder.bank.bankName, " +
            "pr.productOrder.agreementFileName) " +
            "FROM ProductRedemption pr " +
            "WHERE pr.paymentStatus = :status " +
            "AND pr.productOrder.id IN (:productOrderId)")
    List<TransactionVo> findRedemptionTransactions(@Param("status") Status status,
                                                   @Param("productOrderId") Set<Long> productOrderId);

    @Query(value = "SELECT * FROM product_redemption " +
            "WHERE product_order_id = :productOrderId " +
            "AND type = 'FULL' " +
            "ORDER BY created_at DESC LIMIT 1", nativeQuery = true)
    ProductRedemption findMostRecentRecord(@Param("productOrderId") Long productOrderId);

    ProductRedemption findByIdAndStatus(Long id, Status status);

    ProductRedemption findByIdAndStatusAndBankResultCsvIsNotNull(Long id, Status status);

    ProductRedemption findByProductOrder(ProductOrder productOrder);
}
