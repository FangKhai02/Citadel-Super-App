package com.citadel.backend.controller;

import com.citadel.backend.service.AgentService;
import com.citadel.backend.service.ProductService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.Agency.AgencyAgentsRespVo;
import com.citadel.backend.vo.Agent.*;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.ClientPortfolioRespVo;
import com.citadel.backend.vo.Product.req.ProductPurchaseReqVo;
import com.citadel.backend.vo.Product.resp.ProductOrderSummaryRespVo;
import com.citadel.backend.vo.Transaction.TransactionRespVo;
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
@RequestMapping("api/agent")
@Tag(name = "agent-controller", description = "agent Controller")
public class AgentController extends BaseRestController {

    @Resource
    private AgentService agentService;

    @Resource
    private ProductService productService;

    @Operation(summary = "Get List of Agents by Agency Code")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgencyAgentsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agents", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentsByAgencyCode(@Parameter(in = ParameterIn.QUERY, name = "agencyId", description = "agencyId", required = true)
                                        @RequestParam("agencyId") String agencyId) {
        try {
            return agentService.getAgentsByAgencyId(agencyId);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Get Agent Profile")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentProfileRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentProfile(HttpServletRequest httpServletRequest) {
        return agentService.getAgentProfile(HttpHeader.getApiKey(httpServletRequest));
    }

    @Operation(summary = "Agent Profile Edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object agentProfileEdit(HttpServletRequest httpServletRequest, @RequestBody AgentProfileEditReqVo agentPersonalDetailsReq) {
        log.info("Debug agent profile edit: " + gson.toJson(agentPersonalDetailsReq));
        return agentService.agentProfileEdit(HttpHeader.getApiKey(httpServletRequest), agentPersonalDetailsReq);
    }

    @Operation(summary = "Agent Profile Image Add or Edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile-image/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object agentProfileImageUpdate(HttpServletRequest httpServletRequest, @RequestBody AgentProfileImageAddEditReqVo agentProfileImageAddEditReqVo) {
        return agentService.agentProfileImageUpdate(HttpHeader.getApiKey(httpServletRequest), agentProfileImageAddEditReqVo);
    }

    @Operation(summary = "Get Agent Clients List")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentClientRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/clients", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentClients(HttpServletRequest httpServletRequest,
                                  @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getAgentClients(HttpHeader.getApiKey(httpServletRequest), agentId);
    }

    @Operation(summary = "Get Client Portfolio under Agent")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPortfolioRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/client/portfolio", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentClientPortfolio(HttpServletRequest httpServletRequest,
                                          @RequestParam(value = "clientId") String clientId,
                                          @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getAgentClientPortfolio(HttpHeader.getApiKey(httpServletRequest), clientId, agentId);
    }

    @Operation(summary = "Get Client Transactions under Agent")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = TransactionRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/client/transactions", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentClientTransactions(HttpServletRequest httpServletRequest,
                                             @RequestParam(value = "clientId") String clientId,
                                             @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getAgentClientTransactions(HttpHeader.getApiKey(httpServletRequest), clientId, agentId);
    }

    @Operation(summary = "Get Secure Tag Status By Client")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentSecureTagRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/secure-tag/{clientId}", method = RequestMethod.GET)
    @ResponseBody
    public Object getClientSecureTagStatus(HttpServletRequest request, @PathVariable String clientId) {
        return agentService.getClientSecureTagStatusUpdate(HttpHeader.getApiKey(request), clientId);
    }

    @Operation(summary = "Create Client Secure Tag")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/secure-tag/{clientId}", method = RequestMethod.POST)
    @ResponseBody
    public Object createClientSecureTag(HttpServletRequest request, @PathVariable String clientId) {
        return agentService.createClientSecureTag(HttpHeader.getApiKey(request), clientId);
    }

    @Operation(summary = "Cancel Client Secure Tag")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/secure-tag/{clientId}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object cancelClientSecureTag(HttpServletRequest request, @PathVariable String clientId) {
        return agentService.cancelClientSecureTag(HttpHeader.getApiKey(request), clientId);
    }


    // Agent 4 pin

    @Operation(summary = "Agent 4-digit pin verification update or registration", description = "Pass only new PIN to register, Pass only old PIN to validate, Pass both old and new PIN to update")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/pin", method = RequestMethod.POST)
    @ResponseBody
    public Object agentPinUpdate(HttpServletRequest httpServletRequest, @Valid @RequestBody AgentPinReqVo agentPinReq) {
        log.info("Debug agent pin update or register request: " + gson.toJson(agentPinReq));
        return agentService.saveOrUpdateAgentPin(HttpHeader.getApiKey(httpServletRequest), agentPinReq);
    }

    @Operation(summary = "Purchase Product",
            description = """
                    These fields are required in the request in order to save the initial draft.
                    \n1.ProductPurchaseProductDetailsVo.productId;
                    \n2.ProductPurchaseProductDetailsVo.amount;
                    \n3.ProductPurchaseProductDetailsVo.dividend;
                    \n4.ProductPurchaseProductDetailsVo.investmentTenureMonth;
                    \n
                    \nIf an existing draft is being updated, referenceNumber is required.
                    \n
                    \nThe available product purchase amount WOULD be validated, every time the draft is saved.
                    \nThe beneficiary distribution WONT be validated, every time the draft is saved.
                    \nThe beneficiary distribution validation can be called separately by frontend and would be called by backend internally during the product purchase.
                    """
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductOrderSummaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/purchase", method = RequestMethod.POST)
    @ResponseBody
    public Object purchaseProduct(HttpServletRequest httpServletRequest,
                                  @RequestParam(name = "referenceNumber", required = false) String referenceNumber,
                                  @Valid @RequestBody ProductPurchaseReqVo productPurchaseReqVo) {
        log.info("Debug Agent product purchase request : {}", gson.toJson(productPurchaseReqVo));
        return productService.createProductOrder(HttpHeader.getApiKey(httpServletRequest), productPurchaseReqVo, referenceNumber);
    }

    @Operation(summary = "Get Pending Agent Agreement Signature")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentPendingSignatureRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/pending-agreement", method = RequestMethod.GET)
    @ResponseBody
    public Object getPendingAgreementSignature(HttpServletRequest httpServletRequest) {
        return agentService.getPendingAgreementSignature(HttpHeader.getApiKey(httpServletRequest));
    }

    @Operation(summary = "Get Agent Total Sales")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentTotalSalesRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/personal-sales/total-sales", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentTotalSales(HttpServletRequest httpServletRequest,
                                     @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getAgentTotalSales(HttpHeader.getApiKey(httpServletRequest), agentId);
    }

    @Operation(summary = "Get Agent Sales Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentPersonalSalesDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/personal-sales/sales-details", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentSalesDetails(HttpServletRequest httpServletRequest,
                                       @RequestParam(value = "agentId", required = false) String agentId,
                                       @RequestParam(value = "month", required = false) Integer month,
                                       @RequestParam(value = "year", required = false) Integer year) {
        return agentService.getAgentPersonalSales(HttpHeader.getApiKey(httpServletRequest), agentId, month, year);
    }

    @Operation(summary = "Get Agent Earning Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentEarningRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/earning", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentEarnings(HttpServletRequest httpServletRequest,
                                   @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getAgentEarnings(HttpHeader.getApiKey(httpServletRequest), agentId);
    }

    @Operation(summary = "Get Agent Commission Monthly Report")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentCommissionMonthlyReportRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/commission-report", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentCommissionMonthlyReport(HttpServletRequest httpServletRequest,
                                                  @RequestParam(value = "agentId", required = false) String agentId,
                                                  @RequestParam(value = "month", required = false) Integer month,
                                                  @RequestParam(value = "year", required = false) Integer year) {
        return agentService.getAgentCommissionMonthlyReport(HttpHeader.getApiKey(httpServletRequest), agentId, month, year);
    }

    @Operation(summary = "Get Agent DownLine Commission Earnings")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentDownLineCommissionRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/commission-overriding", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentDownLineCommission(HttpServletRequest httpServletRequest,
                                             @RequestParam(value = "month", required = false) Integer month,
                                             @RequestParam(value = "year", required = false) Integer year) {
        return agentService.getAgentOverridingCommission(HttpHeader.getApiKey(httpServletRequest), month, year);
    }

    @Operation(summary = "Get Agent Downline Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentDownLineRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/downline", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentDownLine(HttpServletRequest httpServletRequest,
                                   @RequestParam(value = "agentId", required = false) String agentId) {
        return agentService.getDownLineDetails(HttpHeader.getApiKey(httpServletRequest), agentId);
    }

    @Operation(summary = "Get Agent Downline List")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgentDownLineListRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/downline/list", method = RequestMethod.GET)
    @ResponseBody
    public Object getAgentDownLineList(HttpServletRequest httpServletRequest) {
        return agentService.getDownLineList(HttpHeader.getApiKey(httpServletRequest));
    }
}
