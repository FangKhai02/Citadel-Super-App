package com.citadel.backend.controller;

import com.citadel.backend.service.ClientService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BankDetails.BankDetailsReqVo;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.*;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryCreateReqVo;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryRespVo;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryUpdateReqVo;
import com.citadel.backend.vo.Client.Guardian.IndividualGuardianCreateReqVo;
import com.citadel.backend.vo.Client.Guardian.BeneficiaryGuardianRelationshipUpdateReqVo;
import com.citadel.backend.vo.Client.Guardian.IndividualGuardianUpdateReqVo;
import com.citadel.backend.vo.Enum.SecureTagAction;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
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

import java.util.Optional;

@Controller
@RequestMapping("api/client")
@Tag(name = "client-controller", description = "Client Controller")
public class ClientController extends BaseRestController {

    @Resource
    private ClientService clientService;

    @Operation(summary = "Client Profile Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientProfileRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    @ResponseBody
    public Object clientProfile(HttpServletRequest httpServletRequest,
                                @RequestParam(value = "clientId", required = false) String clientId) {
        return clientService.getClientProfile(HttpHeader.getApiKey(httpServletRequest), clientId);
    }

    @Operation(summary = "Client 4-digit pin verification update or registration", description = "Pass only new PIN to register, Pass only old PIN to validate, Pass both old and new PIN to update")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/pin", method = RequestMethod.POST)
    @ResponseBody
    public Object clientPinUpdate(HttpServletRequest httpServletRequest, @Valid @RequestBody ClientPinReqVo clientPinReq) {
        log.info("Debug client pin update or register request: " + gson.toJson(clientPinReq));
        return clientService.saveOrUpdateClientPin(HttpHeader.getApiKey(httpServletRequest), clientPinReq);
    }

    @Operation(summary = "Create New Beneficiary Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = IndividualBeneficiaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary", method = RequestMethod.POST)
    @ResponseBody
    public Object createBeneficiary(HttpServletRequest httpServletRequest,
                                    @RequestParam(value = "clientId", required = false) String clientId,
                                    @Valid @RequestBody IndividualBeneficiaryCreateReqVo beneficiaryDetails) {
        IndividualBeneficiaryCreateReqVo copy = gson.fromJson(gson.toJson(beneficiaryDetails), IndividualBeneficiaryCreateReqVo.class);
        copy.setIdentityCardFrontImage("Base64 Redacted");
        if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
            copy.setIdentityCardBackImage("Base64 Redacted");
        }
        log.info("Debug create beneficiary request: " + gson.toJson(copy));
        return clientService.createBeneficiary(HttpHeader.getApiKey(httpServletRequest), clientId, beneficiaryDetails);
    }

    @Operation(summary = "Client profile edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object clientProfileUpdate(HttpServletRequest httpServletRequest,
                                      @RequestParam(value = "clientId", required = false) String clientId,
                                      @Valid @RequestBody ClientProfileEditReqVo clientProfileEditVo) {

        ClientProfileEditReqVo copy = gson.fromJson(gson.toJson(clientProfileEditVo), ClientProfileEditReqVo.class);
        copy.getCorrespondingAddress().setCorrespondingAddressProofKey("Base64 Redacted");
        log.info("Debug client profile edit request: " + gson.toJson(copy));

        return clientService.updateClientProfile(HttpHeader.getApiKey(httpServletRequest), clientId, clientProfileEditVo);
    }

    @Operation(summary = "Client profile image add or edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile-image/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object clientProfileImageUpdate(HttpServletRequest httpServletRequest, @Valid @RequestBody ClientProfileImageAddEditReqVo clientProfileImageAddEditReqVo) {
        return clientService.updateClientProfileImage(HttpHeader.getApiKey(httpServletRequest), clientProfileImageAddEditReqVo);
    }

    @Operation(summary = "Get a list of Beneficiaries with their respective Guardians")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientBeneficiaryGuardianRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiaries", method = RequestMethod.GET)
    @ResponseBody
    public Object getBeneficiariesGuardians(HttpServletRequest request,
                                            @RequestParam(value = "clientId", required = false) String clientId) {
        return clientService.getBeneficiariesGuardians(HttpHeader.getApiKey(request), clientId);
    }

    @Operation(summary = "Individual Beneficiary edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = IndividualBeneficiaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object individualBeneficiaryUpdate(HttpServletRequest httpServletRequest,
                                              @Valid @RequestBody IndividualBeneficiaryUpdateReqVo individualBeneficiaryEditVo,
                                              @RequestParam(value = "clientId", required = false) String clientId,
                                              @RequestParam(value = "beneficiaryId") Long beneficiaryId) {
        log.info("Debug individual beneficiary edit request: " + gson.toJson(individualBeneficiaryEditVo));
        return clientService.individualBeneficiaryUpdate(HttpHeader.getApiKey(httpServletRequest), clientId, beneficiaryId, individualBeneficiaryEditVo);
    }

    @Operation(summary = "Individual Beneficiary delete")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object individualBeneficiaryDelete(HttpServletRequest httpServletRequest,
                                              @RequestParam(value = "clientId", required = false) String clientId,
                                              @RequestParam(value = "beneficiaryId") Long beneficiaryId) {
        return clientService.individualBeneficiaryDelete(HttpHeader.getApiKey(httpServletRequest), clientId, beneficiaryId);
    }

    @Operation(summary = "Create New Guardian Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian", method = RequestMethod.POST)
    @ResponseBody
    public Object createGuardian(HttpServletRequest httpServletRequest,
                                 @RequestParam(value = "clientId", required = false) String clientId,
                                 @Valid @RequestBody IndividualGuardianCreateReqVo guardianDetails) {
        IndividualGuardianCreateReqVo copy = gson.fromJson(gson.toJson(guardianDetails), IndividualGuardianCreateReqVo.class);
        copy.setIdentityCardFrontImage("Base64 Redacted");
        if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
            copy.setIdentityCardBackImage("Base64 Redacted");
        }
        log.info("Debug create guardian request: " + gson.toJson(copy));
        return clientService.createGuardian(HttpHeader.getApiKey(httpServletRequest), clientId, guardianDetails);
    }

    @Operation(summary = "Beneficiary Guardian Edit")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object individualGuardianUpdate(HttpServletRequest httpServletRequest,
                                           @Valid @RequestBody IndividualGuardianUpdateReqVo individualGuardianEditVo,
                                           @RequestParam(value = "clientId", required = false) String clientId,
                                           @RequestParam(value = "guardianId") Long guardianId) {
        log.info("Debug individual guardian edit request: " + gson.toJson(individualGuardianEditVo));
        return clientService.individualGuardianUpdate(HttpHeader.getApiKey(httpServletRequest), clientId, guardianId, individualGuardianEditVo);
    }

    @Operation(summary = "Individual Guardian delete")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object individualGuardianDelete(HttpServletRequest httpServletRequest,
                                           @RequestParam(value = "clientId", required = false) String clientId,
                                           @RequestParam(value = "guardianId") Long guardianId) {
        return clientService.individualGuardianDelete(HttpHeader.getApiKey(httpServletRequest), clientId, guardianId);
    }

    @Operation(summary = "Get Client portfolio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPortfolioRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/portfolio", method = RequestMethod.GET)
    @ResponseBody
    public Object getClientPortfolio(HttpServletRequest request) {
        return clientService.getClientPortfolioByClient(HttpHeader.getApiKey(request));
    }

    @Operation(summary = "Get Client Portfolio Product Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPortfolioProductDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/portfolio/product", method = RequestMethod.GET)
    @ResponseBody
    public Object getClientPortfolioProductDetails(HttpServletRequest request,
                                                   @RequestParam(value = "clientId", required = false) String clientId,
                                                   @RequestParam(value = "referenceNumber") String referenceNumber) {
        return clientService.getClientPortfolioProductDetails(HttpHeader.getApiKey(request), clientId, referenceNumber);
    }

    @Operation(summary = "Get Client Secure Tag")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientSecureTagRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/secure-tag", method = RequestMethod.GET)
    @ResponseBody
    public Object getClientSecureTag(HttpServletRequest request) {
        return clientService.getClientSecureTag(HttpHeader.getApiKey(request));
    }

    @Operation(summary = "Approve or Reject Secure Tag")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/secure-tag/consent", method = RequestMethod.GET)
    @ResponseBody
    public Object approveRejectSecureTag(HttpServletRequest request, @RequestParam(value = "action") SecureTagAction action) {
        return clientService.approveRejectSecureTagUpdate(HttpHeader.getApiKey(request), action);
    }

    @Operation(summary = "Get a Beneficiary using Id with Their Respective Guardians")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientBeneficiaryGuardianRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/view", method = RequestMethod.GET)
    @ResponseBody
    public Object getBeneficiariesGuardiansById(HttpServletRequest request, @RequestParam(value = "beneficiaryId") Long beneficiaryId) {
        return clientService.getBeneficiariesGuardiansById(HttpHeader.getApiKey(request), beneficiaryId);
    }

    @Operation(summary = "Edit Client Pep Info")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPepRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/pep/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object editClientPep(HttpServletRequest httpServletRequest,
                                @RequestParam(value = "clientId", required = false) String clientId,
                                @Valid @RequestBody PepDeclarationVo pepEditReq) {
        PepDeclarationVo copy = gson.fromJson(gson.toJson(pepEditReq), PepDeclarationVo.class);
        if (copy.getIsPep()) {
            Optional.ofNullable(copy.getPepDeclarationOptions())
                    .ifPresent(options -> options.setSupportingDocument("Base64 Redacted"));
        }
        log.info("Debug edit client pep request: " + gson.toJson(copy));
        return clientService.editClientPep(HttpHeader.getApiKey(httpServletRequest), clientId, pepEditReq);
    }

    @Operation(summary = "Create or Edit Beneficiary Guardian Relationship ")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary-guardian-relationship", method = RequestMethod.POST)
    @ResponseBody
    public Object createOrEditBeneficiaryGuardianRelationship(HttpServletRequest httpServletRequest,
                                                              @RequestParam(value = "clientId", required = false) String clientId,
                                                              @Valid @RequestBody BeneficiaryGuardianRelationshipUpdateReqVo beneficiaryGuardianRelationshipUpdateReqVo) {
        return clientService.createOrEditBeneficiaryGuardianRelationship(HttpHeader.getApiKey(httpServletRequest), clientId, beneficiaryGuardianRelationshipUpdateReqVo);
    }

    @Operation(summary = "Get Client Transactions")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = TransactionRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/transactions", method = RequestMethod.GET)
    @ResponseBody
    public Object getClientTransactions(HttpServletRequest request) {
        return clientService.getClientTransactions(HttpHeader.getApiKey(request));
    }
}
