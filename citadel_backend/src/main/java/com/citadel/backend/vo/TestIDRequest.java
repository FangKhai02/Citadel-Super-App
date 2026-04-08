package com.citadel.backend.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class TestIDRequest {
    private List<Long> longIds;
}
