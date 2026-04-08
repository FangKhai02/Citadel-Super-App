package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.entity.Corporate.CorporateShareholder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateShareholderBaseVo {
    private Long id;
    private String name;
    private Double percentageOfShareholdings;
    private CorporateShareholder.CorporateShareholderStatus status;

    public static CorporateShareholderBaseVo corporateShareholderToCorporateShareholderBaseVo(CorporateShareholder corporateShareHolder) {
        CorporateShareholderBaseVo corporateShareHolderBase = new CorporateShareholderBaseVo();
        if (corporateShareHolder != null) {
            corporateShareHolderBase.setId(corporateShareHolder.getId());
            corporateShareHolderBase.setName(corporateShareHolder.getName());
            corporateShareHolderBase.setPercentageOfShareholdings(corporateShareHolder.getPercentageOfShareholdings());
            corporateShareHolderBase.setStatus(corporateShareHolder.getStatus());
        }
        return corporateShareHolderBase;
    }
}
