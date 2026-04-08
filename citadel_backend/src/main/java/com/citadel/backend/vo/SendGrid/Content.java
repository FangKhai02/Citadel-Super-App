
package com.citadel.backend.vo.SendGrid;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Content {

    @SerializedName("type")
    @Expose
    private String type;
    @SerializedName("value")
    @Expose
    private String value;

    public Content(String type, String value) {
        this.type = type;
        this.value = value;
    }

}
