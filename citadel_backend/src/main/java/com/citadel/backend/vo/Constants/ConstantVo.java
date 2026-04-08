package com.citadel.backend.vo.Constants;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ConstantVo {
    String category;
    List<KeyValueMapVo> list;
}
