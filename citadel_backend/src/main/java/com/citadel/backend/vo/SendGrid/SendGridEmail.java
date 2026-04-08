
package com.citadel.backend.vo.SendGrid;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SendGridEmail {

    @SerializedName("email")
    @Expose
    private String email;
    @SerializedName("name")
    @Expose
    private String name;

    public SendGridEmail(String email, String name) {
        this.email = email;
        this.name = name;
    }
}
