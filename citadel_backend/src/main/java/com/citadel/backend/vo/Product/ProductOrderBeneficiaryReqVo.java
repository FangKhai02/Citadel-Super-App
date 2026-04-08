package com.citadel.backend.vo.Product;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductOrderBeneficiaryReqVo {
    private Long beneficiaryId;
    private Double distributionPercentage;
    @Schema(description = "List of sub-beneficiaries", example = "[{\"beneficiaryId\": 1, \"distributionPercentage\": 50}]")
    private List<ProductOrderBeneficiaryReqVo> subBeneficiaries;
}
