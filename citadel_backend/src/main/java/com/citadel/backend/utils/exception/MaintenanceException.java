package com.citadel.backend.utils.exception;

import lombok.Getter;

@Getter
public class MaintenanceException extends RuntimeException {
    private String startDatetime, endDatetime;

    public MaintenanceException(String s) {
        super(s);
    }

    public MaintenanceException(String s, String startDatetime, String endDatetime) {
        super(s);
        this.startDatetime = startDatetime;
        this.endDatetime = endDatetime;
    }
}
