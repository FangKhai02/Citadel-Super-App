package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductDividendSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDividendScheduleDao extends JpaRepository<ProductDividendSchedule, Long> {
    List<ProductDividendSchedule> findAllByProductId(Long productId);

    @Query(value = "SELECT CASE " +
            "         WHEN MIN(CASE WHEN date_of_month >= :agreementDay THEN date_of_month END) IS NOT NULL " +
            "         THEN MIN(CASE WHEN date_of_month >= :agreementDay THEN date_of_month END) " +
            "         ELSE MAX(date_of_month) " +
            "       END AS payment_day_of_month " +
            "FROM product_dividend_schedule " +
            "WHERE product_id = :productId",
            nativeQuery = true)
    Integer findPaymentDayOfMonth(@Param("productId") Long productId, @Param("agreementDay") Integer agreementDay);

    //DEPRECATED
    @Query("SELECT pds.dateOfMonth FROM ProductDividendSchedule pds WHERE pds.product.id = :productId")
    int getDateOfMonthByProductId(Long productId);
}
