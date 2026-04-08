package com.citadel.backend.entity;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Enum.NiuApplicationType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "niu_application")
public class NiuApplication {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "app_user_id")
    private AppUser appUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id")
    private CorporateClient corporateClient;

    @Column(name = "amount_requested_in_rm")
    private Integer amountRequested;

    @Column(name = "tenure")
    private String tenure;

    @Enumerated(EnumType.STRING)
    @Column(name = "application_type")
    private NiuApplicationType applicationType;

    @Column(name = "name")
    private String name;

    @Column(name = "document_number")
    private String documentNumber;

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

    @Column(name = "mobile_country_code")
    private String mobileCountryCode;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(name = "email")
    private String email;

    @Column(name = "nature_of_business")
    private String natureOfBusiness;

    @Column(name = "purpose_of_advances")
    private String purposeOfAdvances;

    @Column(name = "first_signee_name")
    private String firstSigneeName;

    @Column(name = "first_signee_nric")
    private String firstSigneeNric;

    @Column(name = "first_signee_signed_date")
    private Date firstSigneeSignedDate;

    @Column(name = "first_signee_signature")
    private String firstSigneeSignature;

    @Column(name = "second_signee_name")
    private String secondSigneeName;

    @Column(name = "second_signee_nric")
    private String secondSigneeNric;

    @Column(name = "second_signee_signed_date")
    private Date secondSigneeSignedDate;

    @Column(name = "second_signee_signature")
    private String secondSigneeSignature;

    @Column(name = "created_at")
    private Date createdAt;

    @JsonIgnore
    @Column(name = "updated_at")
    private Date updatedAt;

    @OneToMany(mappedBy = "niuApplication")
    private List<NiuApplicationDocument> documents;

    @Transient
    public String getFullAddress() {
        return StringUtil.capitalizeEachWord((getAddress() == null ? "" : getAddress()) +
                (getPostcode() == null ? "" : ", " + getPostcode()) +
                (getCity() == null ? "" : ", " + getCity()) +
                (getState() == null ? "" : ", " + getState()) +
                (getCountry() == null ? "" : ", " + getCountry()));
    }

    @Transient
    public String getFullMobileNumber() {
        return (getMobileCountryCode() == null ? "" : getMobileCountryCode()) +
                (getMobileNumber() == null ? "" : getMobileNumber());
    }
}
