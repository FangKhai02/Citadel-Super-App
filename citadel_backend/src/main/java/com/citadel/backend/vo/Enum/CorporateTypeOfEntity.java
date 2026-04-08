package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum CorporateTypeOfEntity implements EnumWithValue {
    SOLE_PROPRIETORSHIP("Sole Proprietorship"),
    RELIGIOUS_PLACE("Religious Place"),
    SOCIETY("Society"),
    NON_GOVERNMENT_ORGANIZATION("Non-Government Organization"),
    LIMITED_LIABILITY_PARTNERS("Limited Liability Partners"),
    PRIVATE_LIMITED("Private Limited"),
    PUBLIC_LIMITED("Public Limited"),
    CORPORATION("Corporation"),
    PARTNERSHIP("Partnership"),
    ASSOCIATION("Association");

    public final String value;

    CorporateTypeOfEntity(String value) {
        this.value = value;
    }
}
