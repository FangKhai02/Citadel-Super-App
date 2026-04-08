package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.BankDetails.BankDetailsVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Product.FundBeneficiaryDetailsVo;
import com.citadel.backend.vo.Product.ProductOrderDocumentsVo;
import com.citadel.backend.vo.Product.ProductOrderPaymentDetailsVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ClientPortfolioProductDetailsRespVo extends BaseResp {
    private ClientPortfolioVo clientPortfolio;
    private BankDetailsVo bankDetails;
    private List<FundBeneficiaryDetailsVo> fundBeneficiaries;
    private ProductOrderPaymentDetailsVo paymentDetails;
    private ProductOrderDocumentsVo documents;
    private String agreementNumber;
    private boolean rolloverAllowed = false;
    private boolean fullRedemptionAllowed = false;
    private boolean reallocationAllowed = false;
    private boolean earlyRedemptionAllowed = false;
    private boolean displayShareAgreementButton = false;
}
