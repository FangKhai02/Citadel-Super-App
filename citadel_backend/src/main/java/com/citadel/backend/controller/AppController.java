package com.citadel.backend.controller;

import com.citadel.backend.service.AppService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.*;
import com.citadel.backend.vo.Agency.AgencyListRespVo;
import com.citadel.backend.vo.Constants.GetConstantsRespVo;
import com.citadel.backend.vo.FaceID.FaceCompareReqVo;
import com.citadel.backend.vo.FaceID.FaceCompareRespVo;
import com.citadel.backend.vo.FaceID.ImageValidateReqVo;
import com.citadel.backend.vo.FaceID.ImageValidateRespVo;
import com.citadel.backend.vo.Login.LoginRespVo;
import com.citadel.backend.vo.Setting.SettingsRespVo;
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
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.json.JSONObject;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("api/app")
@Tag(name = "app-controller", description = "App Controller")
public class AppController extends BaseRestController {

    @Resource
    private Environment environment;

    @Resource
    private AppService appService;

    @Operation(summary = "Testing")
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    public @ResponseBody Object test() {
        return "SUCCESS";
    }

    @Operation(summary = "Environment")
    @RequestMapping(value = "/environment", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    public @ResponseBody Object environment() {
        String[] activeProfiles = environment.getActiveProfiles();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("activeProfile", String.join(",", activeProfiles));
        jsonObject.put("osName", System.getProperty("os.name"));
        jsonObject.put("tempDir", System.getProperty("java.io.tmpdir"));
        return jsonObject.toString();
    }

    @Operation(summary = "Get list of all agencies")
    @RequestMapping(value = "/agency", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = AgencyListRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @ResponseBody
    public Object getAgencyList() {
        return appService.getAgencyList();
    }

    @Operation(summary = "Get Citadel App Settings")
    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = SettingsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    public @ResponseBody Object getSettings() {
        return appService.getSettings();
    }

    @Operation(summary = "Get Citadel App Constants")
    @RequestMapping(value = "/constants", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = GetConstantsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    public @ResponseBody Object getConstants() {
        return appService.getConstants();
    }

    @Operation(summary = "Submit Contact Us Form")
    @RequestMapping(value = "/contact-us", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    public @ResponseBody Object submitContactUsForm(@Valid @RequestBody ContactUsFormSubmitReqVo contactUsFormSubmitReqVo) {
        log.info("Debug submit contact us form request: " + gson.toJson(contactUsFormSubmitReqVo));
        return appService.submitContactUsFormUpdate(contactUsFormSubmitReqVo);
    }

    @Operation(summary = "Get App User", description = "Get App User")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = LoginRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/user", method = RequestMethod.POST)
    @ResponseBody
    public Object getAppUser(HttpServletRequest httpServletRequest) {
        return appService.getAppUser(HttpHeader.getApiKey(httpServletRequest));
    }

    @Hidden
    @RequestMapping(value = "/redirect", method = RequestMethod.GET)
    @CrossOrigin("*")
    public void redirectUrl(@RequestParam(value = "url") String url, HttpServletResponse res) throws Exception {
        try {
            res.sendRedirect(res.encodeRedirectURL(url));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Operation(summary = "Delete App User Request")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/user/delete", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteAppUser(HttpServletRequest httpServletRequest, @RequestBody AppUserDeleteReqVo appUserDeleteReqVo) {
        log.info("Debug delete app user request from app: " + gson.toJson(appUserDeleteReqVo));
        return appService.deleteAppUser(HttpHeader.getApiKey(httpServletRequest), appUserDeleteReqVo);
    }

    @Operation(summary = "Delete App User Request Form Web")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/user/delete/web", method = RequestMethod.POST)
    @ResponseBody
    public Object deleteAppUser(@Valid @RequestBody WebUserDeleteReqVo webUserDeleteReqVo) {
        log.info("Debug delete app user request from web: " + webUserDeleteReqVo.getEmail());
        return appService.webDeleteAppUser(webUserDeleteReqVo);
    }

    @Operation(summary = "Face ID - Image Validate")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ImageValidateRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/face-id/image-validate", method = RequestMethod.POST)
    @ResponseBody
    public Object faceIdImageValidate(@RequestBody ImageValidateReqVo imageValidateReqVo) throws Exception {
        return appService.faceIdImageValidate(imageValidateReqVo);
    }

    @Operation(summary = "Face ID - Face Compare (FaceNet)")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = FaceCompareRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/face-id/compare", method = RequestMethod.POST)
    @ResponseBody
    public Object faceCompare(@RequestBody FaceCompareReqVo faceCompareReqVo) throws Exception {
        return appService.faceCompare(faceCompareReqVo);
    }

    @Operation(summary = "Get maintenance",
            description = """
                    Cases:
                    
                    - No maintenance, {"code": "200","message": "api.request.successful","startDatetime": null,"endDatetime": null}
                    
                    - a) Same day maintenance, {"code": "500","message": "api.server.maintenance","startDatetime": "11:00am","endDatetime": "9:00pm"}
                    
                    - b) Overnight maintenance, {"code": "500","message": "api.server.maintenance","startDatetime": "08 January 2025, 11:00pm","endDatetime": "09 January 2025, 3:00am"}""")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = GetMaintenanceRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/maintenance", method = RequestMethod.GET)
    @ResponseBody
    public Object getMaintenance() throws Exception{
        return appService.getMaintenanceUpdate();
    }

    @Operation(summary = "Check force update", description = "platform= ios/android")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = ForceUpdateRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/force-update/{appVersion}/{platform}", method = RequestMethod.GET)
    @ResponseBody
    public Object forceUpdate(@PathVariable String appVersion, @PathVariable String platform) {
        return appService.checkForceUpdate(appVersion, platform);
    }
}