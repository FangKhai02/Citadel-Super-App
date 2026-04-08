package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Products.ProductDividendHistory;
import com.citadel.backend.vo.Enum.CmsAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDividendHistoryDao extends JpaRepository<ProductDividendHistory, Long> {
    ProductDividendHistory findProductDividendHistoryByIdAndStatusCheckerAndStatusApproverAndGeneratedBankFileIsFalse(Long id, CmsAdmin.CheckerStatus statusChecker, CmsAdmin.ApproverStatus statusApprover);

    ProductDividendHistory findProductDividendHistoryByIdAndStatusCheckerAndStatusApproverAndGeneratedBankFileIsTrue(Long id, CmsAdmin.CheckerStatus statusChecker, CmsAdmin.ApproverStatus statusApprover);
}
