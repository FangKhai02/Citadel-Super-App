package com.citadel.backend.entity;

import com.citadel.backend.vo.Agency.AgencyAgentVo;
import com.citadel.backend.vo.Agent.AgentVo;
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
@Table(name = "agent")
public class Agent extends BaseEntity {

    public enum AgentStatus {
        ACTIVE,
        TERMINATED,
        SUSPENDED
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "agent_id")
    private String agentId;

    @Column(name = "pin")
    private String pin;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "app_user_id")
    private AppUser appUser;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_detail_id")
    private UserDetail userDetail;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "agency_id")
    private Agency agency;

    @Column(name = "referral_code")
    private String referralCode;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "recruit_manager_id")
    private Agent recruitManager;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private AgentStatus status;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "agent_role_id")
    private AgentRoleSettings agentRole;

    @JsonIgnore
    @Column(name = "agency_agreement_date")
    private Date agencyAgreementDate;

    @JsonIgnore
    @Column(name = "agency_agreement_key")
    private String agencyAgreementKey;

    public AgencyAgentVo agentToAgentVo(Agent agent) {
        AgencyAgentVo agentVo = new AgencyAgentVo();
        agentVo.setAgentId(agent.getAgentId());
        agentVo.setAgentName(agent.getUserDetail().getName());
        return agentVo;
    }

    public AgentVo getAgentDetails() {
        AgentVo agentVo = new AgentVo();
        agentVo.setAgentId(this.agentId);
        agentVo.setAgentName(this.userDetail.getName());
        agentVo.setReferralCode(this.referralCode);
        agentVo.setAgentRole(this.agentRole.getRoleCode());
        agentVo.setAgentType(this.agency.getAgencyType());
        agentVo.setAgencyId(this.agency.getAgencyId());
        agentVo.setAgencyName(this.agency.getAgencyName());
        agentVo.setJoinedDate(this.createdAt);
        if (this.recruitManager != null) {
            agentVo.setRecruitManagerId(this.recruitManager.getAgentId());
            agentVo.setRecruitManagerName(this.recruitManager.getUserDetail().getName());
        }
        return agentVo;
    }
}
