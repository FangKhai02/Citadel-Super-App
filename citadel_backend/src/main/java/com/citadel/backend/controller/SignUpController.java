package com.citadel.backend.controller;

import com.citadel.backend.service.SignUpService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Enum.UserType;
import com.citadel.backend.vo.SignUp.Agent.AgentSignUpReqVo;
import com.citadel.backend.vo.SignUp.Agent.ExistingAgentRespVo;
import com.citadel.backend.vo.SignUp.Client.ClientIdentityDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientPersonalDetailsReqVo;
import com.citadel.backend.vo.SignUp.Client.ClientSignUpReqVo;
import com.citadel.backend.vo.SignUp.ExistingClientRespVo;
import com.citadel.backend.vo.SignUp.PepDeclarationVo;
import com.citadel.backend.vo.SignUp.SignUpBaseContactDetailsVo;
import com.citadel.backend.vo.SignUp.SignUpBaseIdentityDetailsVo;
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

import java.util.Optional;

@Controller
@RequestMapping("api/sign-up")
@Tag(name = "sign up-controller", description = "Sign Up Controller")
public class SignUpController extends BaseRestController {
    @Resource
    private SignUpService signUpService;

    // -----------------------------Client Sign Up-----------------------------
    @Operation(summary = "Check for existing client record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ExistingClientRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/client", method = RequestMethod.GET)
    @ResponseBody
    public Object checkExistingClient(@RequestParam("identityCardNumber") String identityCardNumber) {
        try {
            log.info("Debug check existing client identity card number : {}", identityCardNumber);
            return signUpService.checkForExistingClientRecord(identityCardNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Client Sign Up Validation Checkpoint 1 Identity Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/client/validation/identity-details", method = RequestMethod.POST)
    @ResponseBody
    public Object clientSignUpValidationOne(@Valid @RequestBody ClientIdentityDetailsReqVo clientIdentityDetailsReq) {
        try {
            ClientIdentityDetailsReqVo copy = gson.fromJson(gson.toJson(clientIdentityDetailsReq), ClientIdentityDetailsReqVo.class);
            copy.setIdentityCardFrontImage("Base64 Redacted");
            if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
                copy.setIdentityCardBackImage("Base64 Redacted");
            }
            log.info("Debug client identity details: " + gson.toJson(copy));
            return signUpService.signUpIdentityDetailsValidationCheckpointOne(clientIdentityDetailsReq, true, UserType.CLIENT);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Client Sign Up Validation Checkpoint 2 Personal Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/client/validation/personal-details", method = RequestMethod.POST)
    @ResponseBody
    public Object clientSignUpValidationTwo(@Valid @RequestBody ClientPersonalDetailsReqVo clientPersonalDetailsReqVo) {
        try {
            ClientPersonalDetailsReqVo copy = gson.fromJson(gson.toJson(clientPersonalDetailsReqVo), ClientPersonalDetailsReqVo.class);
            copy.setProofOfAddressFile("Base64 Redacted");
            Optional.ofNullable(copy.getCorrespondingAddress()).ifPresent(correspondingAddress -> {
                if (correspondingAddress.getIsSameCorrespondingAddress()) {
                    correspondingAddress.setCorrespondingAddressProofKey("Base64 Redacted");
                }
            });
            log.info("Debug client personal details: " + gson.toJson(copy));
            return signUpService.signUpContactDetailsValidationCheckpointTwo(clientPersonalDetailsReqVo);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Client Sign Up")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/client", method = RequestMethod.POST)
    @ResponseBody
    public Object clientSignUp(@Valid @RequestBody ClientSignUpReqVo clientSignUpReqVo) {
        try {
            ClientSignUpReqVo copy = gson.fromJson(gson.toJson(clientSignUpReqVo), ClientSignUpReqVo.class);
            copy.getIdentityDetails().setIdentityCardFrontImage("Base64 Redacted");
            if (StringUtil.isNotEmpty(copy.getIdentityDetails().getIdentityCardBackImage())) {
                copy.getIdentityDetails().setIdentityCardBackImage("Base64 Redacted");
            }
            if (copy.getPersonalDetails().getCorrespondingAddress() != null) {
                // Check if isSameCorrespondingAddress is false. If false, redact the proof key.
                if (Boolean.FALSE.equals(copy.getPersonalDetails().getCorrespondingAddress().getIsSameCorrespondingAddress())) {
                    if (StringUtil.isNotEmpty(copy.getPersonalDetails().getCorrespondingAddress().getCorrespondingAddressProofKey())) {
                        copy.getPersonalDetails().getCorrespondingAddress().setCorrespondingAddressProofKey("Base64 Redacted");
                    }
                }
            }
            if (StringUtil.isNotEmpty(copy.getPersonalDetails().getProofOfAddressFile())) {
                copy.getPersonalDetails().setProofOfAddressFile("Base64 Redacted");
            }
            copy.setSelfieImage("Base64 Redacted");
            Optional.ofNullable(copy.getPepDeclaration())
                    .map(PepDeclarationVo::getPepDeclarationOptions)
                    .ifPresent(options -> options.setSupportingDocument("Base64 Redacted"));
            copy.setDigitalSignature("Base64 Redacted");
            copy.setPassword("Password Redacted");
            log.info("Debug client sign up: " + gson.toJson(copy));
            return signUpService.clientSignUpUpdate(clientSignUpReqVo);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    //-----------------------------Agent Sign Up-----------------------------
    @Operation(summary = "Check for existing Agent record")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ExistingAgentRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent", method = RequestMethod.GET)
    @ResponseBody
    public Object checkExistingAgent(@RequestParam("identityCardNumber") String identityCardNumber) {
        try {
            log.info("Debug check existing agent identity card number: {}", identityCardNumber);
            return signUpService.checkForExistingAgentRecord(identityCardNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Agent Sign Up Validation Checkpoint 1 Identity Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent/validation/identity-details", method = RequestMethod.POST)
    @ResponseBody
    public Object agentSignUpValidationOne(@Valid @RequestBody SignUpBaseIdentityDetailsVo agentIdentityDetailsReq) {
        try {
            SignUpBaseIdentityDetailsVo copy = gson.fromJson(gson.toJson(agentIdentityDetailsReq), SignUpBaseIdentityDetailsVo.class);
            copy.setIdentityCardFrontImage("Base64 Redacted");
            if (StringUtil.isNotEmpty(copy.getIdentityCardBackImage())) {
                copy.setIdentityCardBackImage("Base64 Redacted");
            }
            log.info("Debug client identity details: " + gson.toJson(copy));
            return signUpService.signUpIdentityDetailsValidationCheckpointOne(agentIdentityDetailsReq, false, UserType.AGENT);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Agent Sign Up Validation Checkpoint 2 Contact Details")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent/validation/contact-details", method = RequestMethod.POST)
    @ResponseBody
    public Object agentSignUpValidationOne(@Valid @RequestBody SignUpBaseContactDetailsVo agentContactDetailsReq) {
        try {
            SignUpBaseContactDetailsVo copy = gson.fromJson(gson.toJson(agentContactDetailsReq), SignUpBaseContactDetailsVo.class);
            copy.setProofOfAddressFile("Base64 Redacted");
            log.info("Debug client personal details: " + gson.toJson(copy));
            return signUpService.signUpContactDetailsValidationCheckpointTwo(agentContactDetailsReq);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "Agent Sign Up")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent", method = RequestMethod.POST)
    @ResponseBody
    public Object agentSignUp(@Valid @RequestBody AgentSignUpReqVo agentSignUpReqVo) {
        try {
            AgentSignUpReqVo copy = gson.fromJson(gson.toJson(agentSignUpReqVo), AgentSignUpReqVo.class);
            copy.getIdentityDetails().setIdentityCardFrontImage("Base64 Redacted");
            if (StringUtil.isNotEmpty(copy.getIdentityDetails().getIdentityCardBackImage())) {
                copy.getIdentityDetails().setIdentityCardBackImage("Base64 Redacted");
            }
            copy.getContactDetails().setProofOfAddressFile("Base64 Redacted");
            copy.setSelfieImage("Base64 Redacted");
            copy.getBankDetails().setBankAccountProofFile("Base64 Redacted");
            copy.setDigitalSignature("Base64 Redacted");
            copy.setPassword("Password Redacted");
            log.info("Debug agent sign up: " + gson.toJson(copy));
            return signUpService.agentSignUpUpdate(agentSignUpReqVo);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }
}
