package com.citadel.backend.vo.Niu;

import com.citadel.backend.entity.NiuApplication;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.Setter;

import java.text.SimpleDateFormat;
import java.util.List;

@Getter
@Setter
@Valid
public class NiuGetApplicationDetailsVo {
    String applicationType;//e.g. Personal, Company
    Integer amountRequested;//e.g. 100000 (RM100,000)
    String requestedOn;//e.g. 15 Oct 2024

    //Personal Details
    String name;//e.g. Ong Seau Meng / Aurora Sdn Bhd
    String documentNumber;//e.g. 900909-10-5090 / 1312525-A (MyKad / Company Registration No.)
    String fullAddress;//e.g. 7, Jalan Besar, Taman Gembira, 58200 Kuala Lumpur, Wilayah Persekutuan, Malaysia
    String fullMobileNumber;//e.g. +60123747899
    String email;//e.g. smeng90@gmail.com

    //Documents Uploaded
    List<NiuGetDocumentVo> documents;

    public static NiuGetApplicationDetailsVo getNiuApplicationDetailsVo(NiuApplication niuApplication) {
        NiuGetApplicationDetailsVo niuGetApplicationDetailsVo = new NiuGetApplicationDetailsVo();
        niuGetApplicationDetailsVo.setApplicationType(niuApplication.getApplicationType().name());
        niuGetApplicationDetailsVo.setAmountRequested(niuApplication.getAmountRequested());

        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
        niuGetApplicationDetailsVo.setRequestedOn(sdf.format(niuApplication.getCreatedAt()));

        niuGetApplicationDetailsVo.setName(niuApplication.getName());
        niuGetApplicationDetailsVo.setDocumentNumber(niuApplication.getDocumentNumber());
        niuGetApplicationDetailsVo.setFullAddress(niuApplication.getFullAddress());
        niuGetApplicationDetailsVo.setFullMobileNumber(niuApplication.getFullMobileNumber());
        niuGetApplicationDetailsVo.setEmail(niuApplication.getEmail());
        niuGetApplicationDetailsVo.setDocuments(niuApplication.getDocuments()
                .stream()
                .map(NiuGetDocumentVo::getNiuDocumentVo)
                .toList());

        return niuGetApplicationDetailsVo;
    }
}
