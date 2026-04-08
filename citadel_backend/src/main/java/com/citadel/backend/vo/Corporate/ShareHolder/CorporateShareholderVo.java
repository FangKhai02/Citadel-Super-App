package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.entity.Corporate.CorporateShareholder;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.vo.SignUp.PepDeclarationOptionsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateShareholderVo extends CorporateShareholderBaseVo {
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private PepDeclarationVo pepDeclaration;

    public static CorporateShareholderVo corporateShareholderToCorporateShareholderVo(CorporateShareholder corporateShareHolder) {
        CorporateShareholderVo corporateShareHolderVo = new CorporateShareholderVo();
        corporateShareHolderVo.setId(corporateShareHolder.getId());
        corporateShareHolderVo.setName(corporateShareHolder.getName());
        corporateShareHolderVo.setPercentageOfShareholdings(corporateShareHolder.getPercentageOfShareholdings());
        corporateShareHolderVo.setStatus(corporateShareHolder.getStatus());
        corporateShareHolderVo.setMobileCountryCode(corporateShareHolder.getMobileCountryCode());
        corporateShareHolderVo.setMobileNumber(corporateShareHolder.getMobileNumber());
        corporateShareHolderVo.setEmail(corporateShareHolder.getEmail());
        corporateShareHolderVo.setAddress(corporateShareHolder.getAddress());
        corporateShareHolderVo.setPostcode(corporateShareHolder.getPostcode());
        corporateShareHolderVo.setCity(corporateShareHolder.getCity());
        corporateShareHolderVo.setState(corporateShareHolder.getState());
        corporateShareHolderVo.setCountry(corporateShareHolder.getCountry());
        PepDeclarationVo pepDeclaration = new PepDeclarationVo();
        pepDeclaration.setIsPep(corporateShareHolder.getPepInfo().getPep());
        if (pepDeclaration.getIsPep()) {
            PepDeclarationOptionsVo options = new PepDeclarationOptionsVo();
            options.setRelationship(corporateShareHolder.getPepInfo().getPepType());
            options.setName(corporateShareHolder.getPepInfo().getPepImmediateFamilyName());
            options.setPosition(corporateShareHolder.getPepInfo().getPepPosition());
            options.setOrganization(corporateShareHolder.getPepInfo().getPepOrganisation());
            options.setSupportingDocument(AwsS3Util.getS3DownloadUrl(corporateShareHolder.getPepInfo().getPepSupportingDocumentsKey()));
            pepDeclaration.setPepDeclarationOptions(options);
        }
        corporateShareHolderVo.setPepDeclaration(pepDeclaration);
        return corporateShareHolderVo;
    }
}
