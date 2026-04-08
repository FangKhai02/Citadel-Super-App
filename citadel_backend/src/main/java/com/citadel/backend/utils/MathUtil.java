package com.citadel.backend.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class MathUtil {
    public static Integer doubleToInteger(Double amount) {
        double multipliedAmount = amount * 100.0;
        BigDecimal bd = new BigDecimal(multipliedAmount).setScale(3, RoundingMode.HALF_UP);
        double roundedAmount = bd.doubleValue();
        return (Integer) (int) roundedAmount;
    }

    public static Double roundOff(Double amount) {
        BigDecimal bd = new BigDecimal(amount).setScale(2, RoundingMode.HALF_UP);

        BigDecimal remainder = bd.remainder(new BigDecimal("0.10"));
        BigDecimal roundedValue;

        //Here's how compareTo works:
        //Returns 0: if the two BigDecimal values are equal.
        //Returns 1: if the value of remainder is greater than compared value.
        //Returns -1: if the value of remainder is less than compared value.

        // Remainder is 0.00, 0.01, 0.02 - round down to nearest 0.1
        if (remainder.compareTo(new BigDecimal("0.02")) <= 0) {
            roundedValue = bd.setScale(1, RoundingMode.HALF_DOWN);
        }
        // Remainder is 0.08 or above - round up to nearest 0.1
        else if (remainder.compareTo(new BigDecimal("0.08")) >= 0) {
            roundedValue = bd.setScale(1, RoundingMode.HALF_UP);
        }
        // For other values (0.03 to 0.07), round to nearest 0.05
        else {
            BigDecimal roundToNearestFive = new BigDecimal("0.05");
            roundedValue = bd.divide(new BigDecimal("0.05"), 0, RoundingMode.HALF_UP).multiply(roundToNearestFive);
        }

        roundedValue = roundedValue.setScale(2, RoundingMode.HALF_UP);
        // Convert to double
        return roundedValue.doubleValue();
    }

    public static Double multiplyAndRoundOff(double amount1, double amount2, int scale) {
        // Calculate taxed amount
        double answer = amount1 * amount2;

        // Convert to BigDecimal and round to 2 decimal places
        BigDecimal bd = new BigDecimal(answer).setScale(scale, RoundingMode.HALF_UP);

        // Convert back to Double
        answer = bd.doubleValue();
        return answer;
    }

    public static Double integerToDouble(Integer amount) {
        double dividedAmount = amount / 100.0;
        BigDecimal bd = new BigDecimal(dividedAmount).setScale(2, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    public static String convertIntegerToString(Integer amount) {
        Double result = amount/100.0;
        return String.format("%.2f", result);
    }

    public static Double subtractDouble(Double amount1, Double amount2) {
        BigDecimal bd1 = new BigDecimal(amount1);
        BigDecimal bd2 = new BigDecimal(amount2);
        return bd1.subtract(bd2).setScale(2, RoundingMode.HALF_UP).doubleValue();
    }

    public static Double roundHalfUp(Double amount) {
        BigDecimal bd = BigDecimal.valueOf(amount);
        return bd.setScale(2, RoundingMode.HALF_UP).doubleValue();
    }
}
