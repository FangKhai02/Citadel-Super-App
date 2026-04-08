package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.Products.ProductOrderPaymentReceipt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductOrderPaymentReceiptDao extends JpaRepository<ProductOrderPaymentReceipt, Long> {
    List<ProductOrderPaymentReceipt> findAllByProductOrder(ProductOrder productOrder);

    boolean existsByProductOrderAndUploadStatus(ProductOrder productOrder, ProductOrderPaymentReceipt.UploadStatus uploadStatus);
}
