package com.citadel.backend.controller;

import com.citadel.backend.service.BankService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BankDetails.BankDetailsResp;
import com.citadel.backend.vo.BankDetails.CreateBankRespVo;
import com.citadel.backend.vo.BaseResp;
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
@RequestMapping("api/bank")
@Tag(name = "bank-controller", description = "Bank Controller")
public class BankController extends BaseRestController {

    @Resource
    private BankService bankService;

    @Operation(summary = "Bank Details create")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CreateBankRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object createBankDetails(HttpServletRequest httpServletRequest,
                                    @RequestParam(value = "clientId", required = false) String clientId,
                                    @Valid @RequestBody BankDetailsReqVo bankDetailsReqVo) {
        BankDetailsReqVo copy = gson.fromJson(gson.toJson(bankDetailsReqVo), BankDetailsReqVo.class);
        copy.setBankAccountProofFile("Base64 Redacted");
        log.info("Debug create bank details request: {}", gson.toJson(copy));
        return bankService.createBankDetails(HttpHeader.getApiKey(httpServletRequest), clientId, bankDetailsReqVo);
    }

    @Operation(summary = "Get User Bank Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BankDetailsResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "", method = RequestMethod.GET)
    @ResponseBody
    public Object getBankDetails(HttpServletRequest httpServletRequest,
                                 @RequestParam(value = "clientId", required = false) String clientId) {
        return bankService.getBankDetails(HttpHeader.getApiKey(httpServletRequest), clientId);
    }

    @Operation(summary = "Bank Details edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object bankDetailsUpdate(HttpServletRequest httpServletRequest,
                                    @Valid @RequestBody BankDetailsReqVo bankDetailsReqVo,
                                    @RequestParam(value = "clientId", required = false) String clientId,
                                    @RequestParam("bankId") Long bankId) {
        BankDetailsReqVo copy = gson.fromJson(gson.toJson(bankDetailsReqVo), BankDetailsReqVo.class);
        copy.setBankAccountProofFile("Base64 Redacted");
        log.info("Debug edit bank details request: {}", gson.toJson(copy));
        return bankService.updateBankDetails(HttpHeader.getApiKey(httpServletRequest), clientId, bankId, bankDetailsReqVo);
    }

    @Operation(summary = "Bank Details delete")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object bankDetailsDelete(HttpServletRequest httpServletRequest,
                                    @RequestParam(value = "clientId", required = false) String clientId,
                                    @RequestParam("bankId") Long bankId) {
        return bankService.bankDetailsDelete(HttpHeader.getApiKey(httpServletRequest), clientId, bankId);
    }
}
