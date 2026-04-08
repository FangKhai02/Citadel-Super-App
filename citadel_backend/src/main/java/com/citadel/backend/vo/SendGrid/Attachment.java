package com.citadel.backend.vo.SendGrid;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Attachment {
    String content, type, filename;

    public Attachment(String content, String type, String filename) {
        this.content = content;
        this.type = type;
        this.filename = filename;
    }
}
