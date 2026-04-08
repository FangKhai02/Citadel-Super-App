package com.citadel.backend.entity.Corporate;

import com.citadel.backend.entity.BaseEntity;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.vo.Enum.CorporateTypeOfEntity;
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
@Table(name = "corporate_details")
public class CorporateDetails extends BaseEntity {

    public enum CorporateDetailsStatus {
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

    @Column(name = "entity_name")
    private String entityName;

    @Enumerated(EnumType.STRING)
    @Column(name = "entity_type")
    private CorporateTypeOfEntity entityType;

    @Column(name = "registration_number")
    private String registrationNumber;

    @Column(name = "date_incorporation")
    private Date dateIncorporation;

    @Column(name = "place_incorporation")
    private String placeIncorporation;

    @Column(name = "business_type")
    private String businessType;

    @Column(name = "registered_address")
    private String registeredAddress;

    @Column(name = "postcode")
    private String postcode;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "country")
    private String country;

    @Column(name = "is_different_business_address")
    private Boolean isDifferentBusinessAddress;

    @Column(name = "business_address")
    private String businessAddress;

    @Column(name = "business_postcode")
    private String businessPostcode;

    @Column(name = "business_city")
    private String businessCity;

    @Column(name = "business_state")
    private String businessState;

    @Column(name = "business_country")
    private String businessCountry;

    @Column(name = "contact_name")
    private String contactName;

    @Column(name = "contact_is_myself")
    private Boolean contactIsMyself;

    @Column(name = "contact_designation")
    private String contactDesignation;

    @Column(name = "contact_mobile_country_code")
    private String contactMobileCountryCode;

    @Column(name = "contact_mobile_number")
    private String contactMobileNumber;

    @Column(name = "contact_email")
    private String contactEmail;

    @Column(name = "is_deleted")
    private Boolean isDeleted = Boolean.FALSE;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private CorporateDetailsStatus status;

    @Transient
    public String getFullAddress() {
        return StringUtil.capitalizeEachWord((getBusinessAddress() == null ? "" : getBusinessAddress()) +
                (getBusinessPostcode() == null ? "" : ", " + getBusinessPostcode()) +
                (getBusinessCity() == null ? "" : ", " + getBusinessCity()) +
                (getBusinessState() == null ? "" : ", " + getBusinessState()) +
                (getBusinessCountry() == null ? "" : ", " + getBusinessCountry()));
    }
    public String getPhoneNumber(){
        return (getContactMobileCountryCode() == null ? "" : getContactMobileCountryCode()) +
                (getContactMobileNumber() == null ? "" : getContactMobileNumber());
    }
}
