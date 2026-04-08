package com.citadel.backend.vo.Client.Beneficiary;

import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.DateToMillisecondsSerializer;
import com.citadel.backend.utils.DateUtil;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Client.Guardian.GuardianVo;
import com.citadel.backend.vo.Enum.*;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class IndividualBeneficiaryVo {
    private Long individualBeneficiaryId;
    private IdentityDocumentType identityDocumentType;
    private String identityCardFrontImageKey;
    private String identityCardBackImageKey;
    private Relationship relationshipToSettlor;
    private Relationship relationshipToGuardian;
    private String fullName;
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
    private Boolean isUnderAge;
    private GuardianVo guardian;

    public static IndividualBeneficiaryVo individualBeneficiaryToBeneficiaryViewVo(IndividualBeneficiary individualBeneficiary) {
        IndividualBeneficiaryVo beneficiaryViewVo = new IndividualBeneficiaryVo();
        if (individualBeneficiary != null) {
            beneficiaryViewVo.setIndividualBeneficiaryId(individualBeneficiary.getId());
            beneficiaryViewVo.setIdentityDocumentType(individualBeneficiary.getIdentityDocumentType());
            beneficiaryViewVo.setIdentityCardFrontImageKey(AwsS3Util.getS3DownloadUrl(individualBeneficiary.getIdentityCardFrontImageKey()));
            beneficiaryViewVo.setIdentityCardBackImageKey(null);
            if (StringUtil.isNotEmpty(individualBeneficiary.getIdentityCardBackImageKey())) {
                beneficiaryViewVo.setIdentityCardBackImageKey(AwsS3Util.getS3DownloadUrl(individualBeneficiary.getIdentityCardBackImageKey()));
            }
            beneficiaryViewVo.setRelationshipToSettlor(individualBeneficiary.getRelationshipToSettlor());
            beneficiaryViewVo.setFullName(StringUtil.capitalizeEachWord(individualBeneficiary.getFullName()));
            beneficiaryViewVo.setIdentityCardNumber(individualBeneficiary.getIdentityCardNumber());
            beneficiaryViewVo.setDob(individualBeneficiary.getDob());
            beneficiaryViewVo.setGender(individualBeneficiary.getGender());
            beneficiaryViewVo.setNationality(StringUtil.capitalizeEachWord(individualBeneficiary.getNationality()));
            beneficiaryViewVo.setAddress(StringUtil.capitalizeEachWord(individualBeneficiary.getAddress()));
            beneficiaryViewVo.setPostcode(individualBeneficiary.getPostcode());
            beneficiaryViewVo.setCity(StringUtil.capitalizeEachWord(individualBeneficiary.getCity()));
            beneficiaryViewVo.setState(StringUtil.capitalizeEachWord(individualBeneficiary.getState()));
            beneficiaryViewVo.setCountry(StringUtil.capitalizeEachWord(individualBeneficiary.getCountry()));
            beneficiaryViewVo.setResidentialStatus(individualBeneficiary.getResidentialStatus());
            beneficiaryViewVo.setMaritalStatus(individualBeneficiary.getMaritalStatus());
            beneficiaryViewVo.setMobileCountryCode(individualBeneficiary.getMobileCountryCode());
            beneficiaryViewVo.setMobileNumber(individualBeneficiary.getMobileNumber());
            beneficiaryViewVo.setEmail(individualBeneficiary.getEmail());
            beneficiaryViewVo.setIsUnderAge(DateUtil.isUnder18(individualBeneficiary.getDob()));
        }
        return beneficiaryViewVo;
    }

}
