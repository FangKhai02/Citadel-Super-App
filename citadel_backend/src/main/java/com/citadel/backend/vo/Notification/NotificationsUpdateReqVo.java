package com.citadel.backend.vo.Notification;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class NotificationsUpdateReqVo {

    private List<Long> promotionIds;
    private List<Long> messagesIds;
}
