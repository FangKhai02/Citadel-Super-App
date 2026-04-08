package com.citadel.backend.controller;

import com.citadel.backend.service.PdfService;
import com.citadel.backend.service.ProductService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.Agreement.*;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.Agreement.OnboardingAgreementReqVo;
import com.citadel.backend.vo.Agreement.AgreementRespVo;
import io.swagger.v3.oas.annotations.Hidden;
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
@RequestMapping("api/agreement")
@Tag(name = "agreement-controller", description = "Agreement Controller")
public class AgreementController extends BaseRestController {
    @Resource
    private PdfService pdfService;
    @Resource
    private ProductService productService;


    @Operation(summary = "Get Onboarding Agreement", description = "userType: CLIENT, AGENT, CORPORATE_CLIENT")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/onboarding-agreement", method = RequestMethod.POST)
    @ResponseBody
    public Object clientOnboardingAgreement(@Valid @RequestBody OnboardingAgreementReqVo request,
                                            @RequestParam(value = "userType") UserType userType) {
        try {
            return pdfService.getPrefilledOnboardingAgreement(userType, request);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Get Trust Fund Agreement", description = "Used by both client and agent. Agent wont able to get the agreement if the client haven't signed yet")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/trust-fund-agreement", method = RequestMethod.GET)
    @ResponseBody
    public Object getTrustFundAgreement(
            HttpServletRequest httpServletRequest,
            @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return productService.getTrustFundAgreement(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber);
        } catch (Exception ex) {
            log.error("Error in getTrustFundAgreement", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "Verify Witness Eligibility to Submit Trust Fund Agreement", description = "Used by both client and agent.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/trust-fund-agreement/verification", method = RequestMethod.POST)
    @ResponseBody
    public Object submitTrustFundAgreementPreVerification(
            HttpServletRequest httpServletRequest,
            @Valid @RequestBody TrustFundAgreementReqVo req,
            @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return productService.submitTrustFundAgreementPreVerification(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber, req);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Submit Trust Fund Agreement After Signing", description = "Used by both client and agent.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/trust-fund-agreement", method = RequestMethod.POST)
    @ResponseBody
    public Object submitTrustFundAgreement(
            HttpServletRequest httpServletRequest,
            @Valid @RequestBody TrustFundAgreementReqVo req,
            @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            TrustFundAgreementReqVo copy = gson.fromJson(gson.toJson(req), TrustFundAgreementReqVo.class);
            copy.setDigitalSignature("Signature Redacted");
            log.info("Trust Fund Agreement Request: {}", gson.toJson(copy));
            return productService.submitTrustFundAgreement(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber, req);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }


    // Get Withdrawal Agreement
    @Operation(summary = "Get Withdrawal Agreement", description = "Used by both client and agent. Agent wont able to get the agreement if the client haven't signed yet")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/early-redemption-agreement", method = RequestMethod.GET)
    @ResponseBody
    public Object getWithdrawalAgreement(HttpServletRequest httpServletRequest,
                                        @RequestParam(value = "redemptionReferenceNumber") String redemptionReferenceNumber) {
        try {
            return productService.getEarlyRedemptionAgreement(HttpHeader.getApiKey(httpServletRequest), redemptionReferenceNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }


    // Submit Withdrawal Agreement After Signing
    @Operation(summary = "Submit Withdrawal Agreement After Signing", description = "Used by both client and agent.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/early-redemption-agreement", method = RequestMethod.POST)
    @ResponseBody
    public Object submitWithdrawalAgreement(HttpServletRequest httpServletRequest,
                                            @Valid @RequestBody WithdrawalAgreementReqVo req,
                                            @RequestParam(value = "redemptionReferenceNumber") String redemptionReferenceNumber) {
        try {
            return productService.submitEarlyRedemptionAgreement(HttpHeader.getApiKey(httpServletRequest), redemptionReferenceNumber, req);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Get Second Signee Agreement Link", description = "Generate link for second signee to sign corporate client agreements")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/second-signee-agreement-link", method = RequestMethod.GET)
    @ResponseBody
    public Object getSecondSigneeAgreementLink(
            HttpServletRequest httpServletRequest,
            @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return productService.getSecondSigneeAgreementLink(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber);
        } catch (Exception ex) {
            log.error("Error in getSecondSigneeAgreementLink", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "Get Second Signee Agreement HTML", description = "Get the second signee agreement as HTML content using unique identifier")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = SecondSigneeAgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/second-signee-agreement", method = RequestMethod.GET)
    @ResponseBody
    public Object getSecondSigneeAgreementHtml(@RequestParam(value = "uniqueIdentifier") String uniqueIdentifier) {
        try {
            return productService.getSecondSigneeAgreementHtml(uniqueIdentifier);
        } catch (Exception ex) {
            log.error("Error in getSecondSigneeAgreementHtml", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "Submit Second Signee Agreement", description = "Submit the second signee agreement with signature and details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = SecondSigneeAgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/second-signee-agreement", method = RequestMethod.POST)
    @ResponseBody
    public Object submitSecondSigneeAgreement(@Valid @RequestBody ClientTwoSignatureReqVo request) {
        try {
            return productService.submitSecondSigneeAgreement(request);
        } catch (Exception ex) {
            log.error("Error in submitSecondSigneeAgreement", ex);
            return getErrorException(ex);
        }
    }
}
