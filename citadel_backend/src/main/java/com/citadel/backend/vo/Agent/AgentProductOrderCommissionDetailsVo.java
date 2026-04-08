package com.citadel.backend.vo.Agent;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.LocalDateToMillisecondSerializer;
import com.citadel.backend.vo.Enum.Status;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
public class AgentProductOrderCommissionDetailsVo {
    private String earningType = "Commission";
    @JsonIgnore
    private Long productId;
    @JsonIgnore
    private Long productOrderId;
    private double commissionPercentage;
    private double commissionAmount;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate calculatedDate;
    private String productCode;
    private String productName;
    private String agreementName;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date transactionDate;
    private Status status;


    public AgentProductOrderCommissionDetailsVo(Long productId, Long productOrderId,
                                                double commissionPercentage, double commissionAmount,
                                                LocalDate calculatedDate,String orderAgreementNumber,
                                                String productCode,String productName,Status status,
                                                Date paymentDate) {
        this.productId = productId;
        this.productOrderId = productOrderId;
        this.commissionPercentage = commissionPercentage;
        this.commissionAmount = commissionAmount;
        this.calculatedDate = calculatedDate;
        this.productCode = productCode;
        this.productName = productName;
        this.agreementName = orderAgreementNumber;
        this.transactionDate = paymentDate;
        this.status = status;
    }

}
