package com.citadel.backend.vo.Setting;

import com.citadel.backend.vo.BaseResp;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SettingsRespVo extends BaseResp {
    List<SettingsItemVo> settings;
}
