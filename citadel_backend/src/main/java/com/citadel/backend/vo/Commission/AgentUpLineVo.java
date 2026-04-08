package com.citadel.backend.vo.Commission;

import com.citadel.backend.vo.Enum.AgentRole;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgentUpLineVo {
    private Long mgrId;
    private String mgrDigitalId;
    private String mgrName;
    private AgentRole mgrRole;
    private Long recruitMangerId;
    private String recruitManagerDigitalId;
    private String recruitManagerName;
    private Long p2pAgentId;
    private String p2pAgentDigitalId;
    private String p2pAgentName;
    private Long smAgentId;
    private String smAgentDigitalId;
    private String smAgentName;
    private Long avpAgentId;
    private String avpAgentDigitalId;
    private String avpAgentName;
    private Long vpAgentId;
    private String vpAgentDigitalId;
    private String vpAgentName;
    private Long svpAgentId;
    private String svpAgentDigitalId;
    private String svpAgentName;
}
