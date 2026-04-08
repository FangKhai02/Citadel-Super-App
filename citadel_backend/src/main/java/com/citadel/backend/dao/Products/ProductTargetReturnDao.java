package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductTargetReturn;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ProductTargetReturnDao extends JpaRepository<ProductTargetReturn, Long> {

    List<ProductTargetReturn> findByProductId(Long productId);
}
