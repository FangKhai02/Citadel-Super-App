package com.citadel.backend.dao;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationDao extends JpaRepository<Notification, Long> {
    List<Notification> getNotificationsByAppUserAndType(AppUser appUser, String type);
    List<Notification> getNotificationsByIdIn(List<Long> ids);
}
