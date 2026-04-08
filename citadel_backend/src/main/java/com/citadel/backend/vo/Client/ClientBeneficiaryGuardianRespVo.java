package com.citadel.backend.vo.Client;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ClientBeneficiaryGuardianRespVo extends BaseResp {
    private List<IndividualBeneficiaryVo> beneficiaries;
}
