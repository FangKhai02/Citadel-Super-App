package com.citadel.backend.dao.Client;

import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.UserDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClientDao extends JpaRepository<Client, Long> {
    Optional<Client> findByAppUser(AppUser appUser);

    Client findByClientIdAndPin(String clientId, String pin);

    List<Client> findAllByAgent(Agent agent);

    Optional<Client> findByAgentAndClientId(Agent agent, String clientId);

    Client findByUserDetailAndStatusIsTrue(UserDetail userDetail);

    Optional<Client> findByClientId(String clientId);

    @Query("SELECT c FROM Client c WHERE c.userDetail.identityCardNumber = :identityCardNumber  AND c.status = true")
    Optional<Client> findClientByIdentityCardNumberAndStatusIsTrue(String identityCardNumber);

    Client findByAppUserAndStatusIsTrue(AppUser appUser);
}
