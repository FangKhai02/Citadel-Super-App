package com.citadel.backend.vo.Product;

import com.citadel.backend.vo.Enum.RedemptionMethod;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class ProductEarlyRedemptionReqVo {
    @NotNull
    private String orderReferenceNumber;;
    private Double withdrawalAmount;
    @NotNull
    private RedemptionMethod withdrawalMethod;
    private String withdrawalReason;
    private String supportingDocumentKey;
}
