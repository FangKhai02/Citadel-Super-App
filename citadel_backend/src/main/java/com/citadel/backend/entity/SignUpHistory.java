package com.citadel.backend.entity;

import com.citadel.backend.vo.Enum.*;
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
@Table(name = "sign_up_history")
public class SignUpHistory {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(name = "user_type")
    private UserType userType;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "identity_card_number", nullable = false)
    private String identityCardNumber;

    @Column(name = "dob", nullable = false)
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
    @Column(name = "residential_status")
    private ResidentialStatus residentialStatus;

    @Column(name = "referral_code_agent")
    private String referralCodeAgent;

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

    @Column(name = "pep")
    private Boolean pep;

    @Enumerated(EnumType.STRING)
    @Column(name = "pep_type")
    private Relationship pepType;

    @Column(name = "pep_immediate_family_name")
    private String pepImmediateFamilyName;

    @Column(name = "pep_position")
    private String pepPosition;

    @Column(name = "pep_organisation")
    private String pepOrganisation;

    @Column(name = "pep_supporting_documents_key")
    private String pepSupportingDocumentsKey;

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

    @Column(name = "agency_id")
    private String agencyId;

    @Column(name = "recruit_manager_code")
    private String recruitManagerCode;

    @Column(name = "bank_name")
    private String bankName;

    @Column(name = "bank_address")
    private String bankAddress;

    @Column(name = "bank_postcode")
    private String bankPostcode;

    @Column(name = "bank_city")
    private String bankCity;

    @Column(name = "bank_state")
    private String bankState;

    @Column(name = "bank_country")
    private String bankCountry;

    @Column(name = "swift_code")
    private String swiftCode;

    @Column(name = "account_holder_name")
    private String accountHolderName;

    @Column(name = "account_number")
    private String accountNumber;

    @Column(name = "proof_of_bank_account_key")
    private String proofOfBankAccountKey;

    @Column(name = "proof_of_address_file_key")
    private String proofOfAddressFileKey;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

    @Transient
    private String password;

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
}
