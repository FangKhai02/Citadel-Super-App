package com.citadel.backend.vo.Migration;

import com.citadel.backend.annotation.ExcelColumn;
import lombok.Data;

@Data
public class AgentUplineMigrationVo {
    @ExcelColumn("agent_identity_card_number")
    private String agentIdentityCardNumber;
    @ExcelColumn("recruit_manager_identity_card_number")
    private String recruitManagerIdentityCardNumber;
}
