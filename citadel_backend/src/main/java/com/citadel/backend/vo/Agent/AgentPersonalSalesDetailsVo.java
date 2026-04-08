package com.citadel.backend.vo.Agent;

import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.LocalDateToMillisecondSerializer;
import com.citadel.backend.vo.Enum.ProductOrderType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class AgentPersonalSalesDetailsVo {
    @JsonIgnore
    private Long productOrderId;
    private ProductOrderType productOrderType;
    private String clientName;
    private String clientId;
    private String code;
    private String agreementFileName;
    private Double purchasedAmount;
    @JsonIgnore
    private ProductOrder.ProductOrderStatus status;
    @JsonIgnore
    private LocalDate agreementDate;
    //Commission calculation
    private String productStatus;//arbitrage of status
    private Double commissionPercentage;
    private Double commissionAmount;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate calculatedDate;

    public AgentPersonalSalesDetailsVo(Long productOrderId, ProductOrderType productOrderType, String clientName, String clientId, String code, String agreementFileName, Double purchasedAmount, ProductOrder.ProductOrderStatus status, LocalDate agreementDate) {
        this.productOrderId = productOrderId;
        this.productOrderType = productOrderType;
        this.clientName = clientName;
        this.clientId = clientId;
        this.code = code;
        this.agreementFileName = agreementFileName;
        this.purchasedAmount = purchasedAmount;
        this.status = status;
        this.agreementDate = agreementDate;
    }
}
