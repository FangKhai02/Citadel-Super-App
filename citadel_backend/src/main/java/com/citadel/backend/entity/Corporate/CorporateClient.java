package com.citadel.backend.entity.Corporate;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.UserDetail;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Corporate.CorporateAddressDetailsVo;
import com.citadel.backend.vo.Corporate.CorporateClientVo;
import com.citadel.backend.vo.Corporate.CorporateDetailsVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "corporate_client")
@Getter
@Setter
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class CorporateClient extends BaseEntity {

    public enum CorporateClientStatus {
        IN_REVIEW,
        APPROVED,
        REJECTED,
        DRAFT
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "corporate_client_id")
    private String corporateClientId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_detail_id")
    private UserDetail userDetail;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    private Client client;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id")
    private Agent agent;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "corporate_details_id")
    private CorporateDetails corporateDetails;

    @Column(name = "annual_income_declaration")
    private String annualIncomeDeclaration;

    @Column(name = "source_of_income")
    private String sourceOfIncome;

    @Column(name = "source_of_income_remark")
    private String sourceOfIncomeRemark;

    @Enumerated(EnumType.STRING)
    @Column(name = "approval_status")
    private CorporateClientStatus status;

    @Column(name = "approval_status_remark")
    private String approvalRemark;

    @Column(name = "is_deleted")
    private Boolean isDeleted = Boolean.FALSE;

    @Column(name = "onboarding_agreement_key")
    private String onboardingAgreementKey;

    @Column(name = "profile_picture_image_key")
    private String profilePictureImageKey;

    @Column(name = "reference_number")
    private String referenceNumber;

    @Column(name = "digital_signature_key")
    private String digitalSignatureKey;

    @Column(name = "company_stamp_key")
    private String companyStampKey;

    public CorporateClientVo getCorporateClientVo() {
        CorporateClientVo corporateClientRespVo = new CorporateClientVo();
        corporateClientRespVo.setProfilePicture(AwsS3Util.getS3DownloadUrl(this.profilePictureImageKey));
        corporateClientRespVo.setId(this.getId());
        corporateClientRespVo.setReferenceNumber(this.referenceNumber);
        corporateClientRespVo.setCorporateClientId(this.corporateClientId);
        corporateClientRespVo.setName(this.userDetail.getName());
        corporateClientRespVo.setIdentityCardNumber(this.userDetail.getIdentityCardNumber());
        corporateClientRespVo.setDob(this.userDetail.getDob());
        corporateClientRespVo.setAddress(StringUtil.capitalizeEachWord(this.userDetail.getAddress()));
        corporateClientRespVo.setPostcode(this.userDetail.getPostcode());
        corporateClientRespVo.setCity(StringUtil.capitalizeEachWord(this.userDetail.getCity()));
        corporateClientRespVo.setState(StringUtil.capitalizeEachWord(this.userDetail.getState()));
        corporateClientRespVo.setCountry(StringUtil.capitalizeEachWord(this.userDetail.getCountry()));
        corporateClientRespVo.setMobileCountryCode(this.userDetail.getMobileCountryCode());
        corporateClientRespVo.setMobileNumber(this.userDetail.getMobileNumber());
        corporateClientRespVo.setEmail(this.userDetail.getEmail());
        corporateClientRespVo.setAnnualIncomeDeclaration(this.annualIncomeDeclaration);
        corporateClientRespVo.setSourceOfIncome(this.sourceOfIncome);
        corporateClientRespVo.setStatus(this.status);
        corporateClientRespVo.setApprovalRemark(this.approvalRemark);
        corporateClientRespVo.setDigitalSignature(AwsS3Util.getS3DownloadUrl(this.digitalSignatureKey));
        return corporateClientRespVo;
    }

    public CorporateDetailsVo getCorporateDetailsVo() {
        CorporateDetailsVo details = new CorporateDetailsVo();
        details.setEntityName(this.corporateDetails.getEntityName());
        details.setEntityType(this.corporateDetails.getEntityType());
        details.setRegistrationNumber(this.corporateDetails.getRegistrationNumber());
        details.setDateIncorporate(this.corporateDetails.getDateIncorporation());
        details.setPlaceIncorporate(this.corporateDetails.getPlaceIncorporation());
        details.setBusinessType(this.corporateDetails.getBusinessType());
        details.setRegisteredAddress(StringUtil.capitalizeEachWord(this.corporateDetails.getRegisteredAddress()));
        details.setPostcode(this.corporateDetails.getPostcode());
        details.setCity(StringUtil.capitalizeEachWord(this.corporateDetails.getCity()));
        details.setState(StringUtil.capitalizeEachWord(this.corporateDetails.getState()));
        details.setCountry(StringUtil.capitalizeEachWord(this.corporateDetails.getCountry()));

        CorporateAddressDetailsVo corporateAddressDetails = new CorporateAddressDetailsVo();
        corporateAddressDetails.setIsDifferentRegisteredAddress(this.corporateDetails.getIsDifferentBusinessAddress());
        corporateAddressDetails.setBusinessAddress(StringUtil.capitalizeEachWord(this.corporateDetails.getBusinessAddress()));
        corporateAddressDetails.setBusinessCity(StringUtil.capitalizeEachWord(this.corporateDetails.getBusinessCity()));
        corporateAddressDetails.setBusinessPostcode(this.corporateDetails.getBusinessPostcode());
        corporateAddressDetails.setBusinessState(StringUtil.capitalizeEachWord(this.corporateDetails.getBusinessState()));
        corporateAddressDetails.setBusinessCountry(StringUtil.capitalizeEachWord(this.corporateDetails.getBusinessCountry()));

        details.setCorporateAddressDetails(corporateAddressDetails);
        details.setContactIsMyself(this.corporateDetails.getContactIsMyself());
        details.setContactName(this.corporateDetails.getContactName());
        details.setContactDesignation(this.corporateDetails.getContactDesignation());
        details.setContactCountryCode(this.corporateDetails.getContactMobileCountryCode());
        details.setContactMobileNumber(this.corporateDetails.getContactMobileNumber());
        details.setContactEmail(this.corporateDetails.getContactEmail());
        return details;
    }

    public Boolean canUpdate() {
        return !CorporateClientStatus.APPROVED.equals(this.getStatus()) &&
                !CorporateClientStatus.IN_REVIEW.equals(this.getStatus());
    }
}
