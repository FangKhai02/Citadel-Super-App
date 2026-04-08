package com.citadel.backend.utils.Builder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UploadBase64FileBuilder {
    private String base64String;
    private String fileName;
    private String filePath;

    public UploadBase64FileBuilder base64String(String base64String) {
        this.base64String = base64String;
        return this;
    }

    public UploadBase64FileBuilder fileName(String fileName) {
        this.fileName = fileName;
        return this;
    }

    public UploadBase64FileBuilder filePath(String filePath) {
        this.filePath = filePath;
        return this;
    }
}
