package com.citadel.backend.vo.Notification;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class NotificationsRespVo extends BaseResp {

   private List<NotificationVo> promotions;
   private List<NotificationVo> messages;
}
