package com.citadel.backend.entity;

import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Agent.AgentPersonalDetailsVo;
import com.citadel.backend.vo.Client.ClientPersonalDetailsVo;
import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.SignUp.CorrespondingAddress;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "user_details")
public class UserDetail extends BaseEntity {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "app_user_id")
    private AppUser appUserId;

    @Column(name = "name")
    private String name;

    @Column(name = "identity_card_number")
    private String identityCardNumber;

    @Column(name = "dob")
    private Date dob;

    @Column(name = "address")
    private String address;

    @Column(name = "postcode")
    private String postcode;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "country")
    private String country;

    @Column(name = "nationality")
    private String nationality;

    @Column(name = "country_code")
    private String countryCode;

    @Column(name = "mobile_country_code")
    private String mobileCountryCode;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender;

    @Column(name = "email")
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(name = "marital_status")
    private MaritalStatus maritalStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "resident_status")
    private ResidentialStatus residentialStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "identity_doc_type")
    private IdentityDocumentType identityDocumentType;

    @Column(name = "identity_card_front_image_key")
    private String identityCardFrontImageKey;

    @Column(name = "identity_card_back_image_key")
    private String identityCardBackImageKey;

    @Column(name = "selfie_image_key")
    private String selfieImageKey;

    @Column(name = "digital_signature_key")
    private String digitalSignatureKey;

    @Column(name = "proof_of_address_file_key")
    private String proofOfAddressFileKey;

    @Column(name = "onboarding_agreement_key")
    private String onboardingAgreementKey;

    @Column(name = "profile_picture_image_key")
    private String profilePictureImageKey;

    //TODO remove this field after migration
    @Column(name = "full_name_of_immediate_family")
    private String fullNameOfImmediateFamily;

    @Column(name = "is_same_corresponding_address")
    private Boolean isSameCorrespondingAddress;

    @Column(name = "corresponding_address")
    private String correspondingAddress;

    @Column(name = "corresponding_postcode")
    private String correspondingPostcode;

    @Column(name = "corresponding_city")
    private String correspondingCity;

    @Column(name = "corresponding_state")
    private String correspondingState;

    @Column(name = "corresponding_country")
    private String correspondingCountry;

    @Column(name = "corresponding_address_proof_key")
    private String correspondingAddressProofKey;

    public void setMobileCountryCode(String mobileCountryCode) {
        mobileCountryCode = mobileCountryCode.strip();
        if (StringUtil.isNotEmpty(mobileCountryCode) && !mobileCountryCode.startsWith("+")) {
            this.mobileCountryCode = "+" + mobileCountryCode;
        } else {
            this.mobileCountryCode = mobileCountryCode;
        }
    }

    public String getProofOfAddressFileKey() {
        if (StringUtil.isEmpty(this.proofOfAddressFileKey)) {
            return null;
        } else {
            return AwsS3Util.getS3DownloadUrl(this.proofOfAddressFileKey);
        }
    }

    public String getCorrespondingAddressProofKey() {
        if (StringUtil.isEmpty(this.correspondingAddressProofKey)) {
            return null;
        } else {
            return AwsS3Util.getS3DownloadUrl(this.correspondingAddressProofKey);
        }
    }

    public static UserDetail createOrUpdateNewUserDetailFromSignUpHistory(SignUpHistory signUpHistory, UserDetail userDetail) {
        if (userDetail == null) {
            userDetail = new UserDetail();
            userDetail.setCreatedAt(new Date());
        }
        userDetail.setName(signUpHistory.getFullName());
        userDetail.setIdentityCardNumber(signUpHistory.getIdentityCardNumber());
        userDetail.setDob(signUpHistory.getDob());
        userDetail.setAddress(StringUtil.capitalizeEachWord(signUpHistory.getAddress()));
        userDetail.setPostcode(signUpHistory.getPostcode());
        userDetail.setCity(StringUtil.capitalizeEachWord(signUpHistory.getCity()));
        userDetail.setState(StringUtil.capitalizeEachWord(signUpHistory.getState()));
        userDetail.setCountry(StringUtil.capitalizeEachWord(signUpHistory.getCountry()));
        userDetail.setCountryCode(StringUtil.getCountryCodeFromCountryName(signUpHistory.getCountry()));
        userDetail.setNationality(signUpHistory.getNationality());
        userDetail.setMobileCountryCode(signUpHistory.getMobileCountryCode());
        userDetail.setMobileNumber(signUpHistory.getMobileNumber());
        userDetail.setGender(signUpHistory.getGender());
        userDetail.setEmail(signUpHistory.getEmail());
        userDetail.setMaritalStatus(signUpHistory.getMaritalStatus());
        userDetail.setResidentialStatus(signUpHistory.getResidentialStatus());
        userDetail.setIdentityDocumentType(signUpHistory.getIdentityDocumentType());
        userDetail.setIdentityCardFrontImageKey(signUpHistory.getIdentityCardFrontImageKey());
        if (StringUtil.isNotEmpty(signUpHistory.getIdentityCardBackImageKey())) {
            userDetail.setIdentityCardBackImageKey(signUpHistory.getIdentityCardBackImageKey());
        }
        userDetail.setSelfieImageKey(signUpHistory.getSelfieImageKey());
        userDetail.setDigitalSignatureKey(signUpHistory.getDigitalSignatureKey());
        userDetail.setProofOfAddressFileKey(signUpHistory.getProofOfAddressFileKey());
        // Corresponding address
        userDetail.setIsSameCorrespondingAddress(signUpHistory.getIsSameCorrespondingAddress());
        userDetail.setCorrespondingAddress(StringUtil.capitalizeEachWord(signUpHistory.getCorrespondingAddress()));
        userDetail.setCorrespondingPostcode(signUpHistory.getCorrespondingPostcode());
        userDetail.setCorrespondingCity(StringUtil.capitalizeEachWord(signUpHistory.getCorrespondingCity()));
        userDetail.setCorrespondingState(StringUtil.capitalizeEachWord(signUpHistory.getCorrespondingState()));
        userDetail.setCorrespondingCountry(StringUtil.capitalizeEachWord(signUpHistory.getCorrespondingCountry()));
        userDetail.setCorrespondingAddressProofKey(signUpHistory.getCorrespondingAddressProofKey());

        userDetail.setUpdatedAt(new Date());
        return userDetail;
    }

    public ClientPersonalDetailsVo getClientPersonalDetails() {
        ClientPersonalDetailsVo details = new ClientPersonalDetailsVo();
        details.setName(this.name);
        details.setIdentityDocumentType(this.identityDocumentType);
        details.setIdentityCardNumber(this.identityCardNumber);
        details.setDob(this.dob);
        details.setAddress(StringUtil.capitalizeEachWord(this.address));
        details.setPostcode(this.postcode);
        details.setCity(StringUtil.capitalizeEachWord(this.city));
        details.setState(StringUtil.capitalizeEachWord(this.state));
        details.setCountry(StringUtil.capitalizeEachWord(this.country));

        // Get Client corresponding address
        CorrespondingAddress correspondingAddress = new CorrespondingAddress();
        correspondingAddress.setIsSameCorrespondingAddress(this.isSameCorrespondingAddress);
        correspondingAddress.setCorrespondingAddress(StringUtil.capitalizeEachWord(this.correspondingAddress));
        correspondingAddress.setCorrespondingPostcode(this.correspondingPostcode);
        correspondingAddress.setCorrespondingCity(StringUtil.capitalizeEachWord(this.correspondingCity));
        correspondingAddress.setCorrespondingState(StringUtil.capitalizeEachWord(this.correspondingState));
        correspondingAddress.setCorrespondingCountry(StringUtil.capitalizeEachWord(this.correspondingCountry));
        correspondingAddress.setCorrespondingAddressProofKey(this.getCorrespondingAddressProofKey());

        details.setCorrespondingAddress(correspondingAddress);

        details.setNationality(this.nationality);
        details.setMobileCountryCode(this.mobileCountryCode);
        details.setMobileNumber(this.mobileNumber);
        details.setGender(this.gender);
        details.setEmail(this.email);
        details.setMaritalStatus(this.maritalStatus);
        details.setResidentialStatus(this.residentialStatus);
        details.setProfilePicture(AwsS3Util.getS3DownloadUrl(this.profilePictureImageKey));
        return details;
    }

    public AgentPersonalDetailsVo getAgentPersonalDetails() {
        AgentPersonalDetailsVo details = new AgentPersonalDetailsVo();
        details.setName(this.name);
        details.setIdentityDocumentType(this.identityDocumentType);
        details.setIdentityCardNumber(this.identityCardNumber);
        details.setDob(this.dob);
        details.setAddress(StringUtil.capitalizeEachWord(this.address));
        details.setPostcode(this.postcode);
        details.setCity(StringUtil.capitalizeEachWord(this.city));
        details.setState(StringUtil.capitalizeEachWord(this.state));
        details.setCountry(StringUtil.capitalizeEachWord(this.country));
        details.setMobileCountryCode(this.mobileCountryCode);
        details.setMobileNumber(this.mobileNumber);
        details.setEmail(this.email);
        details.setProfilePicture(AwsS3Util.getS3DownloadUrl(this.profilePictureImageKey));
        return details;
    }

    @Transient
    public String getFullAddress() {
        return StringUtil.capitalizeEachWord((StringUtil.isEmpty(getAddress()) ? "" : getAddress()) +
                (StringUtil.isEmpty(getPostcode()) ? "" : ", " + getPostcode()) +
                (StringUtil.isEmpty(getCity()) ? "" : ", " + getCity()) +
                (StringUtil.isEmpty(getState()) ? "" : ", " + getState()) +
                (StringUtil.isEmpty(getCountry()) ? "" : ", " + getCountry()));
    }

    @Transient
    public String getFullMobileNumber() {
        return StringUtil.formatMalaysianMobileNumber(getMobileCountryCode(), getMobileNumber());
    }
}