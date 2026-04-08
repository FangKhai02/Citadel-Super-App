package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.vo.Enum.Relationship;
import com.citadel.backend.vo.SignUp.PepDeclarationOptionsVo;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CorporateShareholderEditPepReqVo {
    private Long corporateShareholderId;
    @NotNull(message = "isPep is required")
    private Boolean isPep;
    private Relationship relationship;
    private String name;
    private String position;
    private String organization;
    private String supportingDocument;
}
