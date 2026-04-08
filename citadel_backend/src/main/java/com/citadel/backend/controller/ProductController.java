package com.citadel.backend.controller;

import com.citadel.backend.service.ProductService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.Beneficiary.IndividualBeneficiaryUpdateReqVo;
import com.citadel.backend.vo.Product.*;
import com.citadel.backend.vo.Product.Reallocation.ReallocatableProductCodesRespVo;
import com.citadel.backend.vo.Product.Reallocation.ReallocateReqVo;
import com.citadel.backend.vo.Product.req.ProductOrderPaymentUploadReqVo;
import com.citadel.backend.vo.Product.req.ProductPurchaseReqVo;
import com.citadel.backend.vo.Product.resp.ProductOrderPaymentUploadRespVo;
import com.citadel.backend.vo.Product.resp.ProductPurchaseBeneficiariesRespVo;
import com.citadel.backend.vo.Product.resp.ProductOrderSummaryRespVo;
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
@RequestMapping("api/product")
@Tag(name = "product-controller", description = "Product Controller")
public class ProductController extends BaseRestController {

    @Resource
    private ProductService productService;

    @Operation(summary = "Get list of all products")
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductListRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @ResponseBody
    public Object getProductList() {
        try {
            return productService.getProductList();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Get Product by ID")
    @RequestMapping(value = "/{productId}", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @ResponseBody
    public Object getProductById(@PathVariable Long productId) {
        try {
            // Call the ProductService to get the product details by ID
            return productService.getProductById(productId);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Get Product Bank Details By Product Code")
    @RequestMapping(value = "/bank-details", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductBankDetailsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @ResponseBody
    public Object getProductBankDetails(@RequestParam(name = "productCode") String productCode) {
        try {
            return productService.getProductBankDetails(productCode);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    //-----------------------------------Product Order Validations Start-----------------------------------
    @Operation(summary = "Purchase Product Validation CheckPoint One")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductOrderSummaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/purchase/validation/product", method = RequestMethod.POST)
    @ResponseBody
    public Object productOrderValidationCheckpointOne(HttpServletRequest httpServletRequest, @Valid @RequestBody ProductPurchaseReqVo productPurchaseReqVo) {
        log.info("Debug product purchase validation checkpoint 1 request: " + gson.toJson(productPurchaseReqVo));
        return productService.productOrderValidationCheckpointOne(HttpHeader.getApiKey(httpServletRequest), productPurchaseReqVo);
    }

    @Operation(summary = "Purchase Product Validation CheckPoint Two")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductOrderSummaryRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/purchase/validation/beneficiary-distribution", method = RequestMethod.POST)
    @ResponseBody
    public Object productOrderValidationCheckpointTwo(HttpServletRequest httpServletRequest, @Valid @RequestBody ProductPurchaseReqVo productPurchaseReqVo) {
        log.info("Debug product purchase beneficiaries distribution validation: " + gson.toJson(productPurchaseReqVo));
        return productService.productOrderBeneficiariesDistributionValidation(HttpHeader.getApiKey(httpServletRequest), productPurchaseReqVo);
    }

    //-----------------------------------Product Order Validations End-----------------------------------

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
        log.info("Debug product purchase request: " + gson.toJson(productPurchaseReqVo));
        return productService.createProductOrder(HttpHeader.getApiKey(httpServletRequest), productPurchaseReqVo, referenceNumber);
    }

    @Operation(summary = "Get Product Beneficiaries By product referenceNumber")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductPurchaseBeneficiariesRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/beneficiaries", method = RequestMethod.GET)
    @ResponseBody
    public Object getProductBeneficiaries(HttpServletRequest httpServletRequest,
                                          @RequestParam(name = "referenceNumber") String referenceNumber) {
        return productService.getProductBeneficiaries(HttpHeader.getApiKey(httpServletRequest), referenceNumber);
    }

    @Operation(summary = "Get Uploaded Payment Receipts By Order Reference Number")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductOrderPaymentUploadRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/payment-receipts", method = RequestMethod.GET)
    @ResponseBody
    public Object getUploadedPaymentReceipts(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "referenceNumber") String referenceNumber) {
        return productService.getUploadedPaymentReceipts(HttpHeader.getApiKey(httpServletRequest), referenceNumber);
    }

    @Operation(summary = "Upload Payment Receipt")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/payment-receipts", method = RequestMethod.POST)
    @ResponseBody
    public Object uploadPaymentReceipt(HttpServletRequest httpServletRequest,
                                       @RequestParam(name = "referenceNumber") String referenceNumber,
                                       @RequestParam(name = "isDraft") Boolean isDraft,
                                       @RequestBody ProductOrderPaymentUploadReqVo request) {
        ProductOrderPaymentUploadReqVo copy = gson.fromJson(gson.toJson(request), ProductOrderPaymentUploadReqVo.class);
        copy.getReceipts().forEach(receipt -> {
            if (!receipt.getFile().startsWith("http")) {
                receipt.setFile("Base64 Redacted");
            }
        });
        log.info("Debug product receipt request: isDraft : {} requestBody : {}", isDraft, gson.toJson(copy));
        return productService.uploadPaymentReceipt(HttpHeader.getApiKey(httpServletRequest), referenceNumber, request, isDraft);
    }

    //Product early redemption
    @Operation(summary = "Product Early Redemption")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ProductEarlyRedemptionRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/early-redemption", method = RequestMethod.POST)
    @ResponseBody
    public Object withdrawProduct(HttpServletRequest httpServletRequest,
                                  @RequestParam(name = "isRedemption") Boolean isRedemption,
                                  @Valid @RequestBody ProductEarlyRedemptionReqVo productWithdrawalUpdateReqVo) {
        log.info("Debug early redemption request: isRedemption : {} requestBody : {}", isRedemption, gson.toJson(productWithdrawalUpdateReqVo));
        return productService.createEarlyRedemption(HttpHeader.getApiKey(httpServletRequest), productWithdrawalUpdateReqVo, isRedemption);
    }

    @Operation(summary = "Delete Product Order")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteProductOrder(HttpServletRequest httpServletRequest,
                                     @RequestParam(name = "referenceNumber") String referenceNumber) {
        log.info("Debug product delete request: {}", referenceNumber);
        return productService.deleteProductOrder(HttpHeader.getApiKey(httpServletRequest), referenceNumber);
    }

    @Operation(summary = "Product Full Redemption")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/full-redemption", method = RequestMethod.POST)
    @ResponseBody
    public Object productOrderFullRedemption(HttpServletRequest httpServletRequest,
                                             @RequestParam(name = "orderReferenceNumber") String orderReferenceNumber) {
        log.info("Debug full redemption request : {}", orderReferenceNumber);
        String apiKey = HttpHeader.getApiKey(httpServletRequest);
        return productService.productOrderFullRedemption(apiKey, orderReferenceNumber);
    }

    @Operation(summary = "Product Rollover")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/rollover", method = RequestMethod.POST)
    @ResponseBody
    public Object productOrderRolloverRedemption(HttpServletRequest httpServletRequest,
                                                 @RequestParam(name = "orderReferenceNumber") String orderReferenceNumber,
                                                 @Valid @RequestBody RolloverReqVo req) {
        log.info("Debug rollover request : {}", orderReferenceNumber);
        String apiKey = HttpHeader.getApiKey(httpServletRequest);
        return productService.createRolloverProductOrder(apiKey, orderReferenceNumber, req);
    }

    @Operation(summary = "Get All Reallocatable Product Codes For Reallocation")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ReallocatableProductCodesRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/reallocation/product-codes", method = RequestMethod.GET)
    @ResponseBody
    public Object getReallocatableProductCodes(HttpServletRequest httpServletRequest,
                                               @RequestParam(name = "orderReferenceNumber") String orderReferenceNumber) {
        log.info("Debug reallocation product codes request: {}", orderReferenceNumber);
        return productService.getReallocatableProductCodes(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber);
    }

    @Operation(summary = "Reallocation Redemption")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/reallocation", method = RequestMethod.POST)
    @ResponseBody
    public Object productOrderReallocationRedemption(HttpServletRequest httpServletRequest,
                                                     @RequestParam(name = "orderReferenceNumber") String orderReferenceNumber,
                                                     @Valid @RequestBody ReallocateReqVo req) {
        log.info("Debug reallocation request: {}", orderReferenceNumber);
        String apiKey = HttpHeader.getApiKey(httpServletRequest);
        return productService.createReallocationProductOrder(apiKey, orderReferenceNumber, req);
    }

    @Operation(summary = "Get Incremental Amount List")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = IncrementalAmountListRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/incremental-amount-list", method = RequestMethod.GET)
    @ResponseBody
    public Object getIncrementalAmountList(HttpServletRequest httpServletRequest,
                                           @RequestParam(name = "orderReferenceNumber") String orderReferenceNumber) {
        return productService.getIncrementalAmountList(HttpHeader.getApiKey(httpServletRequest), orderReferenceNumber);
    }
}
