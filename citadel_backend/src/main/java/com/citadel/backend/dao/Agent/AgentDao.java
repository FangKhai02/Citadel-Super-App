package com.citadel.backend.dao.Agent;

import com.citadel.backend.entity.Agency;
import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.UserDetail;
import com.citadel.backend.vo.Commission.CitadelAgentVo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface AgentDao extends JpaRepository<Agent, Long> {
    Agent findByReferralCode(String referralCode);

    Optional<Agent> findByAgentIdAndAgency(String agentId, Agency agency);

    Optional<Agent> findByAgentIdAndStatus(String agentId, Agent.AgentStatus status);

    @Query("SELECT a.id FROM Agent a WHERE a.agency.id = :agencyId")
    Set<Long> findAgentIdsByAgencyId(@Param("agencyId") Long agencyId);

    Agent findByUserDetailAndStatus(UserDetail userDetail, Agent.AgentStatus status);

    List<Agent> findAllByAgencyAndStatus(Agency agency, Agent.AgentStatus status);

    Optional<Agent> findByAppUserAndStatus(AppUser appUser, Agent.AgentStatus status);

    @Query("SELECT new com.citadel.backend.vo.Commission.CitadelAgentVo(" +
            "a.id, " +
            "a.agentId, " +
            "a.userDetail.name, " +
            "a.agentRole.roleCode, " +
            "a.createdAt, " +
            "(SELECT rm1.id FROM Agent rm1 WHERE rm1 = a.recruitManager), " +
            "(SELECT rm2.agentId FROM Agent rm2 WHERE rm2 = a.recruitManager), " +
            "(SELECT rm3.userDetail.name FROM Agent rm3 WHERE rm3 = a.recruitManager), " +
            "(SELECT rm4.agentRole.roleCode FROM Agent rm4 WHERE rm4 = a.recruitManager)) " +
            "FROM Agent a " +
            "WHERE a.id = :agentId")
    CitadelAgentVo findCitadelAgentVoByAgentId(@Param("agentId") Long agentId);

    @Query("SELECT new com.citadel.backend.vo.Commission.CitadelAgentVo(" +
            "a.id, " +
            "a.agentId, " +
            "a.userDetail.name, " +
            "a.agentRole.roleCode, " +
            "a.createdAt, " +
            "rm.id, " +
            "rm.agentId, " +
            "rm.userDetail.name, " +
            "rm.agentRole.roleCode) " +
            "FROM Agent a " +
            "LEFT JOIN a.recruitManager rm " +
            "WHERE rm.id = :recruitManagerId")
    List<CitadelAgentVo> findSubordinatesByRecruitManagerId(@Param("recruitManagerId") Long recruitManagerId);

    Agent findByAgentId(String agentId);

    @Query("SELECT a FROM Agent a WHERE a.userDetail.identityCardNumber = :identityCardNumber AND a.status = :status")
    Agent findAgentByIdentityCardNumber(String identityCardNumber, Agent.AgentStatus status);
}
