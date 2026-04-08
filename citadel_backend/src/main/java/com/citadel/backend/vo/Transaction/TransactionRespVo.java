package com.citadel.backend.vo.Transaction;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TransactionRespVo extends BaseResp {
    private List<TransactionVo> transactions;
}
