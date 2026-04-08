package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class AgentMigrationVo {
    @ExcelColumn("email")
    private String email;
    @ExcelColumn("password")
    private String password;
    @ExcelColumn("agency_id")
    private String agencyId;
    @ExcelColumn("referral_code")
    private String referralCode;
    @ExcelColumn("agent_role")
    private String agentRole;
    @ExcelColumn("name")
    private String name;
    @ExcelColumn("mobile_country_code")
    private String mobileCountryCode;
    @ExcelColumn("mobile_number")
    private String mobileNumber;
    @ExcelColumn("identity_card_number")
    private String identityCardNumber;
    @ExcelColumn("identity_doc_type")
    private String identityDocType;
    @ExcelColumn("address")
    private String address;
    @ExcelColumn("postcode")
    private String postcode;
    @ExcelColumn("city")
    private String city;
    @ExcelColumn("state")
    private String state;
    @ExcelColumn("country")
    private String country;
    @ExcelColumn("dob")
    private String dob;
    @ExcelColumn("bank_name")
    private String bankName;
    @ExcelColumn("bank_account_number")
    private String bankAccountNumber;
    @ExcelColumn("bank_account_holder_name")
    private String bankAccountHolderName;
    @ExcelColumn("bank_swift_code")
    private String bankSwiftCode;
    @ExcelColumn("bank_address")
    private String bankAddress;
    @ExcelColumn("bank_postcode")
    private String bankPostcode;
    @ExcelColumn("bank_city")
    private String bankCity;
    @ExcelColumn("bank_state")
    private String bankState;
    @ExcelColumn("bank_country")
    private String bankCountry;
    @ExcelColumn("type")
    private String type;

    public void setEmail(String email) {
        this.email = email != null ? email.strip() : null;
    }

    public void setPassword(String password) {
        this.password = password != null ? password.strip() : null;
    }

    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId != null ? agencyId.strip() : null;
    }

    public void setReferralCode(String referralCode) {
        this.referralCode = referralCode != null ? referralCode.strip() : null;
    }

    public void setAgentRole(String agentRole) {
        this.agentRole = agentRole != null ? agentRole.strip() : null;
    }

    public void setName(String name) {
        this.name = name != null ? name.strip() : null;
    }

    public void setMobileCountryCode(String mobileCountryCode) {
        this.mobileCountryCode = mobileCountryCode != null ? mobileCountryCode.strip() : null;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber != null ? mobileNumber.strip() : null;
    }

    public void setIdentityCardNumber(String identityCardNumber) {
        this.identityCardNumber = identityCardNumber != null ? identityCardNumber.strip() : null;
    }

    public void setIdentityDocType(String identityDocType) {
        this.identityDocType = identityDocType != null ? identityDocType.strip() : null;
    }

    public void setAddress(String address) {
        this.address = address != null ? address.strip() : null;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode != null ? postcode.strip() : null;
    }

    public void setCity(String city) {
        this.city = city != null ? city.strip() : null;
    }

    public void setState(String state) {
        this.state = state != null ? state.strip() : null;
    }

    public void setCountry(String country) {
        this.country = country != null ? country.strip() : null;
    }

    public void setDob(String dob) {
        this.dob = dob != null ? dob.strip() : null;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName != null ? bankName.strip() : null;
    }

    public void setBankAccountNumber(String bankAccountNumber) {
        this.bankAccountNumber = bankAccountNumber != null ? bankAccountNumber.strip() : null;
    }

    public void setBankAccountHolderName(String bankAccountHolderName) {
        this.bankAccountHolderName = bankAccountHolderName != null ? bankAccountHolderName.strip() : null;
    }

    public void setBankSwiftCode(String bankSwiftCode) {
        this.bankSwiftCode = bankSwiftCode != null ? bankSwiftCode.strip() : null;
    }

    public void setBankAddress(String bankAddress) {
        this.bankAddress = bankAddress != null ? bankAddress.strip() : null;
    }

    public void setBankPostcode(String bankPostcode) {
        this.bankPostcode = bankPostcode != null ? bankPostcode.strip() : null;
    }

    public void setBankCity(String bankCity) {
        this.bankCity = bankCity != null ? bankCity.strip() : null;
    }

    public void setBankState(String bankState) {
        this.bankState = bankState != null ? bankState.strip() : null;
    }

    public void setBankCountry(String bankCountry) {
        this.bankCountry = bankCountry != null ? bankCountry.strip() : null;
    }

    public void setType(String type) {
        this.type = type != null ? type.strip() : null;
    }
}
