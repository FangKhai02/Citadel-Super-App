package com.citadel.backend.dao.Niu;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.NiuApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NiuApplicationDao extends JpaRepository<NiuApplication, Long> {
    List<NiuApplication> findByAppUser(AppUser appUser);

    List<NiuApplication> findByCorporateClient(CorporateClient corporateClient);
}
