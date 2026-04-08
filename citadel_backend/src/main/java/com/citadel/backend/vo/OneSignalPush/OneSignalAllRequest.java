package com.citadel.backend.vo.OneSignalPush;

import java.util.List;

public class OneSignalAllRequest {
    private String app_id;
    private List<String> included_segments;
    private OneSignalData data;
    private OneSignalContents contents;
    private OneSignalContents headings;
    private boolean content_available;
    private String ios_badgeType;
    private String ios_badgeCount;

    public String getApp_id() {
        return app_id;
    }

    public void setApp_id(String app_id) {
        this.app_id = app_id;
    }

    public List<String> getIncluded_segments() {
        return included_segments;
    }

    public void setIncluded_segments(List<String> included_segments) {
        this.included_segments = included_segments;
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

    public OneSignalContents getHeadings() {
        return headings;
    }

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
}
