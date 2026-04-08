package com.citadel.backend.vo.Client.Guardian;

import com.citadel.backend.entity.IndividualGuardian;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Enum.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class GuardianVo {
    private Long id;
    private String fullName;
    private String icPassport;
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
    private String identityCardFrontImageKey;
    private String identityCardBackImageKey;
    private String addressProofKey;
    private Relationship relationshipToBeneficiary;

    public static GuardianVo individualGuardianToGuardianVo(IndividualGuardian individualGuardian) {
        GuardianVo guardianVo = new GuardianVo();
        if (individualGuardian != null) {
            guardianVo.setId(individualGuardian.getId());
            guardianVo.setFullName(StringUtil.capitalizeEachWord(individualGuardian.getFullName()));
            guardianVo.setIcPassport(individualGuardian.getIdentityCardNumber());
            guardianVo.setDob(individualGuardian.getDob());
            guardianVo.setGender(individualGuardian.getGender());
            guardianVo.setNationality(StringUtil.capitalizeEachWord(individualGuardian.getNationality()));
            guardianVo.setAddress(StringUtil.capitalizeEachWord(individualGuardian.getAddress()));
            guardianVo.setPostcode(individualGuardian.getPostcode());
            guardianVo.setCity(StringUtil.capitalizeEachWord(individualGuardian.getCity()));
            guardianVo.setState(StringUtil.capitalizeEachWord(individualGuardian.getState()));
            guardianVo.setCountry(StringUtil.capitalizeEachWord(individualGuardian.getCountry()));
            guardianVo.setResidentialStatus(individualGuardian.getResidentialStatus());
            guardianVo.setMaritalStatus(individualGuardian.getMaritalStatus());
            guardianVo.setMobileCountryCode(individualGuardian.getMobileCountryCode());
            guardianVo.setMobileNumber(individualGuardian.getMobileNumber());
            guardianVo.setEmail(individualGuardian.getEmail());
            guardianVo.setIdentityDocumentType(individualGuardian.getIdentityDocumentType());
            guardianVo.setIdentityCardFrontImageKey(individualGuardian.getIdentityCardFrontImageKey());
            guardianVo.setIdentityCardBackImageKey(individualGuardian.getIdentityCardBackImageKey());
            guardianVo.setAddressProofKey(individualGuardian.getAddressProofKey());
        }
        return guardianVo;
    }
}
