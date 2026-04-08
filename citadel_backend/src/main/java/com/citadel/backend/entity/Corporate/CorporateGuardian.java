package com.citadel.backend.entity.Corporate;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
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
@Table(name = "corporate_guardian")

public class CorporateGuardian {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id")
    private CorporateClient corporateClient;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "identity_card_number")
    private String identityCardNumber;

    @Column(name = "dob")
    private Date dob;

    @Enumerated(EnumType.STRING)
    @Column(name = "gender")
    private Gender gender;

    @Column(name = "nationality")
    private String nationality;

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

    @Enumerated(EnumType.STRING)
    @Column(name = "residential_status")
    private ResidentialStatus residentialStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "marital_status")
    private MaritalStatus maritalStatus;

    @Column(name = "mobile_country_code")
    private String mobileCountryCode;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(name = "email")
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(name = "identity_doc_type")
    private IdentityDocumentType identityDocumentType;

    @Column(name = "identity_card_front_image_key")
    private String identityCardFrontImageKey;

    @Column(name = "identity_card_back_image_key")
    private String identityCardBackImageKey;

    @Column(name = "address_proof_key")
    private String addressProofKey;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "updated_at")
    private Date updatedAt;

}