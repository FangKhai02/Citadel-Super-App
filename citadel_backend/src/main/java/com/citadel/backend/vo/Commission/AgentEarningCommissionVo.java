package com.citadel.backend.vo.Commission;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;


@Getter
@Setter
public class AgentEarningCommissionVo {
    private Double commissionPercentage;
    private Double commissionAmount;
    private Date paymentDate;

    public AgentEarningCommissionVo(Double commissionPercentage, Double commissionAmount, Date paymentDate) {
        this.commissionPercentage = commissionPercentage;
        this.commissionAmount = commissionAmount;
        this.paymentDate = paymentDate;
    }
}
