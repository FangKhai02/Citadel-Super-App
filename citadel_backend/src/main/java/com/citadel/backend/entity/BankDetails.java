package com.citadel.backend.entity;

import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Corporate.CorporateShareholder;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.StringUtil;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "bank_details")
public class BankDetails extends BaseEntity {
    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "app_user_id")
    private AppUser appUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "individual_beneficiary_id")
    private IndividualBeneficiary individualBeneficiary;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_shareholders_id")
    private CorporateShareholder corporateShareholder;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agency_id")
    private Agency agency;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "corporate_client_id")
    private CorporateClient corporateClient;

    @Column(name = "bank_name")
    private String bankName;

    @Column(name = "account_number")
    private String accountNumber;

    @Column(name = "account_holder_name")
    private String accountHolderName;

    @Column(name = "bank_address")
    private String bankAddress;

    @Column(name = "postcode")
    private String postcode;

    @Column(name = "city")
    private String city;

    @Column(name = "state")
    private String state;

    @Column(name = "country")
    private String country;

    @Column(name = "swift_code")
    private String swiftCode;

    @Column(name = "bank_account_proof_key")
    private String bankAccountProofKey;

    @Column(name = "is_deleted")
    private Boolean isDeleted;

    public String getBankAccountProofKey() {
        if (StringUtil.isEmpty(this.bankAccountProofKey)) {
            return null;
        } else {
            return AwsS3Util.getS3DownloadUrl(this.bankAccountProofKey);
        }
    }

    public static BankDetails createNewBankDetailFromSignUpHistory(SignUpHistory signUpHistory) {
        BankDetails bankDetail = new BankDetails();
        bankDetail.setBankName(signUpHistory.getBankName());
        bankDetail.setAccountNumber(signUpHistory.getAccountNumber());
        bankDetail.setAccountHolderName(signUpHistory.getAccountHolderName());
        bankDetail.setBankAddress(StringUtil.capitalizeEachWord(signUpHistory.getBankAddress()));
        bankDetail.setPostcode(signUpHistory.getBankPostcode());
        bankDetail.setCity(StringUtil.capitalizeEachWord(signUpHistory.getBankCity()));
        bankDetail.setState(StringUtil.capitalizeEachWord(signUpHistory.getBankState()));
        bankDetail.setCountry(StringUtil.capitalizeEachWord(signUpHistory.getBankCountry()));
        bankDetail.setSwiftCode(signUpHistory.getSwiftCode());
        bankDetail.setBankAccountProofKey(signUpHistory.getProofOfBankAccountKey());
        bankDetail.setIsDeleted(false);
        bankDetail.setCreatedAt(new Date());
        bankDetail.setUpdatedAt(new Date());
        return bankDetail;
    }

    @Transient
    public String getFullBankAddress() {
        return StringUtil.capitalizeEachWord((getBankAddress() == null ? "" : getBankAddress()) +
                (getPostcode() == null ? "" : ", " + getPostcode()) +
                (getCity() == null ? "" : ", " + getCity()) +
                (getState() == null ? "" : ", " + getState()) +
                (getCountry() == null ? "" : ", " + getCountry()));
    }
}
