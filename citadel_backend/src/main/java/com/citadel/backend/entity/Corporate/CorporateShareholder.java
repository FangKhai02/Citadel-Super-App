package com.citadel.backend.entity.Corporate;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.entity.PepInfo;
import com.citadel.backend.vo.Enum.IdentityDocumentType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "corporate_shareholders")
public class CorporateShareholder extends BaseEntity {

    public enum CorporateShareholderStatus {
        DRAFT,
        COMPLETED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id")
    private CorporateClient corporateClient;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "pep_info")
    private PepInfo pepInfo;

    @Column(name = "name")
    private String name;

    @Column(name = "identity_card_number")
    private String identityCardNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "identity_doc_type")
    private IdentityDocumentType identityDocumentType;

    @Column(name = "percentage_of_shareholdings")
    private Double percentageOfShareholdings;

    @Column(name = "mobile_country_code")
    private String mobileCountryCode;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(name = "email")
    private String email;

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

    @Column(name = "identity_card_front_image_key")
    private String identityCardFrontImageKey;

    @Column(name = "identity_card_back_image_key")
    private String identityCardBackImageKey;

    @Column(name = "address_proof_key")
    private String addressProofKey;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private CorporateShareholderStatus status;

    @Column(name = "is_deleted")
    private Boolean isDeleted = Boolean.FALSE;
}