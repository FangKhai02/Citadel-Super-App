package com.citadel.backend.dao;

import com.citadel.backend.entity.Setting;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SettingDao extends JpaRepository<Setting, Long> {
    Setting findByKey(String key);

    List<Setting> findByGroup(String group);
}
