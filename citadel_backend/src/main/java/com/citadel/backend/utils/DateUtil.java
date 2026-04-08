package com.citadel.backend.utils;

import com.citadel.backend.vo.QuarterVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
    public static final SimpleDateFormat DF_TM = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static final Logger log = LoggerFactory.getLogger(DateUtil.class);

    public static String getTodayFull() {
        Calendar calendar = Calendar.getInstance();
        return DF_TM.format(calendar.getTime());
    }

    public static Date getDateThirtyDaysAgo() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.add(Calendar.DAY_OF_YEAR, -30);
        return calendar.getTime();
    }

    public static Date getLastDayOfCurrentMonth() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        // Set the date to the last day of the current month
        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        return calendar.getTime();
    }

    public static Date addDays(Date date, int days) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_MONTH, days);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    public static Date addMinutes(Date date, int minutes) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.MINUTE, minutes);
        return calendar.getTime();
    }

    public static Date getTenMinutesAgo() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, -10);
        return calendar.getTime();
    }

    public static String convertDateToString(Date date) {
        return convertDateToString(date, null);
    }

    public static String convertDateToString(Date date, String format) {
        if (StringUtil.isEmpty(format)) {
            return DF_TM.format(date);
        }
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }

    public static Date getStartOfTheDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }

    public static Date getEndOfTheDay(Date date) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY, 23);
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 59);
        calendar.set(Calendar.MILLISECOND, 999);
        return calendar.getTime();
    }

    public static boolean isUnder18(Date dob) {
        Calendar currentCalendar = Calendar.getInstance();
        currentCalendar.setTime(new Date());

        Calendar dobCalendar = Calendar.getInstance();
        dobCalendar.setTime(dob);

        int age = currentCalendar.get(Calendar.YEAR) - dobCalendar.get(Calendar.YEAR);
        if (age <= 18) {
            if (dobCalendar.get(Calendar.MONTH) >= currentCalendar.get(Calendar.MONTH) && age == 18) {
                return dobCalendar.get(Calendar.DAY_OF_YEAR) >= currentCalendar.get(Calendar.DAY_OF_YEAR);
            }
            return true;
        }
        return false;
    }

    public static boolean isCurrentMonthAndYear(Date date) {
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH);

        Calendar givenCalendar = Calendar.getInstance();
        givenCalendar.setTime(date);
        int givenYear = givenCalendar.get(Calendar.YEAR);
        int givenMonth = givenCalendar.get(Calendar.MONTH);

        return (givenYear == currentYear) && (givenMonth == currentMonth);
    }

    public static LocalDate convertDateToLocalDate(Date date) {
        if (date == null) {
            return null; // Handle null case if needed
        }
        return date.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
    }

    public static Date convertLocalDateToDate(LocalDate localDate) {
        if (localDate == null) {
            return null; // Handle null case if needed
        }
        return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public static String returnDayWithOrdinal(int day) {
        String suffix;
        if (day >= 11 && day <= 13) {
            suffix = "<sup>th</sup>";  // Special case for 11th, 12th, 13th (superscript th)
        } else {
            suffix = switch (day % 10) {
                case 1 -> "<sup>st</sup>";  // Superscript for "st"
                case 2 -> "<sup>nd</sup>";  // Superscript for "nd"
                case 3 -> "<sup>rd</sup>";  // Superscript for "rd"
                default -> "<sup>th</sup>";  // Superscript for "th"
            };
        }
        return day + suffix;
    }

    public static QuarterVo getQuarter(LocalDate date) {
        int year = date.getYear();
        int month = date.getMonthValue();
        int quarterNumber = (month + 2) / 3;
        LocalDate startDate = LocalDate.of(year, (quarterNumber - 1) * 3 + 1, 1);
        LocalDate endDate = startDate.plusMonths(3).minusDays(1);
        return new QuarterVo(year, quarterNumber, startDate, endDate);
    }

    public static Date convertStringToDate(String dateStr) {
        try {
            if (StringUtil.isEmpty(dateStr)) {
                return null;
            }
            dateStr = dateStr.trim();

            // Check for Excel's date format: "MM/dd/yyyy HH:mm:ss"
            if (dateStr.matches("^\\d{1,2}/\\d{1,2}/\\d{4} \\d{2}:\\d{2}:\\d{2}$")) {
                // Split the date and time parts
                String[] parts = dateStr.split(" ");
                String[] dateParts = parts[0].split("/");

                // Ensure month and day are two digits
                String month = dateParts[0].length() == 1 ? "0" + dateParts[0] : dateParts[0];
                String day = dateParts[1].length() == 1 ? "0" + dateParts[1] : dateParts[1];

                // Rebuild the date string in "yyyy-MM-dd HH:mm:ss" format
                String formattedDateStr = dateParts[2] + "-" + month + "-" + day + " " + parts[1];
                return DF_TM.parse(formattedDateStr);
            }

            // Handle MM/dd/yy (e.g., 9/15/23)
            if (dateStr.matches("^\\d{1,2}/\\d{1,2}/\\d{4}$")) {
                SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy");
                Date date = sdf.parse(dateStr);
                Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                cal.set(Calendar.HOUR_OF_DAY, 0);
                cal.set(Calendar.MINUTE, 0);
                cal.set(Calendar.SECOND, 0);
                cal.set(Calendar.MILLISECOND, 0);
                return cal.getTime();
            }

            // If the string only contains the date part (e.g., "2025-05-15")
            if (dateStr.matches("^\\d{4}-\\d{2}-\\d{2}$")) {
                dateStr += " 00:00:00";
            }
            // If the string contains date and hour:minute (e.g., "2025-05-15 10:30")
            else if (dateStr.matches("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}$")) {
                dateStr += ":00";
            }
            // If it doesn't match "yyyy-MM-dd HH:mm:ss" exactly, then it's not valid.
            else if (!dateStr.matches("^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$")) {
                return null;
            }
            return DF_TM.parse(dateStr);
        } catch (ParseException e) {
            log.error("Error parsing date string: {}", dateStr);
            return null;
        }
    }

    public static LocalDate getLastDayOfMonth(LocalDate date) {
        // Get the year and month from the input date
        int year = date.getYear();
        int month = date.getMonthValue();

        // Create a date on the last day of the month
        return LocalDate.of(year, month, date.lengthOfMonth());
    }

    public static LocalDate addBusinessDays(LocalDate date, int days) {
        if (days < 0) {
            throw new IllegalArgumentException("Days must be non-negative");
        }

        LocalDate result = date;
        while (days > 0) {
            result = result.plusDays(1);
            // Check if the day is a weekend (Saturday or Sunday)
            if (result.getDayOfWeek().getValue() < 6) { // Monday to Friday are 1 to 5
                days--;
            }
        }
        return result;
    }

    public static LocalDate subtractBusinessDays(LocalDate date, int days) {
        if (days < 0) {
            throw new IllegalArgumentException("Days must be non-negative");
        }

        LocalDate result = date;
        while (days > 0) {
            result = result.minusDays(1);
            // Check if the day is a weekend (Saturday or Sunday)
            if (result.getDayOfWeek().getValue() < 6) { // Monday to Friday are 1 to 5
                days--;
            }
        }
        return result;
    }

    public static LocalDateTime convertDateToLocalDateTime(Date date) {
        if (date == null) {
            return null;
        }
        return date.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime();
    }
}
