package com.citadel.backend.vo.Migration;

import lombok.Data;

import java.util.List;

@Data
public class MigrationSheetReq {
    List<Integer> sheetIndexList;
}
