package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.Enum.AgentRole;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class AgentDownLineVo {
    private Long mgrId;
    private String mgrDigitalId;
    private String mgrName;
    private AgentRole mgrRole;
    private List<AgentDownLineVo> subordinates = new ArrayList<>();

    public void addSubordinate(AgentDownLineVo subordinate) {
        this.subordinates.add(subordinate);
    }
}
