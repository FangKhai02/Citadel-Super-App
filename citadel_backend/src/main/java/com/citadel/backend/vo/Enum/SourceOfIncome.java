package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum SourceOfIncome implements EnumWithValue {
    BUSINESS_REVENUE("Business Revenue"),
    COMMISSION("Commission"),
    INHERITANCE("Inheritance"),
    INVESTMENT_PROCEEDS("Investment Proceeds"),
    SALARY_BONUS("Salary/Bonus"),
    OTHERS("Others");

    public final String value;
    SourceOfIncome(String value) {
        this.value = value;
    }
}
