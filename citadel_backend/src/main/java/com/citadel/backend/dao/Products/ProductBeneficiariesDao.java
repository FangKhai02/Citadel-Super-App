package com.citadel.backend.dao.Products;

import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.entity.Products.ProductBeneficiaries;
import com.citadel.backend.entity.Products.ProductOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductBeneficiariesDao extends JpaRepository<ProductBeneficiaries, Long> {
    List<ProductBeneficiaries> findByProductOrder(ProductOrder productOrder);

    ProductBeneficiaries findByProductOrderAndBeneficiary(ProductOrder productOrder, IndividualBeneficiary beneficiary);

    ProductBeneficiaries findByProductOrderAndCorporateBeneficiary(ProductOrder productOrder, CorporateBeneficiaries corporateBeneficiary);

    @Query("SELECT CASE " +
            "WHEN pb.beneficiary IS NOT NULL THEN pb.beneficiary.identityCardNumber " +
            "WHEN pb.corporateBeneficiary IS NOT NULL THEN pb.corporateBeneficiary.identityCardNumber " +
            "ELSE NULL END " +
            "FROM ProductBeneficiaries pb " +
            "WHERE pb.productOrder = :productOrder " +
            "AND (pb.beneficiary IS NOT NULL OR pb.corporateBeneficiary IS NOT NULL)")
    List<String> findBeneficiaryIdentityCardNumbersByProductOrder(@Param("productOrder") ProductOrder productOrder);

    List<ProductBeneficiaries> findAllByProductOrder(ProductOrder productOrder);

    List<ProductBeneficiaries> findAllByProductOrderAndMainBeneficiaryIsNotNull(ProductOrder productOrder);

    @Query("SELECT CASE WHEN COUNT(pb) > 0 THEN true ELSE false END FROM ProductBeneficiaries pb " +
            "WHERE (pb.beneficiary.id = :beneficiaryId OR pb.mainBeneficiary.id = :beneficiaryId) " +
            "AND pb.productOrder.status NOT IN ('MATURED', 'WITHDRAWN')")
    boolean existsByBeneficiaryInActiveProductOrders(@Param("beneficiaryId") Long beneficiaryId);
}
