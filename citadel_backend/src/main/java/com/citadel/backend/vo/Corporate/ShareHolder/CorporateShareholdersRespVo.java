package com.citadel.backend.vo.Corporate.ShareHolder;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateShareholdersRespVo extends BaseResp {
    private List<CorporateShareholderBaseVo> draftShareholders;
    private List<CorporateShareholderBaseVo> mappedShareholders;
}
