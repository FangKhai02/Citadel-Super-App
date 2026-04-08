package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.Product;
import com.citadel.backend.vo.Product.ProductBankDetailsRespVo;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface ProductDao extends JpaRepository<Product, Long> {
    List<Product> findAllByIsPublishedIsTrue();

    List<Product> findAllByIsPublishedIsTrueAndStatusIsTrue();

    Optional<Product> findByIdAndIsPublishedIsTrueAndStatusIsTrue(Long id);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT p FROM Product p WHERE p.id = :productId")
    Product findProductForUpdate(@Param("productId") Long productId);

    @Query("SELECT p.code FROM Product p WHERE p.id = :productId")
    String findProductCodeByProductId(@Param("productId") Long productId);

    Optional<Product> findByCode(String code);

    @Query("SELECT p.code FROM Product p")
    Set<String> findAllProductCodes();

    @Query("SELECT p.bankName FROM Product p WHERE p.id = :id")
    Optional<String> findProductBankById(Long id);

    @Query("SELECT new com.citadel.backend.vo.Product.ProductBankDetailsRespVo(p.bankName, p.bankAccountName, p.bankAccountNumber) FROM Product p WHERE p.code = :code")
    ProductBankDetailsRespVo findProductBankDetails(@Param("code") String code);

    @Query("SELECT new com.citadel.backend.vo.Product.ProductBankDetailsRespVo(p.bankName, p.bankAccountName, p.bankAccountNumber) FROM Product p WHERE p.name = :name")
    ProductBankDetailsRespVo findProductBankDetailsByName(@Param("name") String name);
}
