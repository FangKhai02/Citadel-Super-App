package com.citadel.backend.dao;

import com.citadel.backend.entity.Agency;
import com.citadel.backend.vo.Enum.AgencyType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AgencyDao extends JpaRepository<Agency, Long> {
    List<Agency> findAllByStatusIsTrue();

    Optional<Agency> findByAgencyId(String agencyId);

    @Query("SELECT a.id FROM Agency a " +
            "WHERE a.agencyType = :agencyType")
    List<Long> findAgencyIdsByAgencyType(@Param("agencyType") AgencyType agencyType);

    @Query("SELECT a.emailAddress FROM Agency a WHERE a.id = :id")
    String getAgencyEmailAddressById(@Param("id") Long id);

    @Query("SELECT a.agencyRegNumber FROM Agency a WHERE a.id = :id")
    String getAgencyRegNumberByAgencyId(@Param("id") Long id);

    @Query(value = "SELECT a.agency_id FROM agency a WHERE a.agency_type = 'CITADEL' AND a.status = true LIMIT 1", nativeQuery = true)
    String getCitadelAgencyId();

    Agency findAgencyByAgencyRegNumber(String agencyRegNumber);
}
