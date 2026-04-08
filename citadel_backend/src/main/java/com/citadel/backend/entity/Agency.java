package com.citadel.backend.entity;

import com.citadel.backend.vo.Agency.AgencyVo;
import com.citadel.backend.vo.Enum.AgencyType;
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
@Table(name = "agency")
public class Agency {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "agency_code")
    private String agencyCode;

    @Column(name = "agency_id")
    private String agencyId;

    @Column(name = "agency_name")
    private String agencyName;

    @Column(name = "agency_reg_number")
    private String agencyRegNumber;

    @Column(name = "contact_number")
    private String contactNumber;

    @Column(name = "email_address")
    private String emailAddress;

    @Column(name = "office_address")
    private String officeAddress;

    @Column(name = "status")
    private Boolean status;

    @Enumerated(EnumType.STRING)
    @Column(name = "agency_type")
    private AgencyType agencyType;

    @JsonIgnore
    @Column(name = "created_at")
    private Date createdAt;

    @JsonIgnore
    @Column(name = "updated_at")
    private Date updatedAt;

    public AgencyVo agencyToAgencyVo(Agency agency) {
        AgencyVo agencyVo = new AgencyVo();
        agencyVo.setAgencyCode(agency.getAgencyCode());
        agencyVo.setAgencyId(agency.getAgencyId());
        agencyVo.setAgencyName(agency.getAgencyName());
        return agencyVo;
    }

    @Transient
    public List<Agent> agentList;
}
