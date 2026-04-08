package com.citadel.backend.service;

import com.citadel.backend.dao.AppUser.AppUserSessionDao;
import com.citadel.backend.dao.NotificationDao;
import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.AppUserSession;
import com.citadel.backend.entity.Notification;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.NotificationType;
import com.citadel.backend.vo.OneSignalPush.*;
import com.citadel.backend.vo.Notification.NotificationVo;
import com.citadel.backend.vo.Notification.NotificationsRespVo;
import com.citadel.backend.vo.Notification.NotificationsUpdateReqVo;
import com.citadel.backend.vo.Notification.SyncNotificationReqVo;
import com.github.kevinsawicki.http.HttpRequest;
import com.google.gson.Gson;
import jakarta.annotation.Resource;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpServletRequest;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.citadel.backend.utils.SpringUtil.getMessage;

@Service
public class PushNotificationService extends BaseService {

    @Resource
    NotificationDao notificationDao;
    @Resource
    AppUserSessionDao appUserSessionDao;

    public Object getUserNotificationList(HttpServletRequest httpServletRequest) {
        NotificationsRespVo resp = new NotificationsRespVo();

        AppUserSession appUserSession = validateApiKey(HttpHeader.getApiKey(httpServletRequest));
        AppUser appUser = appUserSession.getAppUser();

        List<Notification> promotions = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.PROMOTION.name());
        List<Notification> messages = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.MESSAGE.name());

        resp.setPromotions(promotions
                .stream()
                .map(NotificationVo::getNotificationVo)
                .toList());
        resp.setMessages(messages
                .stream()
                .map(NotificationVo::getNotificationVo)
                .toList());
        return resp;
    }

    public Object updateNotificationsAsRead(NotificationsUpdateReqVo notificationsUpdateReqVo, HttpServletRequest httpServletRequest) throws Exception {
        log.info("notifications update req : " + new Gson().toJson(notificationsUpdateReqVo));
        BaseResp resp = new BaseResp();

        AppUserSession appUserSession = validateApiKey(HttpHeader.getApiKey(httpServletRequest));
        AppUser appUser = appUserSession.getAppUser();

        //null list -> do nothing || empty list -> mark all as read

        //mark public notifications read
        if (notificationsUpdateReqVo.getPromotionIds() != null) {
            if (notificationsUpdateReqVo.getPromotionIds().isEmpty()) {
                List<Notification> allUserNotifications = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.PROMOTION.name());
                allUserNotifications.forEach(notification -> notification.setHasRead(true));
                notificationDao.saveAll(allUserNotifications);
            } else {
                List<Notification> notifications = notificationDao.getNotificationsByIdIn(notificationsUpdateReqVo.getPromotionIds());
                notifications.forEach(notification -> notification.setHasRead(true));
                notificationDao.saveAll(notifications);
            }
        }
        if (notificationsUpdateReqVo.getMessagesIds() != null) {
            if (notificationsUpdateReqVo.getMessagesIds().isEmpty()) {
                List<Notification> allUserNotifications = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.MESSAGE.name());
                allUserNotifications.forEach(notification -> notification.setHasRead(true));
                notificationDao.saveAll(allUserNotifications);
            } else {
                List<Notification> notifications = notificationDao.getNotificationsByIdIn(notificationsUpdateReqVo.getMessagesIds());
                notifications.forEach(notification -> notification.setHasRead(true));
                notificationDao.saveAll(notifications);
            }
        }
        return resp;
    }

    public Object updateNotificationsAsDelete(NotificationsUpdateReqVo notificationsUpdateReqVo, HttpServletRequest httpServletRequest) throws Exception {
        log.info("notifications update req : " + new Gson().toJson(notificationsUpdateReqVo));
        BaseResp resp = new BaseResp();

        AppUserSession appUserSession = validateApiKey(HttpHeader.getApiKey(httpServletRequest));
        AppUser appUser = appUserSession.getAppUser();

        if (notificationsUpdateReqVo.getPromotionIds() != null) {
            if (notificationsUpdateReqVo.getPromotionIds().isEmpty()) {
                List<Notification> allUserNotifications = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.PROMOTION.name());
                notificationDao.deleteAll(allUserNotifications);
            } else {
                List<Notification> promotions = notificationDao.getNotificationsByIdIn(notificationsUpdateReqVo.getPromotionIds());
                notificationDao.deleteAll(promotions);
            }
        }

        if (notificationsUpdateReqVo.getMessagesIds() != null) {
            if (notificationsUpdateReqVo.getMessagesIds().isEmpty()) {
                List<Notification> allUserNotifications = notificationDao.getNotificationsByAppUserAndType(appUser, NotificationType.MESSAGE.name());
                notificationDao.deleteAll(allUserNotifications);
            } else {
                List<Notification> messages = notificationDao.getNotificationsByIdIn(notificationsUpdateReqVo.getMessagesIds());
                notificationDao.deleteAll(messages);
            }
        }
        return resp;
    }

    public Object updateSyncNotifications(SyncNotificationReqVo syncNotificationReqVo, HttpServletRequest httpServletRequest) throws Exception {
        log.info("sync notifications req: " + new Gson().toJson(syncNotificationReqVo));
        AppUserSession appUserSession = validateApiKey(HttpHeader.getApiKey(httpServletRequest));
        AppUser appUser = appUserSession.getAppUser();

        List<Notification> notifications = syncNotificationReqVo.getNotifications()
                .stream()
                .map(notification -> {
                    Notification newNotification = new Notification();
                    newNotification.setAppUser(appUser);
                    newNotification.setOneSignalNotificationId(notification.getOneSignalNotificationId());
                    newNotification.setType(notification.getType());
                    newNotification.setTitle(notification.getTitle());
                    newNotification.setMessage(notification.getMessage());
                    if (notification.getImageUrls() != null && !notification.getImageUrls().isEmpty()) {
                        StringBuilder imageUrlListString = new StringBuilder();
                        for (String imageUrl : notification.getImageUrls()) {
                            imageUrlListString.append(imageUrl).append(",");
                        }
                        newNotification.setImageUrl(imageUrlListString.substring(0, imageUrlListString.length() - 1));
                    }
                    newNotification.setHasRead(notification.getIsRead());
                    newNotification.setLaunchUrl(notification.getLaunchUrl());
                    newNotification.setCreatedAt(new Date(notification.getCreatedAt()));
                    return newNotification;
                }).toList();
        notificationDao.saveAll(notifications);

        return new BaseResp();
    }

    @Async
    public void notifyAppUser(AppUser appUser, String title, String message, Date date, String uri, String image) {
        Gson gson = new Gson();
        try {
            List<AppUserSession> appUserSessions = appUserSessionDao.findAppUserSessionByAppUserAndExpiresAtIsAfter(appUser, new Date());
            List<String> deviceIds = new ArrayList<String>();
            for (AppUserSession appUserSession : appUserSessions) {
                if (appUserSession.getOneSignalSubscriptionId() != null) {
                    if (deviceIds.contains(appUserSession.getOneSignalSubscriptionId()))
                        continue;

                    if (appUserSession.getOneSignalSubscriptionId().matches("[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}"))
                        deviceIds.add(appUserSession.getOneSignalSubscriptionId());
                }
            }

            OneSignalPlayerIdReq jsonRequest = new OneSignalPlayerIdReq();
            jsonRequest.setApp_id(getMessage("notification.app.id"));
            jsonRequest.setInclude_player_ids(deviceIds);
            jsonRequest.setData(new OneSignalData(title, message, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date), uri));
            jsonRequest.setContents(new OneSignalContents(message));
            jsonRequest.setHeadings(new OneSignalContents(title));
            jsonRequest.setContent_available(true);
            jsonRequest.setIos_badgeType("Increase");
            jsonRequest.setIos_badgeCount("1");
            jsonRequest.setHuawei_msg_type("data");
            if (image != null) {
                jsonRequest.setBig_picture(image);
                jsonRequest.setHuawei_big_picture(image);
                jsonRequest.setIos_attachments(new OneSignalIosAttachments(image));
            }

            String jsonRequestString = gson.toJson(jsonRequest);

            byte[] requestBytes = jsonRequestString.getBytes(StandardCharsets.UTF_8);

            String responseBody = HttpRequest.post(getMessage("notification.url"))
                    .contentType("application/json", "UTF-8")
                    .header("Authorization", getMessage("notification.rest.api.key"))
                    .send(requestBytes).body();

            log.info("Debug onesignal push request: " + jsonRequestString);
            log.info("Debug onesignal push response: " + responseBody);

            //Create notification entity
            Notification notification = new Notification();
            notification.setAppUser(appUser);
            notification.setTitle(title);
            notification.setType(NotificationType.MESSAGE.getValue());
            notification.setMessage(message);
            notification.setHasRead(false);
            notification.setImageUrl(image);
            notification.setLaunchUrl(uri);
            notification.setCreatedAt(date);
            notificationDao.save(notification);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void silentNotifyBySubscriptionId(AppUserSession appUserSession, String title, String message, Date date, String uri) {
        Gson gson = new Gson();
        try {
            List<String> deviceIds = new ArrayList<String>();
            deviceIds.add(appUserSession.getOneSignalSubscriptionId());

            OneSignalPlayerIdReq jsonRequest = new OneSignalPlayerIdReq();
            jsonRequest.setApp_id(getMessage("notification.app.id"));
            jsonRequest.setInclude_player_ids(deviceIds);
            jsonRequest.setData(new OneSignalData(title, message, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date), uri));
            jsonRequest.setContent_available(true);

            String jsonRequestString = gson.toJson(jsonRequest);

            byte[] requestBytes = jsonRequestString.getBytes(StandardCharsets.UTF_8);

            String responseBody = HttpRequest.post(getMessage("notification.url"))
                    .contentType("application/json", "UTF-8")
                    .header("Authorization", getMessage("notification.rest.api.key"))
                    .send(requestBytes).body();

            log.info(responseBody);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void notifyAll(String title, String message, Date date, String uri) {
        Gson gson = new Gson();
        try {
            List<String> segments = new ArrayList<>();
            segments.add("All");

            OneSignalAllRequest jsonRequest = new OneSignalAllRequest();
            jsonRequest.setApp_id(getMessage("notification.app.id"));
            jsonRequest.setIncluded_segments(segments);
            jsonRequest.setData(new OneSignalData(title, message, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date), uri));
            jsonRequest.setContents(new OneSignalContents(message));
            jsonRequest.setHeadings(new OneSignalContents(title));
            jsonRequest.setContent_available(true);
            jsonRequest.setIos_badgeType("Increase");
            jsonRequest.setIos_badgeCount("1");

            String jsonRequestString = gson.toJson(jsonRequest);

            byte[] requestBytes = jsonRequestString.getBytes("UTF-8");

            String responseBody = HttpRequest.post(getMessage("notification.url"))
                    .contentType("application/json", "UTF-8")
                    .header("Authorization", getMessage("notification.rest.api.key"))
                    .send(requestBytes).body();

            System.out.println(responseBody);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
