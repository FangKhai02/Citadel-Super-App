package com.citadel.backend.controller;

import com.citadel.backend.service.ValidatorService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Corporate.*;
import com.citadel.backend.vo.Corporate.ShareHolder.CorporateShareholderReqVo;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
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
@RequestMapping("api/validation")
@Tag(name = "validation-controller", description = "Validation Controller")
public class ValidationController extends BaseRestController {

    @Resource
    private ValidatorService validatorService;

    @Operation(summary = "Pep details validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/pep", method = RequestMethod.POST)
    @ResponseBody
    public Object pepValidator(@Valid @RequestBody PepDeclarationVo pepDeclarationVo) {
        PepDeclarationVo copy = gson.fromJson(gson.toJson(pepDeclarationVo), PepDeclarationVo.class);
        if (copy.getIsPep()) {
            copy.getPepDeclarationOptions().setSupportingDocument("Base64 Redacted");
        }
        log.info("Debug pep validation request: " + gson.toJson(copy));
        return validatorService.pepValidator(pepDeclarationVo);
    }

    @Operation(summary = "Employment details validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/employment-details", method = RequestMethod.POST)
    @ResponseBody
    public Object employmentDetailsValidator(@Valid @RequestBody EmploymentDetailsVo employmentDetailsVo) {
        log.info("Debug employment details validation request: " + gson.toJson(employmentDetailsVo));
        return validatorService.employmentDetailsValidator(employmentDetailsVo);
    }

    @Operation(summary = "Bank details validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/bank-details", method = RequestMethod.POST)
    @ResponseBody
    public Object bankDetailsValidator(@Valid @RequestBody BankDetailsReqVo bankDetailsReqVo) {
        BankDetailsReqVo copy = gson.fromJson(gson.toJson(bankDetailsReqVo), BankDetailsReqVo.class);
        if (StringUtil.isNotEmpty(copy.getBankAccountProofFile())) {
            copy.setBankAccountProofFile("Base64 Redacted");
        }
        log.info("Debug bank details validation request: " + gson.toJson(copy));
        return validatorService.bankDetailsValidator(bankDetailsReqVo);
    }

    //-----------------------------Corporate Sign Up Validation-----------------------------
    @Operation(summary = "[Corporate sign up checkpoint 1] Corporate details validator (validate corporate client pep before this)")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/corporate/corporate-details", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateDetailsValidator(@Valid @RequestBody CorporateDetailsReqVo corporateDetailsReqVo) {
        log.info("Debug corporate client corporate details validation request: " + gson.toJson(corporateDetailsReqVo));
        return validatorService.corporateCompanyDetailsValidator(corporateDetailsReqVo);
    }

    @Operation(summary = "[Corporate sign up checkpoint 2] Corporate shareholder details validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/corporate/shareholder-details", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateShareHolderDetailsValidator(HttpServletRequest httpServletRequest,
                                                       @RequestParam(name = "referenceNumber") String referenceNumber,
                                                       @Valid @RequestBody CorporateShareholderReqVo corporateShareHolderReqVo) {
        CorporateShareholderReqVo copy = gson.fromJson(gson.toJson(corporateShareHolderReqVo), CorporateShareholderReqVo.class);
        copy.setIdentityCardFrontImage("Base64 Redacted");
        if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
            copy.setIdentityCardBackImage("Base64 Redacted");
        }
        if (copy.getPepDeclaration() != null && copy.getPepDeclaration().getIsPep()) {
            copy.getPepDeclaration().getPepDeclarationOptions().setSupportingDocument("Base64 Redacted");
        }
        log.info("Debug corporate client shareholder details validation request: " + gson.toJson(copy));
        return validatorService.corporateShareholderDetailsValidator(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateShareHolderReqVo);
    }

    //-----------------------------Corporate Edit Validation-----------------------------
    @Operation(summary = "Corporate profile corporate details edit validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/corporate/corporate-details/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateDetailsEditValidator(@Valid @RequestBody CorporateDetailsReqVo corporateDetailsReqVo) {
        log.info("Debug corporate profile corporate details edit validation request: " + gson.toJson(corporateDetailsReqVo));
        return validatorService.corporateDetailsEditValidator(corporateDetailsReqVo);
    }

    @Operation(summary = "Agent RecruitManger Code Validator")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent/recruit-manager-code", method = RequestMethod.POST)
    @ResponseBody
    public Object agentRecruitManagerCodeValidator(@RequestParam(name = "agencyId") String agencyId,
                                                   @RequestParam(name = "recruitManagerCode") String recruitManagerCode) {
        return validatorService.agentRecruitMangerValidator(agencyId, recruitManagerCode);
    }
}
