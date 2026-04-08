package com.citadel.backend.vo.Notification;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SyncNotificationVo {
    public enum TYPE {
        PROMOTION, NOTIFICATION
    }

    private String oneSignalNotificationId;
    private String type;//, PROMOTION, MESSAGE
    private String title;
    private String message;
    private List<String> imageUrls;
    private String launchUrl;
    private Boolean isRead;
    private Long createdAt;
}
