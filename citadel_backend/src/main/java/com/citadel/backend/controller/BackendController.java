package com.citadel.backend.controller;

import com.citadel.backend.service.BackendService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.Agreement.AgreementRespVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Product.req.CmsAdminPOStatusUpdateReqVo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("api/backend")
@Tag(name = "backend-controller", description = "Backend Controller")
public class BackendController extends BaseRestController {

    @Resource
    private BackendService backendService;

    @Operation(summary = "[CMS] Product Order approval status update")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-order/approval", method = RequestMethod.POST)
    @ResponseBody
    public Object cmsUpdateProductOrderApproverStatus(@RequestParam(name = "referenceNumber") String referenceNumber,
                                                      @Valid @RequestBody CmsAdminPOStatusUpdateReqVo approvalReqVo) {
        try {
            log.info("Debug CMS Product order approver status update referenceNumber : {} request : {}", referenceNumber, gson.toJson(approvalReqVo));
            return backendService.cmsAdminUpdateProductOrderStatus(referenceNumber, approvalReqVo);
        } catch (Exception ex) {
            log.error("Error in cmsUpdateProductOrderApproverStatus", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Dividend Bank File Generation Request")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/dividend/generate-bank-file", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsGenerateDividendBankFile(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Dividend Bank File Generation Request referenceNumber : {}", id);
            return backendService.cmsGenerateDividendBankFile(id);
        } catch (Exception ex) {
            log.error("Error in cmsGenerateDividendBankFile", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Commission Bank File Generation Request")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/commission/generate-bank-file", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsGenerateCommissionBankFile(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Commission Bank File Generation Request referenceNumber : {}", id);
            return backendService.cmsGenerateCommissionBankFile(id);
        } catch (Exception ex) {
            log.error("Error in cmsGenerateCommissionBankFile", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Dividend Bank Payment Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/dividend/update-dividend-payment", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateDividendBankPaymentDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Dividend Bank Payment Details Request for Product Dividend History Id : {}", id);
            return backendService.cmsUpdateDividendBankPaymentDetails(id);
        } catch (Exception ex) {
            log.error("Error in cmsUpdateDividendBankPaymentDetails", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Dividend Excel Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/dividend/update-dividend-excel", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateDividendExcelDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Dividend Excel Details Request Id : {}", id);
            return backendService.cmsUpdateDividendExcelDetails(id);
        } catch (Exception ex) {
            log.error("Error in cmsUpdateDividendExcelDetails", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Commission Bank Payment Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/commission/update-commission-payment", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateCommissionBankPaymentDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Commission Bank Payment Details Request for Product Commission History Id : {}", id);
            return backendService.cmsUpdateCommissionBankPaymentDetails(id);
        } catch (Exception ex) {
            log.error("Error in cmsUpdateCommissionBankPaymentDetails", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Commission Excel Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/commission/update-commission-excel", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateCommissionExcelDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Commission Excel Details Request Id : {}", id);
            return backendService.cmsUpdateCommissionExcelDetails(id);
        } catch (Exception ex) {
            log.error("Error in cmsUpdateCommissionExcelDetails", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Activate Reallocation or Rollover")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-order/activate/reallocation-rollover-redemption", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsActivateReallocationRolloverRedemption(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Activate Reallocation or Rollover Request for Product Order Id : {}", id);
            backendService.cmsUpdateReallocationRollover(id);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in cmsActivateReallocationRolloverRedemption", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Redemption Bank File Generation Request")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-redemption/generate-bank-file", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsGenerateRedemptionBankFile(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Redemption Bank File Generation Request id : {}", id);
            return backendService.cmsGenerateRedemptionBankFile(id);
        } catch (Exception ex) {
            log.error("Error in cmsGenerateRedemptionBankFile", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Redemption Bank Payment Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-redemption/update-redemption-payment", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateRedemptionBankPaymentDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Redemption Bank Payment Details Request for Product Redemption History Id : {}", id);
            return backendService.cmsUpdateRedemptionBankPaymentDetails(id);
        } catch (Exception ex) {
            log.error("Error in {} ", getFunctionName(), ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Early Redemption Bank File Generation Request")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-early-redemption/generate-bank-file", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsGenerateEarlyRedemptionBankFile(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Early Redemption Bank File Generation Request id : {}", id);
            return backendService.cmsGenerateEarlyRedemptionBankFile(id);
        } catch (Exception ex) {
            log.error("Error in : {} ", getFunctionName(), ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Update Early Redemption Bank Payment Record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/product-early-redemption/update-early-redemption-payment", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsUpdateEarlyRedemptionBankPaymentDetails(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Update Early Redemption Bank Payment Details Request for Product Early Redemption History Id : {}", id);
            return backendService.cmsUpdateEarlyRedemptionBankPaymentDetails(id);
        } catch (Exception ex) {
            log.error("Error in : {} ", getFunctionName(), ex);
            return getErrorException(ex);
        }
    }

    //-------------------------------Fixed Dividend CRON API------------------------------
    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Dividend Calculation Fixed Monthly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/fixed/monthly", method = RequestMethod.GET)
    @ResponseBody
    public void cronFixedMonthlyDividendCalculation() {
        try {
            backendService.cronProcessFixedMonthlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st day of every 3 months */
    @Operation(summary = "[CRON] Dividend Calculation Fixed Quarterly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/fixed/quarterly", method = RequestMethod.GET)
    @ResponseBody
    public void cronFixedQuarterlyDividendCalculation() {
        try {
            backendService.cronProcessFixedQuarterlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st day of each year */
    @Operation(summary = "[CRON] Dividend Calculation Fixed Annually")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/fixed/annually", method = RequestMethod.GET)
    @ResponseBody
    public void cronFixedAnnuallyDividendCalculation() {
        try {
            backendService.cronProcessFixedYearlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st,2nd and 16th of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Final Fixed Dividend Calculation")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/final", method = RequestMethod.GET)
    @ResponseBody
    public void cronProcessFinalFixedDividend() {
        try {
            backendService.cronProcessFinalFixedDividend();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //-------------------------------Flexible Dividend CRON API------------------------------
    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Dividend Calculation Flexible Monthly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/flexible/monthly", method = RequestMethod.GET)
    @ResponseBody
    public void cronFlexibleMonthlyDividendCalculation() {
        try {
            backendService.cronProcessFlexibleMonthlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Dividend Calculation Flexible Quarterly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/flexible/quarterly", method = RequestMethod.GET)
    @ResponseBody
    public void cronFlexibleQuarterlyDividendCalculation() {
        try {
            backendService.cronProcessFlexibleQuarterlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Dividend Calculation Flexible Annually")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/dividend/flexible/annually", method = RequestMethod.GET)
    @ResponseBody
    public void cronFlexibleAnnuallyDividendCalculation() {
        try {
            backendService.cronProcessFlexibleYearlyDividendCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Operation(summary = "[CRON] Generate Commission Excel File")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/commission/generate-excel", method = RequestMethod.GET)
    @ResponseBody
    public void cronGenerateCommissionExcelFile() {
        try {
            backendService.cronGenerateCommissionExcelFile();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //-------------------------------Agent Commission CRON API------------------------------
    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Agent Commission Calculation Monthly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/commission/agent-monthly", method = RequestMethod.GET)
    @ResponseBody
    public void cronAgentMonthlyCommissionCalculation() {
        try {
            backendService.cronProcessAgentMonthlyCommissionCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Agent Commission Calculation Yearly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/commission/agent-yearly", method = RequestMethod.GET)
    @ResponseBody
    public void cronAgentYearlyCommissionCalculation() {
        try {
            backendService.cronProcessAgentYearlyCommissionCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    //-------------------------------Agency Commission CRON API------------------------------
    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Agency Commission Calculation Monthly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/commission/agency-monthly", method = RequestMethod.GET)
    @ResponseBody
    public void cronAgencyMonthlyCommissionCalculation() {
        try {
            backendService.cronProcessAgencyMonthlyCommissionCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /* CRON trigger 1st,16th and last day of each month or depending on agreement date configuration */
    @Operation(summary = "[CRON] Agency Commission Calculation Monthly")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/commission/agency-yearly", method = RequestMethod.GET)
    @ResponseBody
    public void cronAgencyyearlyCommissionCalculation() {
        try {
            backendService.cronProcessAgencyYearlyCommissionCalculation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Operation(summary = "[CMS] Generate PDF Template")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgreementRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/pdfTemplate", method = RequestMethod.POST)
    @ResponseBody
    public Object cmsGeneratePdfTemplate(
            @RequestParam(name = "id") Long id,
            @RequestParam(name = "content", required = false) String content) {
        try {
            log.info("Debug CMS Generate Pdf for Product Agreement Id : {}", id);
            return backendService.cmsGeneratePdfTemplate(id, content);
        } catch (Exception ex) {
            log.error("Error in cmsGeneratePdfTemplate", ex);
            return getErrorException(ex);
        }
    }

    @Operation(summary = "[CMS] Generate Unsigned Product Agreement")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cms/unsigned-product-agreement/generate", method = RequestMethod.GET)
    @ResponseBody
    public Object cmsGenerateUnsignedProductAgreement(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug CMS Generate Unsigned Product Agreement for Product Order Id : {}", id);
            return backendService.cmsGenerateUnsignedProductAgreement(id);
        } catch (Exception ex) {
            log.error("Error in cmsGenerateUnsignedProductAgreement", ex);
            return getErrorException(ex);
        }
    }

    /* CRON trigger every day or every business day */
    @Operation(summary = "[CRON] Physical Trust Deed Reminder", description = "Every day or every business day")
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/reminder/physical-trust-deed", method = RequestMethod.GET)
    @ResponseBody
    public void cronPhysicalTrustDeedReminder() {
        try {
            backendService.cronPhysicalTrustDeedReminder(null);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Operation(summary = "[INTERNAL] Update Agreement file content to CMS")
    @CrossOrigin("*")
    @RequestMapping(value = "/internal/agreement/update-file-content", method = RequestMethod.GET)
    @ResponseBody
    public Object internalUpdateAgreementFileContentToCms() {
        return backendService.updateAgreementTemplatesToCMS();
    }

    @Operation(summary = "[INTERNAL] Regenerate Product Order Agreements")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/internal/product-order/regenerate-agreements", method = RequestMethod.GET)
    @ResponseBody
    public Object internalRegenerateProductOrderAgreements(@RequestParam(name = "id") Long id) {
        try {
            log.info("Debug INTERNAL Regenerate Product Order Agreements for Product Order Id: {}", id);
            return backendService.regenerateProductOrderAgreements(id);
        } catch (Exception ex) {
            log.error("Error in internalRegenerateProductOrderAgreements", ex);
            return getErrorException(ex);
        }
    }
}