package com.citadel.backend.vo.FaceID;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ImageValidateRespVo extends BaseResp {
    private Boolean valid;
    private Double confidence;
    private Double livenessScore;
}
