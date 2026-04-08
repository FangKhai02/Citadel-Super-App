package com.citadel.backend.vo.Corporate.Guardian;

import com.citadel.backend.entity.Corporate.CorporateGuardian;
import com.citadel.backend.utils.StringUtil;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateGuardianBaseVo {
    private Long corporateGuardianId;
    private String fullName;

    public static CorporateGuardianBaseVo corporateGuardiansBaseToCorporateBankDetailsVo(CorporateGuardian corporateGuardians) {
        CorporateGuardianBaseVo corporateGuardiansBase = new CorporateGuardianBaseVo();
        corporateGuardiansBase.setCorporateGuardianId(corporateGuardians.getId());
        corporateGuardiansBase.setFullName(StringUtil.capitalizeEachWord(corporateGuardians.getFullName()));

        return corporateGuardiansBase;
    }

}
