package com.citadel.backend.vo.Product.req;

import com.citadel.backend.vo.Enum.PaymentMethod;
import com.citadel.backend.vo.Product.ProductOrderBeneficiaryReqVo;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Valid
public class ProductPurchaseReqVo {
    private ProductPurchaseProductDetailsVo productDetails;
    private Boolean livingTrustOptionEnabled;
    private Long clientBankId;
    private List<ProductOrderBeneficiaryReqVo> beneficiaries;
    private PaymentMethod paymentMethod;
    private String clientId;
    private String corporateClientId;
}
