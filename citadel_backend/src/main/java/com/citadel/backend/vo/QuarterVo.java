package com.citadel.backend.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class QuarterVo {
    private int year;
    private int quarterNumber;
    private LocalDate startDate;
    private LocalDate endDate;

    public static QuarterVo addQuarter(LocalDate startDate, LocalDate endDate) {
        int year = startDate.getYear();
        int month = startDate.getMonthValue();
        int quarterNumber = (month + 2) / 3;
        return new QuarterVo(year, quarterNumber, startDate, endDate);
    }
}
