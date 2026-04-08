package com.citadel.backend.vo.Corporate.ShareHolder;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ShareHoldingsValidationReqVo {
    private List<Long> shareHolderIds;
}
