package com.citadel.backend.vo.Corporate.Guardian;

import com.citadel.backend.entity.Corporate.CorporateGuardian;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.StringUtil;
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
public class CorporateGuardianVo extends CorporateGuardianBaseVo {

    private String identityCardNumber;
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
    private IdentityDocumentType identityDocumentType;
    private String identityCardFrontImage;
    private String identityCardBackImage;

    public static CorporateGuardianVo getCorporateGuardianDetailsToCorporateGuardianVo(CorporateGuardian corporateGuardian) {
        CorporateGuardianVo details = new CorporateGuardianVo();
        if (corporateGuardian != null) {
            details.setCorporateGuardianId(corporateGuardian.getId());
            details.setFullName(StringUtil.capitalizeEachWord(corporateGuardian.getFullName()));
            details.setIdentityCardNumber(corporateGuardian.getIdentityCardNumber());
            details.setDob(corporateGuardian.getDob());
            details.setGender(corporateGuardian.getGender());
            details.setNationality(StringUtil.capitalizeEachWord(corporateGuardian.getNationality()));
            details.setAddress(StringUtil.capitalizeEachWord(corporateGuardian.getAddress()));
            details.setPostcode(corporateGuardian.getPostcode());
            details.setCity(StringUtil.capitalizeEachWord(corporateGuardian.getCity()));
            details.setState(StringUtil.capitalizeEachWord(corporateGuardian.getState()));
            details.setCountry(StringUtil.capitalizeEachWord(corporateGuardian.getCountry()));
            details.setResidentialStatus(corporateGuardian.getResidentialStatus());
            details.setMaritalStatus(corporateGuardian.getMaritalStatus());
            details.setMobileCountryCode(corporateGuardian.getMobileCountryCode());
            details.setMobileNumber(corporateGuardian.getMobileNumber());
            details.setEmail(corporateGuardian.getEmail());
            details.setIdentityDocumentType(corporateGuardian.getIdentityDocumentType());
            details.setIdentityCardFrontImage(AwsS3Util.getS3DownloadUrl(corporateGuardian.getIdentityCardFrontImageKey()));
            details.setIdentityCardBackImage(null);
            if (StringUtil.isNotEmpty(corporateGuardian.getIdentityCardBackImageKey())) {
                details.setIdentityCardBackImage(AwsS3Util.getS3DownloadUrl(corporateGuardian.getIdentityCardBackImageKey()));
            }
        }
        return details;
    }
}
