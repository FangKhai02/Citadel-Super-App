package com.citadel.backend.controller;

import com.citadel.backend.service.PushNotificationService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Notification.NotificationsRespVo;
import com.citadel.backend.vo.Notification.NotificationsUpdateReqVo;
import com.citadel.backend.vo.Notification.SyncNotificationReqVo;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("api/notification")
@Tag(name = "notification-controller", description = "Notification Controller")
public class NotificationController extends BaseRestController {

    @Resource
    private PushNotificationService pushNotificationService;

    @Operation(summary = "Get Notification under current user.")
    @RequestMapping(value = "", method = RequestMethod.GET)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = NotificationsRespVo.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object getUserNotificationList(HttpServletRequest httpServletRequest) {
        return pushNotificationService.getUserNotificationList(httpServletRequest);
    }

    @Operation(summary = "Update Notification to is read.")
    @RequestMapping(value = "/read", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object updateNotificationsAsRead(@RequestBody NotificationsUpdateReqVo notificationsUpdateReqVo, HttpServletRequest httpServletRequest) throws Exception {
        return pushNotificationService.updateNotificationsAsRead(notificationsUpdateReqVo, httpServletRequest);
    }

    @Operation(summary = "Update Notification to is delete.")
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object updateNotificationsAsDelete(@RequestBody NotificationsUpdateReqVo notificationsUpdateReqVo, HttpServletRequest httpServletRequest) throws Exception {
        return pushNotificationService.updateNotificationsAsDelete(notificationsUpdateReqVo, httpServletRequest);
    }

    @Operation(summary = "Sync Notification/Notifications from device")
    @RequestMapping(value = "/sync", method = RequestMethod.POST)
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    public @ResponseBody Object updateSyncNotifications(@RequestBody SyncNotificationReqVo syncNotificationReqVo, HttpServletRequest httpServletRequest) throws Exception {
        return pushNotificationService.updateSyncNotifications(syncNotificationReqVo, httpServletRequest);
    }
}