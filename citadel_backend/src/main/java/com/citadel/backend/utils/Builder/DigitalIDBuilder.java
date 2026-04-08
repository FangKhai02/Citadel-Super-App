package com.citadel.backend.utils.Builder;

import com.citadel.backend.vo.Enum.UserType;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class DigitalIDBuilder {

    public final static String DIGITAL_ID_REDIS_KEY = "citadel/digital-id/running-number";
    public final static long startingNumber = 0L;
    //Temporary until get confirmation from BA
    public final static long endingNumber = 9999L;

    public enum BuilderType {
        CLIENT, AGENCY, AGENT, CORPORATE_CLIENT, PRODUCT_ORDER, PRODUCT_ROLLOVER, PRODUCT_REALLOCATE, PRODUCT_WITHDRAWAL
    }

    private BuilderType builderType;
    private String name;
    private Date date;
    private String companyRegistrationNumber;
    private String agencyCode;
    private UserType userType;
    private String productName;

    public DigitalIDBuilder builderType(@NotNull BuilderType builderType) {
        this.builderType = builderType;
        return this;
    }

    public DigitalIDBuilder name(@NotNull String name) {
        this.name = name;
        return this;
    }

    public DigitalIDBuilder date(@NotNull Date dob) {
        this.date = dob;
        return this;
    }

    public DigitalIDBuilder companyRegistrationNumber(@NotNull String companyRegistrationNumber) {
        this.companyRegistrationNumber = companyRegistrationNumber;
        return this;
    }

    public DigitalIDBuilder agencyCode(@NotNull String agencyCode) {
        this.agencyCode = agencyCode;
        return this;
    }

    public DigitalIDBuilder userType(@NotNull UserType userType) {
        this.userType = userType;
        return this;
    }

    public DigitalIDBuilder productName(@NotNull String productName) {
        this.productName = productName;
        return this;
    }
}
