package com.citadel.backend.controller;

import com.citadel.backend.service.OtpService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Otp.OtpVerificationReq;
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
import com.citadel.backend.utils.exception.ErrorResp;

@Controller
@RequestMapping("api/otp")
@Tag(name = "otp-controller", description = "OTP Controller")
public class OtpController extends BaseRestController {

    @Resource
    private OtpService otpService;

    @Operation(summary = "Send OTP to user")
    @RequestMapping(value = "/send", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object sendOtp(HttpServletRequest httpServletRequest) {
        return otpService.sendOtp(HttpHeader.getApiKey(httpServletRequest));
    }

    @Operation(summary = "Verify OTP")
    @RequestMapping(value = "/verify", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object verifyOtp(@Valid @RequestBody OtpVerificationReq otpVerifyReqVo, HttpServletRequest httpServletRequest) {
        return otpService.verifyOtp(otpVerifyReqVo, HttpHeader.getApiKey(httpServletRequest));
    }


}
