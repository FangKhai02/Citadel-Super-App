package com.citadel.backend.vo.Product;

import com.citadel.backend.entity.Products.ProductBeneficiaries;
import com.citadel.backend.vo.Enum.Relationship;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class FundBeneficiaryDetailsVo {
    private Long beneficiaryId;
    private String beneficiaryName;
    private Relationship relationship;
    private Double distributionPercentage;
    @Schema(description = "List of sub-beneficiaries", example = "[{\"beneficiaryId\": 1,\"beneficiaryName\": \"name\", \"relationship\": FAMILY,\"distributionPercentage\": 50}]")
    private List<FundBeneficiaryDetailsVo> subBeneficiaries;

    public static FundBeneficiaryDetailsVo productOrderBeneficiaryToFundBeneficiaryDetailsVo(ProductBeneficiaries productBeneficiaries) {
        FundBeneficiaryDetailsVo fundBeneficiaryDetailsVo = new FundBeneficiaryDetailsVo();
        if(productBeneficiaries.getBeneficiary() != null) {
            fundBeneficiaryDetailsVo.setBeneficiaryId(productBeneficiaries.getBeneficiary().getId());
            fundBeneficiaryDetailsVo.setBeneficiaryName(productBeneficiaries.getBeneficiary().getFullName());
            fundBeneficiaryDetailsVo.setRelationship(productBeneficiaries.getBeneficiary().getRelationshipToSettlor());
        }else{
            fundBeneficiaryDetailsVo.setBeneficiaryId(productBeneficiaries.getCorporateBeneficiary().getId());
            fundBeneficiaryDetailsVo.setBeneficiaryName(productBeneficiaries.getCorporateBeneficiary().getFullName());
            fundBeneficiaryDetailsVo.setRelationship(productBeneficiaries.getCorporateBeneficiary().getRelationshipToSettlor());
        }
        fundBeneficiaryDetailsVo.setDistributionPercentage(productBeneficiaries.getPercentage());
        return fundBeneficiaryDetailsVo;
    }
}
