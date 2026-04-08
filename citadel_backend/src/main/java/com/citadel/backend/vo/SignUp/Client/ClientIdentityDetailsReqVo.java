package com.citadel.backend.vo.SignUp.Client;

import com.citadel.backend.vo.Enum.Gender;
import com.citadel.backend.vo.SignUp.SignUpBaseIdentityDetailsVo;
import com.esotericsoftware.kryo.serializers.FieldSerializer.NotNull;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class ClientIdentityDetailsReqVo extends SignUpBaseIdentityDetailsVo {
    @NotNull
    private Gender gender;
    @NotBlank
    private String nationality;
}
