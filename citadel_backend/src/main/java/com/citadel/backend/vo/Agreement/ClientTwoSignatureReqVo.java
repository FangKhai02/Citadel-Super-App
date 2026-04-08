package com.citadel.backend.vo.Agreement;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClientTwoSignatureReqVo {
    
    @NotBlank(message = "Unique identifier is required")
    private String uniqueIdentifier;
    
    @NotBlank(message = "Signature image is required")
    private String signatureImage; // Base64 encoded image
    
    @NotBlank(message = "Name is required")
    private String name;
    
    @NotBlank(message = "ID Number is required")
    private String idNumber;
    
    @NotBlank(message = "Role is required")
    private String role;
}