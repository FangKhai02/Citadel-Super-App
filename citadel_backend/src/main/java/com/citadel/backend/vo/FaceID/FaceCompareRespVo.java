package com.citadel.backend.vo.FaceID;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

/**
 * Response VO for FaceNet-based face comparison.
 * This replaces the previous ImageValidateRespVo.
 */
@Getter
@Setter
public class FaceCompareRespVo extends BaseResp {
    private Boolean verified;     // true if face match passed (score <= 0.45)
    private Double score;         // Euclidean distance (lower = more similar)
    private String message;       // Human-readable message
    private Boolean degraded;     // true if models were unavailable
}
