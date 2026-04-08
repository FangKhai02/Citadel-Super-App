package com.citadel.backend.vo.Corporate.Documents;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateDocumentsRespVo extends BaseResp {
    List<CorporateDocumentsVo> corporateDocuments;
}
