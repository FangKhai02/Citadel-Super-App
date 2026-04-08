package com.citadel.backend.dao;

import com.citadel.backend.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public interface MaintenanceWindowDao extends JpaRepository<MaintenanceWindow, Long> {

    @Query("SELECT mw FROM MaintenanceWindow mw " +
            "WHERE mw.status = true " +
            "AND mw.startDatetime <= :now " +
            "AND mw.endDatetime > :now")
    MaintenanceWindow getMaintenanceWindowByDateAndEnabled(@Param("now") Date now);
}
