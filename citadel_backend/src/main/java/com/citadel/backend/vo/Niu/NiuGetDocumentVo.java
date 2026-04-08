package com.citadel.backend.vo.Niu;

import com.citadel.backend.entity.NiuApplicationDocument;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Valid
public class NiuGetDocumentVo {
    String filename;//e.g. MyKad.jpg
    String url;//e.g. https://sgp1.digitaloceanspaces.com/nexstream-dev/citadel/niu/application/2024/11/12/970529-01-5411/3/MyKad.png

    public static NiuGetDocumentVo getNiuDocumentVo(NiuApplicationDocument niuApplicationDocument) {
        NiuGetDocumentVo niuGetDocumentVo = new NiuGetDocumentVo();
        niuGetDocumentVo.setFilename(niuApplicationDocument.getFilename());
        niuGetDocumentVo.setUrl(niuApplicationDocument.getUrl());
        return niuGetDocumentVo;
    }
}
