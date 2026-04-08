
package com.citadel.backend.vo.SendGrid;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class Personalization {

    @SerializedName("to")
    @Expose
    private List<SendGridEmail> to = null;
    @SerializedName("cc")
    @Expose
    private List<SendGridEmail> cc = null;
    @SerializedName("bcc")
    @Expose
    private List<SendGridEmail> bcc = null;
    @SerializedName("subject")
    @Expose
    private String subject;

    public Personalization(List<SendGridEmail> to, List<SendGridEmail> cc, List<SendGridEmail> bcc, String subject) {
        this.to = to;
        this.cc = cc;
        this.bcc = bcc;
        this.subject = subject;
    }
}
