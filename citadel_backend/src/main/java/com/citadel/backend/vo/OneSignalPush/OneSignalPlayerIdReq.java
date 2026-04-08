package com.citadel.backend.vo.OneSignalPush;

import java.util.List;

public class OneSignalPlayerIdReq {
    private String app_id;
    private List<String> include_player_ids;
    private OneSignalData data;
    private OneSignalContents contents;
    private OneSignalContents headings;
    private boolean content_available;
    private String ios_badgeType;
    private String ios_badgeCount;
    private OneSignalIosAttachments ios_attachments;//IOS
    private String big_picture;//Android
    private String huawei_big_picture;//Huawei
    private String huawei_msg_type;


    public String getApp_id() {
        return app_id;
    }
    public void setApp_id(String app_id) {
        this.app_id = app_id;
    }

    public List<String> getInclude_player_ids() {
        return include_player_ids;
    }
    public void setInclude_player_ids(List<String> include_player_ids) {
        this.include_player_ids = include_player_ids;
    }

    public OneSignalData getData() {
        return data;
    }
    public void setData(OneSignalData data) {
        this.data = data;
    }

    public OneSignalContents getContents() {
        return contents;
    }
    public void setContents(OneSignalContents contents) {
        this.contents = contents;
    }

    public OneSignalContents getHeadings() { return headings; }
    public void setHeadings(OneSignalContents headings) {
        this.headings = headings;
    }

    public boolean isContent_available() {
        return content_available;
    }
    public void setContent_available(boolean content_available) {
        this.content_available = content_available;
    }

    public String getIos_badgeType() {
        return ios_badgeType;
    }
    public void setIos_badgeType(String ios_badgeType) {
        this.ios_badgeType = ios_badgeType;
    }

    public String getIos_badgeCount() {
        return ios_badgeCount;
    }
    public void setIos_badgeCount(String ios_badgeCount) {
        this.ios_badgeCount = ios_badgeCount;
    }

    public String getHuawei_msg_type() {
        return huawei_msg_type;
    }
    public void setHuawei_msg_type(String huawei_msg_type) {
        this.huawei_msg_type = huawei_msg_type;
    }

    public OneSignalIosAttachments getIos_attachments() {
        return ios_attachments;
    }

    public void setIos_attachments(OneSignalIosAttachments ios_attachments) {
        this.ios_attachments = ios_attachments;
    }

    public String getBig_picture() {
        return big_picture;
    }

    public void setBig_picture(String big_picture) {
        this.big_picture = big_picture;
    }

    public String getHuawei_big_picture() {
        return huawei_big_picture;
    }

    public void setHuawei_big_picture(String huawei_big_picture) {
        this.huawei_big_picture = huawei_big_picture;
    }
}


