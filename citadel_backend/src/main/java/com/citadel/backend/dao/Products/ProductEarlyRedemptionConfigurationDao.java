package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.Product;
import com.citadel.backend.entity.Products.ProductEarlyRedemptionConfiguration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductEarlyRedemptionConfigurationDao extends JpaRepository<ProductEarlyRedemptionConfiguration, Long> {

    List<ProductEarlyRedemptionConfiguration> findAllByProduct(Product product);
}
