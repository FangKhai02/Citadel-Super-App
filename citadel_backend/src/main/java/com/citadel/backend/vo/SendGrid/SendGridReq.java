
package com.citadel.backend.vo.SendGrid;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class SendGridReq {

    @SerializedName("personalizations")
    @Expose
    private List<Personalization> personalizations = null;
    @SerializedName("from")
    @Expose
    private SendGridEmail from;
    @SerializedName("reply_to")
    @Expose
    private SendGridEmail replyTo;
    @SerializedName("subject")
    @Expose
    private String subject;
    @SerializedName("content")
    @Expose
    private List<Content> content = null;
    @SerializedName("attachments")
    @Expose
    private List<Attachment> attachments = null;

}
