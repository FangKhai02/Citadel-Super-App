package com.citadel.backend.entity;

import com.citadel.backend.vo.Enum.ContactUsReason;
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
@Table(name = "contact_us_form_submission")
public class ContactUsFormSubmission {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "mobile_country_code")
    private String mobileCountryCode;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(name = "email")
    private String email;

    @Enumerated(EnumType.STRING)
    @Column(name = "reason")
    private ContactUsReason reason;

    @Column(name = "remark")
    private String remark;

    @Column(name = "created_at")
    private Date createdAt;

}
