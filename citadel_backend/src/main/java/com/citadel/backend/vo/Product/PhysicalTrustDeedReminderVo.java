package com.citadel.backend.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PhysicalTrustDeedReminderVo {
    private Long id;
    private String agreementFileName;

    public PhysicalTrustDeedReminderVo(Long id, String agreementFileName) {
        this.id = id;
        this.agreementFileName = agreementFileName;
    }
}
