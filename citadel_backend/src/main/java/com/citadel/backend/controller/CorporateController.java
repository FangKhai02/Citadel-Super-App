package com.citadel.backend.controller;

import com.citadel.backend.service.CorporateService;
import com.citadel.backend.service.ProductService;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.ClientPortfolioProductDetailsRespVo;
import com.citadel.backend.vo.Client.ClientPortfolioRespVo;
import com.citadel.backend.vo.Corporate.*;
import com.citadel.backend.vo.Corporate.Bank.CorporateBankDetailsEditReqVo;
import com.citadel.backend.vo.Corporate.Bank.CorporateBankDetailsListRespVo;
import com.citadel.backend.vo.Corporate.Bank.CorporateBankDetailsReqVo;
import com.citadel.backend.vo.Corporate.Bank.CorporateBankDetailsRespVo;
import com.citadel.backend.vo.Corporate.Beneficiary.*;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsReqVo;
import com.citadel.backend.vo.Corporate.Documents.CorporateDocumentsRespVo;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianCreationReqVo;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianRespVo;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardianUpdateReqVo;
import com.citadel.backend.vo.Corporate.Guardian.CorporateGuardiansRespVo;
import com.citadel.backend.vo.Corporate.ShareHolder.*;
import com.citadel.backend.vo.Product.req.ProductPurchaseReqVo;
import com.citadel.backend.vo.Product.resp.ProductOrderSummaryRespVo;
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
import com.citadel.backend.utils.BaseRestController;

import java.util.Optional;

@Controller
@RequestMapping("api/corporate")
@Tag(name = "corporate-controller", description = "Corporate Controller")
public class CorporateController extends BaseRestController {
    @Resource
    private CorporateService corporateService;
    @Resource
    private ProductService productService;

    // -----------------------------Sign Up-----------------------------
    @Operation(summary = "Corporate Client Sign Up",
            description = """
                    Creates or updates a corporate client registration. Supports draft mode for incomplete submissions and automatic transition to IN_REVIEW status when all required information is provided.

                    Errors:
                    - api.duplicate.request — when a concurrent sign-up request is already in progress for this API key
                    - api.corporate.account.update.not.allowed — when attempting to update a corporate client already in APPROVED or IN_REVIEW status
                    - api.company.registration.number.has.taken — when registration number already exists for a non-draft, non-rejected corporate
                    - api.missing.required.details — when corporate details validation fails (invalid mobile number, email, or missing address fields)
                    - api.client.not.found — when provided clientId does not match any client for the agent
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.agent.profile.terminated — when API key belongs to a terminated agent
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateProfileRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "sign-up", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateClientSignUp(HttpServletRequest httpServletRequest,
                                        @RequestParam(name = "clientId", required = false) String clientId,
                                        @RequestParam(name = "referenceNumber", required = false) String referenceNumber,
                                        @RequestParam(name = "isDraft") Boolean isDraft,
                                        @Valid @RequestBody CorporateClientSignUpReqVo corporateClientSignUpReq) {
        CorporateClientSignUpReqVo copy = gson.fromJson(gson.toJson(corporateClientSignUpReq), CorporateClientSignUpReqVo.class);
        copy.setDigitalSignature("Base64 Redacted");
        log.info("Debug corporate client sign up request: isDraft{},requestBody : {}", isDraft, gson.toJson(copy));
        return corporateService.corporateClientSignUp(HttpHeader.getApiKey(httpServletRequest), clientId, referenceNumber, isDraft, corporateClientSignUpReq);
    }

    // -----------------------------Sign Up Corporate Documents-----------------------------
    @Operation(summary = "Get Corporate Documents",
            description = """
                    Retrieves all uploaded corporate documents for a specific corporate client by reference number.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist or corporate details not initialized
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateDocumentsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "documents", method = RequestMethod.GET)
    @ResponseBody
    public Object getCorporateDocuments(HttpServletRequest httpServletRequest,
                                        @RequestParam(name = "referenceNumber") String referenceNumber) {
        return corporateService.getCorporateDocuments(HttpHeader.getApiKey(httpServletRequest), referenceNumber);
    }

    @Operation(summary = "Save or Update Corporate Documents",
            description = """
                    Saves or updates corporate documents for a corporate client. Supports file upload via Base64 encoding and manages document lifecycle (create, update, delete).

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist or corporate details not initialized
                    - api.corporate.account.update.not.allowed — when attempting to update documents for a corporate client already in APPROVED or IN_REVIEW status
                    - api.minimum.two.documents.required — when fewer than 2 documents are provided
                    - api.maximum.six.documents.allowed — when more than 6 documents are provided
                    - api.duplicate.file.names — when multiple documents have the same file name
                    - api.invalid.file.format — when document file is not a valid Base64-encoded file
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "documents", method = RequestMethod.POST)
    @ResponseBody
    public Object saveOrUpdateCorporateDocuments(HttpServletRequest httpServletRequest,
                                                 @RequestParam(name = "referenceNumber") String referenceNumber,
                                                 @RequestBody CorporateDocumentsReqVo corporateDocumentsReqVo) {
        return corporateService.saveOrUpdateCorporateDocuments(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateDocumentsReqVo);
    }

    // -----------------------------Corporate And User Details ----------------------------
    @Operation(summary = "View Corporate Profile",
            description = """
                    Retrieves the complete corporate profile including corporate details, documents, and mapped shareholders. For client users, uses the authenticated user's corporate profile; for agent users, requires corporateClientId parameter.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateProfileRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    @ResponseBody
    public Object corporateProfile(HttpServletRequest httpServletRequest,
                                   @RequestParam(value = "corporateClientId", required = false) String corporateClientId) {
        return corporateService.corporateProfileView(HttpHeader.getApiKey(httpServletRequest), corporateClientId);
    }

    @Operation(summary = "Edit Corporate Client User Details",
            description = """
                    Updates the user details of a corporate client including contact information and personal details. Only editable fields specified in the request will be updated.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.missing.required.details — when validation fails for mobile number or email format
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateClientDetailsEdit(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                             @Valid @RequestBody CorporateClientEditReqVo corporateProfileEditReqVo) {
        log.info("Debug corporate client user details edit request: {}", gson.toJson(corporateProfileEditReqVo));
        return corporateService.corporateClientDetailsEdit(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateProfileEditReqVo);
    }

    @Operation(summary = "Edit Corporate Details",
            description = """
                    Updates corporate-specific details such as entity information, business addresses, and primary contact details. Validates contact information and address fields based on business address configuration.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.missing.required.details — when validation fails for contact mobile number, email, or required business address fields when isDifferentRegisteredAddress is true
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/corporate-details/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateDetailsEdit(HttpServletRequest httpServletRequest,
                                       @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                       @Valid @RequestBody CorporateDetailsReqVo corporateDetailsReqVo) {
        log.info("Debug corporate client corporate details edit request: {}", gson.toJson(corporateDetailsReqVo));
        return corporateService.corporateDetailsEdit(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateDetailsReqVo);
    }

    @Operation(summary = "Update Corporate Profile Picture",
            description = """
                    Updates or removes the corporate client's profile picture. Accepts Base64-encoded image or empty string to remove existing picture.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/client/profile-image/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateClientProfileImageUpdate(HttpServletRequest httpServletRequest,
                                                    @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                                    @Valid @RequestBody CorporateProfileImageAddEditReqVo corporateProfileImageAddEditReqVo) {
        return corporateService.corporateClientProfileImageUpdate(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateProfileImageAddEditReqVo);
    }

    //-----------------------------ShareHolder-----------------------------
    @Operation(summary = "Create Corporate Shareholder",
            description = """
                    Creates a new shareholder for a corporate client in DRAFT status. Includes uploading identity documents and PEP (Politically Exposed Person) declaration. Shareholder must be added to corporate via separate endpoint to be included in shareholdings.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    - api.missing.required.details — when validation fails for required fields, mobile number, email, or PEP declaration when isPep is true
                    - api.invalid.file.format — when identity card images or PEP supporting document are not valid Base64-encoded files
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateShareHolderRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder", method = RequestMethod.POST)
    @ResponseBody
    public Object createShareholder(HttpServletRequest httpServletRequest, @RequestParam(name = "referenceNumber") String referenceNumber,
                                    @Valid @RequestBody CorporateShareholderReqVo corporateShareholderReqVo) {
        CorporateShareholderReqVo copy = gson.fromJson(gson.toJson(corporateShareholderReqVo), CorporateShareholderReqVo.class);
        copy.setIdentityCardFrontImage("Base64 Redacted");
        if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
            copy.setIdentityCardBackImage("Base64 Redacted");
        }
        Optional.ofNullable(copy.getPepDeclaration())
                .map(PepDeclarationVo::getPepDeclarationOptions)
                .ifPresent(options -> options.setSupportingDocument("Base64 Redacted"));
        log.info("Debug create corporate shareholder request: " + gson.toJson(copy));
        return corporateService.createShareholder(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateShareholderReqVo);
    }

    @Operation(summary = "Edit Corporate Shareholder",
            description = """
                    Updates editable fields of an existing shareholder. For completed (mapped) shareholders, validates that total shareholdings still equal 100% after the update.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    - api.shareholder.not.found — when shareholder with the provided ID does not exist for this corporate client
                    - api.missing.required.details — when validation fails for mobile number or email format
                    - api.invalid.shareholdings.percentage — when total shareholdings of all mapped shareholders do not equal 100% (only validated for completed shareholders in non-draft corporate status)
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateShareHolderRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object editShareholder(HttpServletRequest httpServletRequest,
                                  @RequestParam(name = "referenceNumber") String referenceNumber,
                                  @Valid @RequestBody CorporateShareholderEditReqVo corporateShareholderEditReqVo) {
        log.info("Debug edit corporate shareholder request: " + gson.toJson(corporateShareholderEditReqVo));
        return corporateService.editShareholder(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateShareholderEditReqVo);
    }

    @Operation(summary = "View Corporate Shareholder by ID",
            description = """
                    Retrieves detailed information for a specific shareholder by ID including PEP declaration and identity documents.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    - api.shareholder.not.found — when shareholder with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateShareHolderRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder", method = RequestMethod.GET)
    @ResponseBody
    public Object FindShareholder(HttpServletRequest httpServletRequest,
                                  @RequestParam(value = "referenceNumber") String referenceNumber,
                                  @RequestParam(value = "corporateShareholderId") Long corporateShareholderId) {
        return corporateService.viewShareholder(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateShareholderId);
    }

    @Operation(summary = "View All Corporate Shareholders",
            description = """
                    Retrieves all shareholders for a corporate client, separated into draft shareholders (not yet added to corporate) and mapped shareholders (active members with shareholdings).

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateShareholdersRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholders", method = RequestMethod.GET)
    @ResponseBody
    public Object viewCorporateShareholders(HttpServletRequest request,
                                            @RequestParam(value = "referenceNumber") String referenceNumber) {
        return corporateService.viewCorporateShareholders(HttpHeader.getApiKey(request), referenceNumber);
    }

    @Operation(summary = "Delete Corporate Shareholder",
            description = """
                    Soft deletes a shareholder and removes them from the corporate's mapped shareholders. For completed shareholders in non-draft status, validates remaining shareholdings still total 100%.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    - api.shareholder.not.found — when shareholder with the provided ID does not exist for this corporate client
                    - api.invalid.shareholdings.percentage — when total shareholdings of remaining mapped shareholders do not equal 100% (only validated for completed shareholders in non-draft corporate status)
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object corporateShareholderDelete(HttpServletRequest httpServletRequest,
                                             @RequestParam(value = "referenceNumber") String referenceNumber,
                                             @RequestParam(value = "corporateShareHolderId") Long shareholderId) {
        return corporateService.deleteShareholder(HttpHeader.getApiKey(httpServletRequest), referenceNumber, shareholderId);
    }

    @Operation(summary = "Add Shareholders to Corporate",
            description = """
                    Maps draft shareholders to the corporate and sets their status to COMPLETED. Validates that exactly 5 or fewer shareholders are added and their total shareholdings equal 100%. Updates shareholding percentages if provided.

                    Errors:
                    - api.corporate.client.not.found — when corporate client with the provided reference number does not exist
                    - api.corporate.shareholder.limit.5.exceeded — when attempting to add more than 5 shareholders to the corporate
                    - api.invalid.shareholdings.percentage — when total shareholdings of all added shareholders do not equal 100%
                    - api.shareholder.not.found — when no shareholders are provided in the request
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder/add", method = RequestMethod.POST)
    @ResponseBody
    public Object addShareholder(HttpServletRequest httpServletRequest,
                                 @RequestParam(name = "referenceNumber") String referenceNumber,
                                 @Valid @RequestBody CorporateShareholderAddReqVo corporateShareholderAddReqVo) {
        log.info("Debug add corporate shareholder to corporate request: " + gson.toJson(corporateShareholderAddReqVo));
        return corporateService.addShareholder(HttpHeader.getApiKey(httpServletRequest), referenceNumber, corporateShareholderAddReqVo);
    }

    @Operation(summary = "Edit Shareholder PEP Declaration",
            description = """
                    Updates the Politically Exposed Person (PEP) declaration for a shareholder. When isPep is true, validates and requires all PEP-related fields including supporting document.

                    Errors:
                    - api.shareholder.not.found — when shareholder with the provided ID does not exist for this corporate client
                    - api.pep.not.found — when PEP info record does not exist for this shareholder
                    - api.missing.required.details — when isPep is true but required PEP fields (relationship, name, position, organization, supportingDocument) are missing or invalid
                    - api.invalid.file.format — when PEP supporting document is not a valid Base64-encoded file
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateShareholderPepRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/shareholder-pep/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object editShareholderPep(HttpServletRequest httpServletRequest,
                                     @RequestParam(name = "shareHolderId") Long shareHolderId,
                                     @RequestParam(name = "referenceNumber") String referenceNumber,
                                     @Valid @RequestBody PepDeclarationVo pepEditReq) {
        PepDeclarationVo copy = gson.fromJson(gson.toJson(pepEditReq), PepDeclarationVo.class);
        if (copy.getIsPep()) {
            Optional.ofNullable(copy.getPepDeclarationOptions())
                    .ifPresent(options -> options.setSupportingDocument("Base64 Redacted"));
        }
        log.info("Debug edit corporate shareholder pep request: " + gson.toJson(copy));
        return corporateService.editShareholderPep(HttpHeader.getApiKey(httpServletRequest), referenceNumber, shareHolderId, pepEditReq);
    }

    //-----------------------------BankDetails-----------------------------
    @Operation(summary = "Create Bank Details",
            description = """
                    Creates a new bank account for the corporate client. Validates account uniqueness and enforces a maximum limit of 2 bank accounts per corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.bank.details.limit.2.exceeded — when attempting to add more than 2 bank accounts
                    - api.bank.account.exists — when a bank account with the same account number already exists for this corporate client
                    - api.missing.required.details — when validation fails for required fields
                    - api.invalid.file.format — when bank account proof file is not a valid Base64-encoded file
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @RequestMapping(value = "/bank-details", method = RequestMethod.POST)
    @ResponseBody
    public Object createBankDetails(HttpServletRequest httpServletRequest,
                                    @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                    @Valid @RequestBody CorporateBankDetailsReqVo corporateBankDetailsReqVo) {
        CorporateBankDetailsReqVo copy = gson.fromJson(gson.toJson(corporateBankDetailsReqVo), CorporateBankDetailsReqVo.class);
        copy.setBankAccountProofFile("Base64 Redacted");
        log.info("Debug create corporate bank details request: " + gson.toJson(copy));
        return corporateService.createBankDetails(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBankDetailsReqVo);
    }

    @Operation(summary = "Edit Bank Details",
            description = """
                    Updates editable fields of an existing bank account for the corporate client. Supports updating bank account proof file via Base64 encoding.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.bank.details.not.found — when bank account with the provided ID does not exist for this corporate client
                    - api.invalid.file.format — when bank account proof file is not a valid Base64-encoded file
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @RequestMapping(value = "bank-details/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object bankDetailsUpdate(HttpServletRequest httpServletRequest,
                                    @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                    @Valid @RequestBody CorporateBankDetailsEditReqVo corporateBankDetailsEditReqVo) {
        CorporateBankDetailsEditReqVo copy = gson.fromJson(gson.toJson(corporateBankDetailsEditReqVo), CorporateBankDetailsEditReqVo.class);
        copy.setBankAccountProofFile("Base64 Redacted");
        log.info("Debug edit corporate bank details request: {}", gson.toJson(copy));
        return corporateService.updateBankDetails(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBankDetailsEditReqVo);
    }

    @Operation(summary = "Delete Bank Details",
            description = """
                    Soft deletes a bank account for the corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.bank.details.not.found — when bank account with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @RequestMapping(value = "bank-details/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object bankDetailsDelete(HttpServletRequest httpServletRequest,
                                    @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                    @RequestParam("corporateBankId") Long corporateBankId) {
        return corporateService.bankDetailsDelete(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBankId);
    }

    @Operation(summary = "View Bank Details by ID",
            description = """
                    Retrieves detailed information for a specific bank account by ID.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.bank.details.not.found — when bank account with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateBankDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @RequestMapping(value = "bank-details/view", method = RequestMethod.GET)
    @ResponseBody
    public Object bankDetailsViewById(HttpServletRequest httpServletRequest,
                                      @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                      @RequestParam("corporateBankId") Long corporateBankId) {
        return corporateService.viewCorporateBankDetailsById(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBankId);
    }

    @Operation(summary = "View All Bank Details",
            description = """
                    Retrieves all bank accounts for the corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateBankDetailsListRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "bank-details/view-all", method = RequestMethod.GET)
    @ResponseBody
    public Object getBankDetails(HttpServletRequest httpServletRequest,
                                 @RequestParam(value = "corporateClientId", required = false) String corporateClientId) {
        return corporateService.getCorporateBankDetails(HttpHeader.getApiKey(httpServletRequest), corporateClientId);
    }

    //-----------------------------Beneficiary-----------------------------
    @Operation(summary = "Create Corporate Beneficiary",
            description = """
                    Creates a new beneficiary for the corporate client. Validates mobile number and email format, checks for duplicate identity card numbers, and enforces a maximum limit of 10 beneficiaries per corporate client. Returns whether the beneficiary is underage (under 18) to determine if guardian information is required.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.beneficiary.limit.10.exceeded — when attempting to add more than 10 beneficiaries
                    - api.beneficiary.exist — when a beneficiary with the same identity card number already exists for this corporate client
                    - api.missing.required.details — when validation fails for mobile number or email format
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateBeneficiaryCreateRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary", method = RequestMethod.POST)
    @ResponseBody
    public Object createCorporateBeneficiary(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                             @Valid @RequestBody CorporateBeneficiaryCreationReqVo corporateBeneficiaryDetails) {
        log.info("Debug create corporate beneficiary request: {}", gson.toJson(corporateBeneficiaryDetails));
        return corporateService.createCorporateBeneficiary(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBeneficiaryDetails);
    }

    @Operation(summary = "Edit Corporate Beneficiary",
            description = """
                    Updates editable fields of an existing beneficiary. Validates mobile number and email format when provided.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.beneficiary.not.found — when beneficiary with the provided ID does not exist for this corporate client
                    - api.missing.required.details — when validation fails for mobile number or email format
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object updateCorporateBeneficiary(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                             @RequestParam(value = "corporateBeneficiaryId") Long corporateBeneficiaryId,
                                             @Valid @RequestBody CorporateBeneficiaryUpdateReqVo corporateBeneficiaryUpdate) {
        log.info("Debug edit corporate beneficiary request: {}", gson.toJson(corporateBeneficiaryUpdate));
        return corporateService.updateCorporateBeneficiary(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBeneficiaryId, corporateBeneficiaryUpdate);
    }

    @Operation(summary = "Delete Corporate Beneficiary",
            description = """
                    Soft deletes a beneficiary for the corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.beneficiary.not.found — when beneficiary with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteCorporateBeneficiary(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                             @RequestParam(value = "corporateBeneficiaryId") Long corporateBeneficiaryId) {
        return corporateService.deleteCorporateBeneficiary(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBeneficiaryId);
    }

    @Operation(summary = "View Corporate Beneficiary by ID",
            description = """
                    Retrieves detailed information for a specific beneficiary by ID including guardian information if applicable.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.beneficiary.not.found — when beneficiary with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateBeneficiaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/view", method = RequestMethod.GET)
    @ResponseBody
    public Object viewCorporateBeneficiaryById(HttpServletRequest httpServletRequest,
                                               @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                               @RequestParam(value = "corporateBeneficiaryId") Long corporateBeneficiaryId) {
        return corporateService.viewCorporateBeneficiaryById(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateBeneficiaryId);
    }

    @Operation(summary = "View All Corporate Beneficiaries",
            description = """
                    Retrieves all beneficiaries for the corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateBeneficiariesRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiary/view-all", method = RequestMethod.GET)
    @ResponseBody
    public Object viewCorporateBeneficiaries(HttpServletRequest request,
                                             @RequestParam(value = "corporateClientId", required = false) String corporateClientId) {
        return corporateService.viewCorporateBeneficiaries(HttpHeader.getApiKey(request), corporateClientId);
    }

    //-----------------------------Guardian-----------------------------
    @Operation(summary = "Create Corporate Guardian",
            description = """
                    Creates a guardian for an underage beneficiary (under 18 years old). Links the guardian to the specified beneficiary. Each beneficiary can have only one guardian.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.beneficiary.not.found — when beneficiary with the provided ID does not exist for this corporate client
                    - api.guardian.exist — when the beneficiary already has an assigned guardian
                    - api.missing.required.details — when validation fails for mobile number or email format
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian", method = RequestMethod.POST)
    @ResponseBody
    public Object createCorporateGuardian(HttpServletRequest httpServletRequest,
                                          @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                          @Valid @RequestBody CorporateGuardianCreationReqVo corporateGuardianDetails) {
        log.info("Debug create corporate guardian request: " + gson.toJson(corporateGuardianDetails));
        return corporateService.createCorporateGuardian(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateGuardianDetails);
    }

    @Operation(summary = "Edit Corporate Guardian",
            description = """
                    Updates editable fields of an existing guardian. Validates mobile number and email format when provided.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.guardian.not.found — when guardian with the provided ID does not exist for this corporate client
                    - api.missing.required.details — when validation fails for mobile number or email format
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian/edit", method = RequestMethod.POST)
    @ResponseBody
    public Object updateCorporateGuardian(HttpServletRequest httpServletRequest,
                                          @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                          @RequestParam(value = "corporateGuardianId") Long corporateGuardianId,
                                          @Valid @RequestBody CorporateGuardianUpdateReqVo corporateGuardianUpdateReqVo) {
        log.info("Debug edit corporate guardian request: {}", gson.toJson(corporateGuardianUpdateReqVo));
        return corporateService.updateCorporateGuardian(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateGuardianId, corporateGuardianUpdateReqVo);
    }

    @Operation(summary = "Delete Corporate Guardian",
            description = """
                    Soft deletes a guardian and unlinks them from any associated beneficiary.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.guardian.not.found — when guardian with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteCorporateGuardian(HttpServletRequest httpServletRequest,
                                          @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                          @RequestParam(value = "corporateGuardianId") Long corporateGuardianId) {
        return corporateService.deleteCorporateGuardian(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateGuardianId);
    }

    @Operation(summary = "View All Corporate Guardians",
            description = """
                    Retrieves all guardians for the corporate client.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateGuardiansRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/guardian/view-all", method = RequestMethod.GET)
    @ResponseBody
    public Object viewCorporateGuardians(HttpServletRequest request,
                                         @RequestParam(name = "corporateClientId", required = false) String corporateClientId) {
        return corporateService.viewCorporateGuardians(HttpHeader.getApiKey(request), corporateClientId);
    }

    @Operation(summary = "View Corporate Guardian by ID",
            description = """
                    Retrieves detailed information for a specific guardian by ID.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.corporate.guardian.not.found — when guardian with the provided ID does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = CorporateGuardianRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @RequestMapping(value = "guardian-details/view", method = RequestMethod.GET)
    @ResponseBody
    public Object viewByIdCorporateGuardians(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "corporateClientId", required = false) String corporateClientId,
                                             @RequestParam(value = "corporateGuardianId") Long corporateGuardianId) {
        return corporateService.viewByIdCorporateGuardians(HttpHeader.getApiKey(httpServletRequest), corporateClientId, corporateGuardianId);
    }

    //-----------------------------Portfolio-----------------------------
    @Operation(summary = "Get Corporate Client Portfolio",
            description = """
                    Retrieves all product orders and investments for the corporate client, including product details, investment amounts, maturity dates, and redemption options.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPortfolioRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/portfolio", method = RequestMethod.GET)
    @ResponseBody
    public Object getCorporateClientPortfolio(HttpServletRequest request,
                                              @RequestParam(value = "corporateClientId") String corporateClientId) {
        return corporateService.getCorporateClientPortfolio(HttpHeader.getApiKey(request), corporateClientId);
    }

    @Operation(summary = "Get Portfolio Product Details",
            description = """
                    Retrieves detailed information for a specific product order including beneficiary distribution, dividend payments, and redemption history.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    - api.product.order.not.found — when product order with the provided reference number does not exist for this corporate client
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ClientPortfolioProductDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/portfolio/product", method = RequestMethod.GET)
    @ResponseBody
    public Object getCorporateClientPortfolioProductDetails(HttpServletRequest request,
                                                            @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber,
                                                            @RequestParam(value = "corporateClientId") String corporateClientId) {
        return corporateService.getCorporateClientPortfolioProductDetails(HttpHeader.getApiKey(request), orderReferenceNumber, corporateClientId);
    }

    //-----------------------------Transaction-----------------------------

    @Operation(summary = "Get Corporate Client Transactions",
            description = """
                    Retrieves all transaction history for the corporate client including product purchases (payment successful only) and dividend payments.

                    Errors:
                    - api.user.not.found — when API key belongs to a client user but client record not found
                    - api.corporate.client.not.found — when corporate client with the provided ID does not exist
                    """)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = TransactionRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/transactions", method = RequestMethod.GET)
    @ResponseBody
    public Object getCorporateClientTransactions(HttpServletRequest request,
                                                 @RequestParam(value = "corporateClientId") String corporateClientId) {
        return corporateService.getCorporateClientTransactions(HttpHeader.getApiKey(request), corporateClientId);
    }

    //-----------------------------Product Order-----------------------------
    @Operation(summary = "Purchase Product",
            description = """
                             Notes : This api is used to purchase a product by agent for client.
                             In request need to send clientId(String) not primaryKey(Long) of client.
                             If new product order, referenceNumber is NOT required.
                    
                             These fields are required in the request in order to save the initial draft.
                              1.ProductPurchaseProductDetailsVo.productId;
                              2.ProductPurchaseProductDetailsVo.amount;
                              3.ProductPurchaseProductDetailsVo.dividend;
                              4.ProductPurchaseProductDetailsVo.investmentTenureMonth;
                    
                             If an existing draft is being updated, referenceNumber is required.
                    """
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductOrderSummaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/product/purchase", method = RequestMethod.POST)
    @ResponseBody
    public Object purchaseProduct(HttpServletRequest httpServletRequest,
                                  @RequestParam(name = "referenceNumber", required = false) String referenceNumber,
                                  @Valid @RequestBody ProductPurchaseReqVo productPurchaseReqVo) {
        log.info("Debug Corporate product purchase request : {}", gson.toJson(productPurchaseReqVo));
        return productService.createProductOrder(HttpHeader.getApiKey(httpServletRequest), productPurchaseReqVo, referenceNumber);
    }
}