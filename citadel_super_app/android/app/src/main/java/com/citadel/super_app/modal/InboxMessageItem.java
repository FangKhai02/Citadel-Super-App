package com.citadel.super_app.modal;

import java.io.Serializable;

public class InboxMessageItem implements Serializable {
    String notificationId, title, message, imageUrl, launchUrl;
    long date;

    public String getNotificationId() {
        return notificationId;
    }

    public InboxMessageItem setNotificationId(String notificationId) {
        this.notificationId = notificationId;
        return this;
    }

    public String getTitle() {
        return title;
    }

    public InboxMessageItem setTitle(String title) {
        this.title = title;
        return this;
    }

    public String getMessage() {
        return message;
    }

    public InboxMessageItem setMessage(String message) {
        this.message = message;
        return this;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public InboxMessageItem setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
        return this;
    }

    public long getDate() {
        return date;
    }

    public InboxMessageItem setDate(long date) {
        this.date = date;
        return this;
    }

    public String getLaunchUrl() {
        return launchUrl;
    }

    public InboxMessageItem setLaunchUrl(String launchUrl) {
        this.launchUrl = launchUrl;
        return this;
    }
}
