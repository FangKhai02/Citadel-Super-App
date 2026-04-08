package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.Enum.MaritalStatus;
import com.citadel.backend.vo.Enum.ResidentialStatus;
import com.citadel.backend.vo.SignUp.CorrespondingAddress;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClientProfileEditReqVo {
    private String name;
    private String address;
    private String postcode;
    private String city;
    private String state;
    private String country;
    private CorrespondingAddress correspondingAddress = new CorrespondingAddress();
    private ResidentialStatus residentialStatus;
    private MaritalStatus maritalStatus;
    private String mobileCountryCode;
    private String mobileNumber;
    private String email;
    private EmploymentDetailsVo employmentDetails;
    private String nationality;
    // Wealth Source Details
    private String annualIncomeDeclaration;
    private String sourceOfIncome;
}
