package com.citadel.backend.vo.Product.resp;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Product.FundBeneficiaryDetailsVo;
import com.citadel.backend.vo.Product.ProductOrderPaymentDetailsBaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ProductOrderSummaryRespVo extends BaseResp {
    private ProductOrder.ProductOrderStatus productOrderStatus;
    private Long productId;
    private String productOrderReferenceNumber;
    private String productName;
    private Double purchasedAmount;
    private Double dividend;
    private Integer investmentTenureMonth;
    private BankDetailsVo bankDetails;
    private List<FundBeneficiaryDetailsVo> productBeneficiaries;
    private ProductOrderPaymentDetailsBaseVo paymentDetails;
}
