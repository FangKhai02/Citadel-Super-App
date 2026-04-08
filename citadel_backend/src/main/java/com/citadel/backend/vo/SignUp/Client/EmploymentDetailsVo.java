package com.citadel.backend.vo.SignUp.Client;

import com.citadel.backend.vo.Enum.EmploymentType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
@NotNull
public class EmploymentDetailsVo {
    @NotNull
    private EmploymentType employmentType;
    private String employerName;
    private String industryType;
    private String jobTitle;
    private String employerAddress;
    private String postcode;
    private String city;
    private String state;
    private String country;
}
