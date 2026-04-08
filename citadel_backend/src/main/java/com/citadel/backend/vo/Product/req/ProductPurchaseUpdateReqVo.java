package com.citadel.backend.vo.Product.req;

import com.citadel.backend.vo.Enum.PaymentMethod;
import com.citadel.backend.vo.Product.ProductOrderBeneficiaryReqVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductPurchaseUpdateReqVo {
    private Long clientBankId;
    private PaymentMethod paymentMethod;
    private List<ProductOrderBeneficiaryReqVo> beneficiaries;
}
