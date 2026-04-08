package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum IndustryType implements EnumWithValue {
    AGRICULTURE_AND_FARMING("Agriculture & Farming"),
    AUTOMOTIVE("Automotive"),
    BANKING_AND_FINANCING("Banking & Financing Services"),
    CONSTRUCTION_AND_REAL_ESTATE("Construction & Real Estate"),
    CONSUMER_GOODS("Consumer Goods"),
    EDUCATION("Education"),
    ENERGY_AND_UTILITIES("Energy & Utilities"),
    ENTERTAINMENT_AND_MEDIA("Entertainment & Media"),
    FOOD_AND_BEVERAGE("Food & Beverage"),
    HEALTHCARE_AND_PHARMACEUTICAL("Healthcare & Pharmaceutical"),
    HOSPITALITY_AND_TOURISM("Hospitality & Tourism"),
    IT("Information Technology"),
    INSURANCE("Insurance"),
    LOGISTICS_AND_TRANSPORTATION("Logistics & Transportation"),
    MANUFACTURING("Manufacturing"),
    MINING_AND_NATURAL_RESOURCES("Mining & Natural Resources"),
    NON_PROFIT_AND_SOCIAL_SERVICES("Non-Profit & Social Services"),
    PROFESSINAL_SERVICES("Professional Services"),
    PUBLIC_SECTOR_AND_GOVERNMENT("Public Sector & Government"),
    RETAIL_AND_ECOMMERCE("Retail & E-Commerce"),
    TELECOMMUNICATIONS("Telecommunications"),
    TEXTILES_AND_APPAREL("Textiles & Apparel"),
    WHOLESALE_AND_DISTRIBUTION("Wholesale & Distribution"),
    OTHERS("Others");

    public final String value;

    IndustryType(String value) {
        this.value = value;
    }
}
