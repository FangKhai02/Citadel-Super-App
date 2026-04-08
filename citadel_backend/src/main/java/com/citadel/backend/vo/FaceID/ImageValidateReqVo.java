package com.citadel.backend.vo.FaceID;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ImageValidateReqVo {
    private String idPhoto;//Base64
    private String selfie;//Base64
    private String idNumber;
    private Double confidence;
    private Double livenessScore;
}
