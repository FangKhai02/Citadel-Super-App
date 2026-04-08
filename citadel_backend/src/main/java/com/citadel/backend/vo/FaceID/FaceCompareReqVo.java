package com.citadel.backend.vo.FaceID;

import lombok.Getter;
import lombok.Setter;

/**
 * Request VO for FaceNet-based face comparison via sidecar service.
 * This replaces the previous Microblink/NexID-based ImageValidateReqVo.
 */
@Getter
@Setter
public class FaceCompareReqVo {
    private String documentImage;  // Base64 encoded ID document image
    private String selfieImage;    // Base64 encoded selfie image
    private String documentType;   // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
    private String fullName;
    private String documentNumber;
    private String dateOfBirth;   // Format: yyyy-MM-dd
    private String gender;        // MALE, FEMALE, OTHER
    private String nationality;
}
