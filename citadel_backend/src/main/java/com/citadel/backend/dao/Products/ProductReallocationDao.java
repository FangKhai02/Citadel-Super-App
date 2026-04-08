package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.Products.ProductReallocation;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductReallocationDao extends JpaRepository<ProductReallocation, Long> {
    boolean existsProductReallocationByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    ProductReallocation findByProductOrderAndStatusNot(ProductOrder productOrder, Status status);

    ProductReallocation findByProductOrderAndStatus(ProductOrder productOrder, Status status);

    ProductReallocation findByProductOrderAndStatusIn(ProductOrder productOrder, List<Status> statusList);

    List<ProductReallocation> findAllByProductOrderIn(List<ProductOrder> productOrderList);

    @Query("SELECT pr FROM ProductReallocation pr " +
            "WHERE pr.productOrder.id = :productOrderId " +
            "AND pr.status = :status " +
            "AND pr.reallocateProductOrder.status = :rolloverStatus " +
            "AND pr.reallocateProductOrder.statusFinance = :statusFinance")
    ProductReallocation findProductReallocationPendingActivation(@Param("productOrderId") Long productOrderId,
                                                                 @Param("status") Status status,
                                                                 @Param("rolloverStatus") ProductOrder.ProductOrderStatus rolloverStatus,
                                                                 @Param("statusFinance") CmsAdmin.FinanceStatus statusFinance);

    @Query(value = "SELECT * FROM product_reallocation " +
            "WHERE product_order_id = :productOrderId ORDER BY created_at DESC LIMIT 1", nativeQuery = true)
    ProductReallocation findMostRecentRecord(@Param("productOrderId") Long productOrderId);
}
