package com.citadel.backend.dao.AppUser;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.AppUserSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.Optional;
import java.util.List;

@Repository
public interface AppUserSessionDao extends JpaRepository<AppUserSession, Long> {
    Optional<AppUserSession> findByApiKeyAndExpiresAtAfter(String apiKey, Date date);

    List<AppUserSession> findAppUserSessionByAppUserAndExpiresAtIsAfter(AppUser appUser, Date date);

    boolean existsByAppUser(AppUser appUser);
}
