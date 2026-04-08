package com.citadel.backend.vo.Niu;

import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class NiuApplyDocumentVo {
    String filename;//e.g. MyKad.jpg
    String signature;//in base64 format
}
