package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.Enum.EmploymentType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClientEmploymentDetailsVo {
    private EmploymentType employmentType;
    private String employerName;
    private String industryType;
    private String jobTitle;
    private String employerAddress;
    private String employerPostcode;
    private String employerCity;
    private String employerState;
    private String employerCountry;
}
