package com.citadel.backend.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GetMaintenanceRespVo extends BaseResp {
    String startDatetime, endDatetime;
}
