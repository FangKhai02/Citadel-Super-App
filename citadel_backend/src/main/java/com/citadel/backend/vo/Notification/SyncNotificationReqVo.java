package com.citadel.backend.vo.Notification;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SyncNotificationReqVo {
    List<SyncNotificationVo> notifications;
}
