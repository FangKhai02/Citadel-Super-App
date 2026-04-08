package com.citadel.backend.vo.Agent;

import com.citadel.backend.utils.LocalDateToMillisecondSerializer;
import com.citadel.backend.vo.BaseResp;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class AgentTotalSalesRespVo extends BaseResp {
    private String totalSalesAmount;
    private String percentageDifference;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate currentQuarterStartDate;
    @JsonSerialize(using = LocalDateToMillisecondSerializer.class)
    private LocalDate currentQuarterEndDate;
    private String paymentMethod;
    private Integer totalProductsSold;
}
