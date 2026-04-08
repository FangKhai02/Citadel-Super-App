package com.citadel.backend.vo.Agent;

import com.citadel.backend.vo.Enum.SecureTagStatus;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AgentSecureTagVo {
    SecureTagStatus status;
    String clientName, clientId, token;
}
