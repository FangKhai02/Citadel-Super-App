package com.citadel.backend.vo.Commission;

import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.vo.Enum.Status;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AgentEarningVo {
    private String earningType = "Commission";
    private Double commissionAmount;
    private String productCode;
    private String agreementNumber;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date transactionDate;
    private String bankName;
    private String transactionId;
    private Status status;
}
