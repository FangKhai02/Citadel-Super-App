package com.citadel.backend.vo.SignUp;

import com.citadel.backend.vo.Enum.IdentityDocumentType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
@NotNull
public class SignUpBaseIdentityDetailsVo {
    @NotBlank
    @Size(max = 100)
    private String fullName;
    @NotBlank
    private String identityCardNumber;
    @NotNull
    private Long dob;
    @NotNull
    private IdentityDocumentType identityDocumentType;
    @NotNull
    private String identityCardFrontImage;
    private String identityCardBackImage;
}
