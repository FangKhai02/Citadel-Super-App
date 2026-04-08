package com.citadel.backend.dao.Commission;

import com.citadel.backend.entity.Commission.ProductCommissionHistory;
import com.citadel.backend.vo.Enum.CmsAdmin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductCommissionHistoryDao extends JpaRepository<ProductCommissionHistory, Long> {
    ProductCommissionHistory findByIdAndStatusApproverAndStatusChecker(Long id, CmsAdmin.ApproverStatus statusApprover, CmsAdmin.CheckerStatus statusChecker);
    ProductCommissionHistory findByIdAndStatusApproverAndStatusCheckerAndGeneratedBankFileIsTrue(Long id, CmsAdmin.ApproverStatus statusApprover, CmsAdmin.CheckerStatus statusChecker);
}
