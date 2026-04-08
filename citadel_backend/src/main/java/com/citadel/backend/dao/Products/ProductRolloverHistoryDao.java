package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.Products.ProductRolloverHistory;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRolloverHistoryDao extends JpaRepository<ProductRolloverHistory, Long> {
    boolean existsProductRolloverHistoryByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    ProductRolloverHistory findByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    ProductRolloverHistory findByProductOrderAndStatus(ProductOrder productOrder, Status status);

    ProductRolloverHistory findByProductOrderAndStatusInAndRolloverProductOrderIsNotNull(ProductOrder productOrder, List<Status> statusList);

    List<ProductRolloverHistory> findAllByProductOrderIn(List<ProductOrder> productOrderList);

    @Query("SELECT prh FROM ProductRolloverHistory prh " +
            "WHERE prh.productOrder.id = :productOrderId " +
            "AND prh.status = :status " +
            "AND prh.rolloverProductOrder.status = :rolloverStatus " +
            "AND prh.rolloverProductOrder.statusFinance = :statusFinance")
    ProductRolloverHistory findProductRolloverPendingActivation(@Param("productOrderId") Long productOrderId,
                                                                @Param("status") Status status,
                                                                @Param("rolloverStatus") ProductOrder.ProductOrderStatus rolloverStatus,
                                                                @Param("statusFinance") CmsAdmin.FinanceStatus statusFinance);

    @Query(value = "SELECT * FROM product_rollover_history " +
            "WHERE product_order_id = :productOrderId ORDER BY created_at DESC LIMIT 1", nativeQuery = true)
    ProductRolloverHistory findMostRecentRecord(@Param("productOrderId") Long productOrderId);
}
