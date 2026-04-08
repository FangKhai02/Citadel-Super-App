package com.citadel.backend.vo.Client;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.LocalDateToMillisecondSerializer;
import com.citadel.backend.vo.Enum.CmsAdmin;
import com.citadel.backend.vo.Enum.Status;
import com.citadel.backend.vo.Product.PortfolioProductOrderOptionsVo;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class ClientPortfolioVo {
    private String clientId;
    private String clientName;
    private String orderReferenceNumber;
    private String productName;
    private String productCode;
    private String productType;
    private Double purchasedAmount;
    private ProductOrder.ProductOrderStatus status;
    private String remark;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date productPurchaseDate;
    private Status clientAgreementStatus;
    private Status witnessAgreementStatus;
    private Long productId;
    private Double productDividendAmount;
    private Integer productTenureMonth;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate clientSignatureDate;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate agreementDate;
    private PortfolioProductOrderOptionsVo optionsVo;

    public static ClientPortfolioVo productOrderToClientPortfolioVo(ProductOrder productOrder) {
        ClientPortfolioVo clientProductPurchasedVo = new ClientPortfolioVo();
        clientProductPurchasedVo.setClientId(productOrder.getClientId());
        clientProductPurchasedVo.setClientName(productOrder.getClientName());
        clientProductPurchasedVo.setOrderReferenceNumber(productOrder.getOrderReferenceNumber());
        clientProductPurchasedVo.setProductName(productOrder.getProduct().getName());
        clientProductPurchasedVo.setProductCode(productOrder.getProduct().getCode());
        clientProductPurchasedVo.setProductType(productOrder.getProduct().getProductType().getName());
        clientProductPurchasedVo.setPurchasedAmount(productOrder.getPurchasedAmount());
        clientProductPurchasedVo.setStatus(productOrder.getStatus());
        clientProductPurchasedVo.setRemark(productOrder.getRemark());
        // If the product order is active and the approver status is pending, show the status to in review
        if (ProductOrder.ProductOrderStatus.ACTIVE.equals(productOrder.getStatus()) && CmsAdmin.ApproverStatus.PENDING_APPROVER.equals(productOrder.getStatusApprover())) {
            clientProductPurchasedVo.setStatus(ProductOrder.ProductOrderStatus.IN_REVIEW);
        }
        if (Status.PENDING.equals(productOrder.getClientAgreementStatus()) || Status.PENDING.equals(productOrder.getWitnessAgreementStatus())) {
            clientProductPurchasedVo.setStatus(ProductOrder.ProductOrderStatus.AGREEMENT);
        }
        // Check if second signee is required for corporate clients
        if (productOrder.requireSecondSigneeSignature() && !Status.SUCCESS.equals(productOrder.getClientTwoAgreementStatus())) {
            clientProductPurchasedVo.setStatus(ProductOrder.ProductOrderStatus.SECOND_SIGNEE);
            clientProductPurchasedVo.setRemark("Pending 2nd Signee");
        }
        clientProductPurchasedVo.setProductPurchaseDate(productOrder.getCreatedAt());
        clientProductPurchasedVo.setClientAgreementStatus(productOrder.getClientAgreementStatus());
        clientProductPurchasedVo.setWitnessAgreementStatus(productOrder.getWitnessAgreementStatus());
        clientProductPurchasedVo.setProductId(productOrder.getProduct().getId());
        clientProductPurchasedVo.setProductDividendAmount(productOrder.getDividend());
        clientProductPurchasedVo.setProductTenureMonth(productOrder.getInvestmentTenureMonth());
        if (productOrder.getClientSignatureDate() != null) {
            clientProductPurchasedVo.setClientSignatureDate(productOrder.getClientSignatureDate());
        }
        clientProductPurchasedVo.setAgreementDate(productOrder.getAgreementDate());
        return clientProductPurchasedVo;
    }
}
