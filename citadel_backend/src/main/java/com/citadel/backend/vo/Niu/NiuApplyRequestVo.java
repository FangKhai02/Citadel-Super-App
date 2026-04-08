package com.citadel.backend.vo.Niu;

import com.citadel.backend.vo.Enum.NiuApplicationType;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Valid
public class NiuApplyRequestVo {
    private Integer amountRequested;//e.g. 100000 (RM100,000)
    private String tenure;//e.g. 3 months, 6 months, 12 months
    private NiuApplicationType applicationType;//e.g. Personal, Company
    private String name;//e.g. Ong Seau Meng / Aurora Sdn Bhd
    private String documentNumber;//e.g. 900909-10-5090 / 1312525-A (MyKad / Company Registration No.)
    private String address;//e.g. 7, Jalan Besar, Taman Gembira (Personal / Business Address)
    private String postcode;//e.g. 58200
    private String city;//e.g. Kuala Lumpur
    private String state;//e.g. Wilayah Persekutuan
    private String country;//e.g. Malaysia
    private String mobileCountryCode;//e.g. MY
    private String mobileNumber;//e.g. 60123747899
    private String email;//e.g. smeng90@gmail.com
    private String natureOfBusiness;//e.g. IT
    private String purposeOfAdvances;//e.g. Investment
    private List<NiuApplyDocumentVo> documents;//in base64 format

    private NiuApplySigneeVo firstSignee;
    private NiuApplySigneeVo secondSignee;
}
