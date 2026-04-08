package com.citadel.backend.controller;

import com.citadel.backend.service.LoginService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Login.ChangePasswordReqVo;
import com.citadel.backend.vo.Login.ResetPasswordReqVo;
import com.citadel.backend.vo.Login.LoginRequestVo;
import com.citadel.backend.vo.Login.LoginRespVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("api/login")
@Tag(name = "login-controller", description = "login Controller")
public class LoginController extends BaseRestController {

    @Resource
    private LoginService loginService;

    @Operation(summary = "Login with email and password", description = "Login with email and password")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = LoginRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public Object login(@RequestBody LoginRequestVo loginRequest) {
        try {
            log.info("Debug login request: " + gson.toJson(loginRequest));
            return loginService.loginUpdate(loginRequest);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Forgot password", description = "Deeplink format: citadel://reset-password/{Base64EncodedInfo}, decrypt the base64 encoded info to get the token for password reset")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
    @ResponseBody
    public Object forgotPassword(@RequestParam String email) {
        try {
            return loginService.forgotPasswordUpdate(email);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Reset password", description = "Reset password")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/reset-password", method = RequestMethod.POST)
    public @ResponseBody Object resetPassword(@Valid @RequestBody ResetPasswordReqVo resetPasswordReqVo) {
        try {
            log.info("Debug reset password request: " + gson.toJson(resetPasswordReqVo));
            return loginService.resetPasswordUpdate(resetPasswordReqVo);
        } catch (Exception ex) {
            ex.printStackTrace();
            return getErrorException(ex);
        }
    }

    @Operation(summary = "Change password", description = "Pass only old password to validate, Pass both old and new password to update")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/change-password", method = RequestMethod.POST)
    @ResponseBody
    public Object changePasswordUpdate(HttpServletRequest httpServletRequest, @Valid @RequestBody ChangePasswordReqVo changePasswordReqVo) {
        log.info("Debug change password request: " + gson.toJson(changePasswordReqVo));
        return loginService.changePasswordUpdate(HttpHeader.getApiKey(httpServletRequest), changePasswordReqVo);
    }
}
