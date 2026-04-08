package com.citadel.backend.dao.Agent;

import com.citadel.backend.entity.AgentRoleSettings;
import com.citadel.backend.vo.Enum.AgentRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AgentRoleSettingsDao extends JpaRepository<AgentRoleSettings, Long> {
    AgentRoleSettings findByRoleCode(AgentRole roleCode);
}
