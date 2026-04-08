package com.citadel.backend.utils;

import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.Constant.*;
import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Hidden;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

public abstract class BaseRestController {

    @Value("${project.url}")
    public String HOST;

    @Value("${server.env}")
    public String ENV;

    public Logger log = LoggerFactory.getLogger(getClass());
    public Gson gson = new Gson();

    public static final String SUCCESS = "200";
    public final static String ERROR_EXCEPTION = "500";

    @Hidden
    @RequestMapping(value = "**")
    @ResponseBody
    protected ErrorResp handleResourceNotFound() {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(HttpCode.RESOURCE_NOT_FOUND.getMessage());
        return errorResp;
    }

    public ErrorResp getErrorException(Exception ex) {
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getMessage());
        return errorResp;
    }

    protected String getFunctionName() {
        // Use index 1 to get the calling method
        return new Throwable()
                .getStackTrace()[1] // Use index 1 to get the calling method
                .getMethodName();
    }
}
