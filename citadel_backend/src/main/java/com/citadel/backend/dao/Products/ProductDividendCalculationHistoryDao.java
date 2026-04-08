package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductDividendCalculationHistory;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.vo.Enum.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface ProductDividendCalculationHistoryDao extends JpaRepository<ProductDividendCalculationHistory, Long> {
    @Query("SELECT pdch FROM ProductDividendCalculationHistory pdch " +
            "WHERE pdch.productOrder.id IN :productOrderIds AND pdch.paymentStatus = :paymentStatus")
    List<ProductDividendCalculationHistory> findAllByProductOrderIdInAndPaymentStatus(@Param("productOrderIds") List<Long> productOrderIds,
                                                                                      @Param("paymentStatus") Status paymentStatus);

    List<ProductDividendCalculationHistory> findAllByProductOrderOrderByIdAsc(ProductOrder productOrder);

    ProductDividendCalculationHistory findByReferenceNumber(String referenceNumber);

    ProductDividendCalculationHistory findByProductOrderAndPeriodStartingDateAndPeriodEndingDate(ProductOrder productOrder, LocalDate periodStartingDate, LocalDate periodEndingDate);
}
