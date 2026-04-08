package com.citadel.backend.vo.Enum;

import com.citadel.backend.vo.Interface.EnumWithValue;
import lombok.Getter;

@Getter
public enum AgentRole implements EnumWithValue {
    MGR("Sales Manager"),
    P2P("Peer to peer"),
    SM("Senior Manager"),
    AVP("Assistant Vice President"),
    VP("Vice President"),
    SVP("Senior Vice President");

    public final String value;
    AgentRole(String value) {
        this.value = value;
    }
}
