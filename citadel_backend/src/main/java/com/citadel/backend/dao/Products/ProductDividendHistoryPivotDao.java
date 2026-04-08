package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductDividendCalculationHistory;
import com.citadel.backend.entity.Products.ProductDividendHistory;
import com.citadel.backend.entity.Products.ProductDividendHistoryPivot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDividendHistoryPivotDao extends JpaRepository<ProductDividendHistoryPivot, Long> {

    @Query("SELECT pdhp.productDividendCalculationHistory FROM ProductDividendHistoryPivot pdhp " +
            "WHERE pdhp.productDividendHistory = :productDividendHistory " +
            "AND pdhp.productDividendCalculationHistory.productOrder.product.bankName = :bankName")
    List<ProductDividendCalculationHistory> getProductDividendCalculationHistoriesByProductDividendHistoryAndBankName(
            @Param("productDividendHistory") ProductDividendHistory productDividendHistory,
            @Param("bankName") String bankName);
}
