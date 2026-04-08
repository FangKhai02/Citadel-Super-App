package com.citadel.backend.vo.Product.req;

import com.citadel.backend.vo.Enum.CmsAdmin;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class CmsAdminPOStatusUpdateReqVo {
    @NotNull
    private CmsAdmin.AdminType adminType;
    @NotBlank
    private String adminEmail;
    @NotNull
    private CmsAdmin.Status adminStatus;
    private String adminRemark;
}
