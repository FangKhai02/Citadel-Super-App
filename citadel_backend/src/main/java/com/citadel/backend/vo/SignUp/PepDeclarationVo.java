package com.citadel.backend.vo.SignUp;

import com.citadel.backend.entity.PepInfo;
import com.citadel.backend.utils.AwsS3Util;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
@NotNull
public class PepDeclarationVo {
    @NotNull(message = "isPep is required")
    private Boolean isPep;
    private PepDeclarationOptionsVo pepDeclarationOptions;

    public static PepDeclarationVo getPepDeclarationVoFromPepInfo(PepInfo pepInfo) {
        PepDeclarationVo pepDeclarationVo = new PepDeclarationVo();
        pepDeclarationVo.setIsPep(pepInfo.getPep());
        PepDeclarationOptionsVo options = new PepDeclarationOptionsVo();
        if (pepDeclarationVo.getIsPep()) {
            options.setRelationship(pepInfo.getPepType());
            options.setName(pepInfo.getPepImmediateFamilyName());
            options.setPosition(pepInfo.getPepPosition());
            options.setOrganization(pepInfo.getPepOrganisation());
            options.setSupportingDocument(AwsS3Util.getS3DownloadUrl(pepInfo.getPepSupportingDocumentsKey()));
        }
        pepDeclarationVo.setPepDeclarationOptions(options);
        return pepDeclarationVo;
    }
}
