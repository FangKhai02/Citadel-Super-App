package com.citadel.backend.vo.Corporate.Beneficiary;

import com.citadel.backend.entity.Corporate.CorporateBeneficiaries;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.DateUtil;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianVo;
import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class CorporateBeneficiaryVo extends CorporateBeneficiaryBaseVo {

    private String identityCardNumber;
    private IdentityDocumentType identityDocumentType;
    private String identityCardFrontImageKey;
    private String identityCardBackImageKey;
    @JsonSerialize(using = DateToMillisecondsSerializer.class)
    private Date dob;
    private Gender gender;
    private String nationality;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private ResidentialStatus residentialStatus;
    private MaritalStatus maritalStatus;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;

    public static CorporateBeneficiaryVo corporateBeneficiaryToCorporateBeneficiaryViewVo(CorporateBeneficiaries corporateBeneficiaries) {
        CorporateBeneficiaryVo corporateBeneficiaryViewVo = new CorporateBeneficiaryVo();
        if (corporateBeneficiaries != null) {
            corporateBeneficiaryViewVo.setCorporateBeneficiaryId(corporateBeneficiaries.getId());
            corporateBeneficiaryViewVo.setIdentityDocumentType(corporateBeneficiaries.getIdentityDocumentType());
            corporateBeneficiaryViewVo.setIdentityCardFrontImageKey(AwsS3Util.getS3DownloadUrl(corporateBeneficiaries.getIdentityCardFrontImageKey()));
            corporateBeneficiaryViewVo.setIdentityCardBackImageKey(null);
            if (StringUtil.isNotEmpty(corporateBeneficiaries.getIdentityCardBackImageKey())) {
                corporateBeneficiaryViewVo.setIdentityCardBackImageKey(AwsS3Util.getS3DownloadUrl(corporateBeneficiaries.getIdentityCardBackImageKey()));
            }
            corporateBeneficiaryViewVo.setRelationshipToSettlor(corporateBeneficiaries.getRelationshipToSettlor());
            corporateBeneficiaryViewVo.setRelationshipToGuardian(corporateBeneficiaries.getRelationshipToGuardian());
            corporateBeneficiaryViewVo.setFullName(StringUtil.capitalizeEachWord(corporateBeneficiaries.getFullName()));
            corporateBeneficiaryViewVo.setIdentityCardNumber(corporateBeneficiaries.getIdentityCardNumber());
            corporateBeneficiaryViewVo.setDob(corporateBeneficiaries.getDob());
            corporateBeneficiaryViewVo.setGender(corporateBeneficiaries.getGender());
            corporateBeneficiaryViewVo.setNationality(StringUtil.capitalizeEachWord(corporateBeneficiaries.getNationality()));
            corporateBeneficiaryViewVo.setAddress(StringUtil.capitalizeEachWord(corporateBeneficiaries.getAddress()));
            corporateBeneficiaryViewVo.setPostcode(corporateBeneficiaries.getPostcode());
            corporateBeneficiaryViewVo.setCity(StringUtil.capitalizeEachWord(corporateBeneficiaries.getCity()));
            corporateBeneficiaryViewVo.setState(StringUtil.capitalizeEachWord(corporateBeneficiaries.getState()));
            corporateBeneficiaryViewVo.setCountry(StringUtil.capitalizeEachWord(corporateBeneficiaries.getCountry()));
            corporateBeneficiaryViewVo.setResidentialStatus(corporateBeneficiaries.getResidentialStatus());
            corporateBeneficiaryViewVo.setMaritalStatus(corporateBeneficiaries.getMaritalStatus());
            corporateBeneficiaryViewVo.setMobileCountryCode(corporateBeneficiaries.getMobileCountryCode());
            corporateBeneficiaryViewVo.setMobileNumber(corporateBeneficiaries.getMobileNumber());
            corporateBeneficiaryViewVo.setEmail(corporateBeneficiaries.getEmail());
        }
        return corporateBeneficiaryViewVo;
    }

    public static CorporateBeneficiaryBaseVo corporateBeneficiaryToCorporateBeneficiaryBaseVo(CorporateBeneficiaries corporateBeneficiaries) {
        CorporateBeneficiaryBaseVo corporateBeneficiaryBaseVo = new CorporateBeneficiaryBaseVo();

        if (corporateBeneficiaries != null) {
            corporateBeneficiaryBaseVo.setCorporateBeneficiaryId(corporateBeneficiaries.getId());
            corporateBeneficiaryBaseVo.setFullName(StringUtil.capitalizeEachWord(corporateBeneficiaries.getFullName()));
            corporateBeneficiaryBaseVo.setRelationshipToSettlor(corporateBeneficiaries.getRelationshipToSettlor());
            corporateBeneficiaryBaseVo.setRelationshipToGuardian(corporateBeneficiaries.getRelationshipToGuardian());
            Date dob = corporateBeneficiaries.getDob();
            corporateBeneficiaryBaseVo.setIsUnderAge(DateUtil.isUnder18(dob));
            if (corporateBeneficiaries.getCorporateGuardian() != null) {
                corporateBeneficiaryBaseVo.setCorporateGuardianVo(
                        CorporateGuardianVo.getCorporateGuardianDetailsToCorporateGuardianVo(
                                corporateBeneficiaries.getCorporateGuardian()
                        )
                );
            } else {
                corporateBeneficiaryBaseVo.setCorporateGuardianVo(null); // Explicitly set null if no guardian
            }
        }
        return corporateBeneficiaryBaseVo;
    }
}
