package com.citadel.backend.vo.Corporate;

import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsVo;
import com.citadel.backend.vo.Corporate.ShareHolder.CorporateShareholderBaseVo;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateProfileRespVo extends BaseResp {
    private CorporateClientVo corporateClient;
    private CorporateDetailsVo corporateDetails;
    private List<CorporateDocumentsVo> corporateDocuments;
    private List<CorporateShareholderBaseVo> bindedCorporateShareholders;
}
