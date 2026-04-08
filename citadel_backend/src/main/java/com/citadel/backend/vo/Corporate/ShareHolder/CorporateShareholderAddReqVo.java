package com.citadel.backend.vo.Corporate.ShareHolder;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CorporateShareholderAddReqVo {
    private List<CorporateShareHolderAddVo> shareHolders;
}
