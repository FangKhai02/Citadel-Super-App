package com.citadel.backend.vo.Corporate.Documents;

import com.citadel.backend.entity.Corporate.CorporateDocuments;
import com.citadel.backend.utils.AwsS3Util;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CorporateDocumentsVo {
    private Long id;
    private String fileName;
    private String file;

    public static CorporateDocumentsVo corporateDocumentsToCorporateDocumentsVo(CorporateDocuments corporateDocuments) {
        CorporateDocumentsVo corporateDocumentsVo = new CorporateDocumentsVo();
        corporateDocumentsVo.setId(corporateDocuments.getId());
        corporateDocumentsVo.setFileName(corporateDocuments.getCompanyDocumentName());
        corporateDocumentsVo.setFile(AwsS3Util.getS3DownloadUrl(corporateDocuments.getCompanyDocumentKey()));
        return corporateDocumentsVo;
    }
}
