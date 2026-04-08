package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductReallocationConfiguration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductReallocationConfigurationDao extends JpaRepository<ProductReallocationConfiguration, Long> {

    @Query("SELECT p.reallocatableProduct.code FROM ProductReallocationConfiguration p WHERE p.product.id = :productId")
    List<String> findAllReallocatableProductCodeByProduct(Long productId);
}
