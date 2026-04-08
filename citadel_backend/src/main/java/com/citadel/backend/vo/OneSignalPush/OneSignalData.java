package com.citadel.backend.vo.OneSignalPush;

public class OneSignalData {
    private String title;
    private String message;
    private String date;
    private String uri;

    public OneSignalData(String title, String message, String date, String uri) {
        this.title = title;
        this.message = message;
        this.date = date;
        this.uri = uri;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }
}
