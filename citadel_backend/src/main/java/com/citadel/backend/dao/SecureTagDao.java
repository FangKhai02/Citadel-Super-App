package com.citadel.backend.dao;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.SecureTag;
import com.citadel.backend.vo.Enum.SecureTagStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface SecureTagDao extends JpaRepository<SecureTag, Long> {
    @Query("SELECT st FROM SecureTag st WHERE st.client = ?1 and st.status = ?2 ORDER BY st.id DESC LIMIT 1")
    SecureTag getLatestSecureTagByClientAndStatus(Client client, SecureTagStatus status);

    @Query("SELECT st FROM SecureTag st WHERE st.agent = ?1 and st.client = ?2 and st.hasRead = false ORDER BY st.id DESC LIMIT 1")
    SecureTag getLatestSecureTagByAgentAndClientAndHasReadIsFalse(Agent agent, Client client);
}
