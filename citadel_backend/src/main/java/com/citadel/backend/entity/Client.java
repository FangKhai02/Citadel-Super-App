package com.citadel.backend.entity;

import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.vo.Client.ClientAgentDetailsVo;
import com.citadel.backend.vo.Client.ClientEmploymentDetailsVo;
import com.citadel.backend.vo.Client.ClientWealthSourceDetailsVo;
import com.citadel.backend.vo.Enum.EmploymentType;
import com.citadel.backend.vo.SignUp.PepDeclarationOptionsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "client")
public class Client extends BaseEntity {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "client_id")
    private String clientId;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "app_user_id")
    private AppUser appUser;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_detail_id")
    private UserDetail userDetail;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id")
    private Agent agent;

    @Column(name = "pin")
    private String pin;

    @Enumerated(EnumType.STRING)
    @Column(name = "employment_type")
    private EmploymentType employmentType;

    @Column(name = "employer_name")
    private String employerName;

    @Column(name = "industry_type")
    private String industryType;

    @Column(name = "job_title")
    private String jobTitle;

    @Column(name = "employer_address")
    private String employerAddress;

    @Column(name = "employer_postcode")
    private String employerPostcode;

    @Column(name = "employer_city")
    private String employerCity;

    @Column(name = "employer_state")
    private String employerState;

    @Column(name = "employer_country")
    private String employerCountry;

    @Column(name = "annual_income_declaration")
    private String annualIncomeDeclaration;

    @Column(name = "source_of_income")
    private String sourceOfIncome;

    @Column(name = "source_of_income_remark")
    private String sourceOfIncomeRemark;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "pep_info_id")
    private PepInfo pepInfo;

    @Column(name = "status")
    private Boolean status;

    public ClientEmploymentDetailsVo getClientEmploymentDetails() {
        ClientEmploymentDetailsVo details = new ClientEmploymentDetailsVo();
        details.setEmploymentType(this.employmentType);
        details.setEmployerName(this.employerName);
        details.setIndustryType(this.industryType);
        details.setJobTitle(this.jobTitle);
        details.setEmployerAddress(this.employerAddress);
        details.setEmployerPostcode(this.employerPostcode);
        details.setEmployerCity(this.employerCity);
        details.setEmployerState(this.employerState);
        details.setEmployerCountry(this.employerCountry);
        return details;
    }

    public ClientWealthSourceDetailsVo getClientWealthSourceDetails() {
        ClientWealthSourceDetailsVo details = new ClientWealthSourceDetailsVo();
        details.setAnnualIncomeDeclaration(this.annualIncomeDeclaration);
        details.setSourceOfIncome(this.sourceOfIncome);
        return details;
    }

    public ClientAgentDetailsVo getClientAgentDetails() {
        ClientAgentDetailsVo details = new ClientAgentDetailsVo();
        if (this.agent != null) {
            details.setAgentName(this.agent.getUserDetail().getName());
            details.setAgentReferralCode(this.agent.getReferralCode());
            details.setAgentId(this.agent.getAgentId());
            details.setAgencyName(this.agent.getAgency().getAgencyName());
            details.setAgencyId(this.agent.getAgency().getAgencyId());
            details.setAgentCountryCode(this.agent.getUserDetail().getMobileCountryCode());
            details.setAgentMobileNumber(this.agent.getUserDetail().getMobileNumber());
        }
        return details;
    }

    public PepDeclarationVo getClientPepInfo() {
        PepDeclarationVo pepDeclaration = new PepDeclarationVo();
        PepInfo pepInfo = this.pepInfo;
        if (pepInfo != null) {
            pepDeclaration.setIsPep(pepInfo.getPep());
            PepDeclarationOptionsVo pepDeclarationOptions = new PepDeclarationOptionsVo();
            pepDeclarationOptions.setRelationship(pepInfo.getPepType());
            pepDeclarationOptions.setName(pepInfo.getPepImmediateFamilyName());
            pepDeclarationOptions.setPosition(pepInfo.getPepPosition());
            pepDeclarationOptions.setOrganization(pepInfo.getPepOrganisation());
            pepDeclarationOptions.setSupportingDocument(AwsS3Util.getS3DownloadUrl(pepInfo.getPepSupportingDocumentsKey()));
            pepDeclaration.setPepDeclarationOptions(pepDeclarationOptions);
        }
        return pepDeclaration;
    }
}