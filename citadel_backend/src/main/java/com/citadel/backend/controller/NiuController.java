package com.citadel.backend.controller;

import com.citadel.backend.service.NiuService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Niu.NiuApplyRequestVo;
import com.citadel.backend.vo.Niu.NiuGetApplicationRespVo;
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
@RequestMapping("api/niu")
@Tag(name = "niu-controller", description = "NIU Controller")
public class NiuController extends BaseRestController {

    @Resource
    private NiuService niuService;

    @Operation(summary = "Get NIU Application")
    @RequestMapping(value = "/application", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = NiuGetApplicationRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @ResponseBody
    public Object getNiuApplication(HttpServletRequest httpServletRequest) {
        try {
            return niuService.getNiuApplicationUpdate(HttpHeader.getApiKey(httpServletRequest));
        } catch (Exception e) {
            log.error("Error in getNiuApplication", e);
            return getErrorException(e);
        }
    }

    @Operation(summary = "Submit NIU Application",
            description = """
                    1. Client Id is optional, required if application is made agent on behalf of client
                    2. Corporate Id is optional, required if application is made for corporate client
                    """)
    @RequestMapping(value = "/apply", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object submitNiuApplication(@Valid @RequestBody NiuApplyRequestVo niuApplyRequestVo, HttpServletRequest httpServletRequest) {
        try {
            return niuService.submitNiuApplicationUpdate(niuApplyRequestVo, HttpHeader.getApiKey(httpServletRequest));
        } catch (Exception e) {
            log.error("Error in submitNiuApplication", e);
            return getErrorException(e);
        }
    }
}