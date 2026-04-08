package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductAgreementSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductAgreementScheduleDao extends JpaRepository<ProductAgreementSchedule, Long> {
}
