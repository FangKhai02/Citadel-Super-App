package com.citadel.backend.vo.SignUp;

import com.citadel.backend.vo.Enum.Relationship;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PepDeclarationOptionsVo {
    private Relationship relationship;
    private String name;
    private String position;
    private String organization;
    private String supportingDocument;
}