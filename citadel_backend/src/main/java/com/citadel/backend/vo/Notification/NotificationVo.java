package com.citadel.backend.vo.Notification;

import com.citadel.backend.entity.Notification;
import lombok.Getter;
import lombok.Setter;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Getter
@Setter
public class NotificationVo {

    private Long id;
    private String oneSignalNotificationId;
    private String type;
    private String title;
    private String message;
    private List<String> imageUrls;
    private String launchUrl;
    private Long createdAt;
    private Boolean hasRead;

    public static NotificationVo getNotificationVo(Notification notification) {
        NotificationVo notificationVo = new NotificationVo();
        notificationVo.setId(notification.getId());
        notificationVo.setOneSignalNotificationId(notification.getOneSignalNotificationId());
        notificationVo.setType(notification.getType());
        notificationVo.setTitle(notification.getTitle());
        notificationVo.setMessage(notification.getMessage());
        notificationVo.setImageUrls(notification.getImageUrl() == null ? null : Arrays.asList(notification.getImageUrl().split(",")));
        notificationVo.setLaunchUrl(notification.getLaunchUrl());
        notificationVo.setCreatedAt(notification.getCreatedAt().getTime());
        notificationVo.setHasRead(notification.getHasRead());
        return notificationVo;
    }
}
