package com.citadel.backend.vo.SignUp.Client;

import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class ClientSignUpReqVo {
    @Valid
    @NotNull
    private ClientIdentityDetailsReqVo identityDetails;
    @Valid
    @NotNull
    private ClientPersonalDetailsReqVo personalDetails;
    @NotBlank
    private String selfieImage;
    @Valid
    @NotNull
    private PepDeclarationVo pepDeclaration;
    @Valid
    @NotNull
    private EmploymentDetailsVo employmentDetails;
    @NotBlank
    private String digitalSignature;
    @NotBlank
    private String password;
}
