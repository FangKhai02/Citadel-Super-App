package com.citadel.backend.controller;

import com.citadel.backend.service.MigrationService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Migration.MigrationSheetReq;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("api/migration")
@Tag(name = "migration-controller", description = "Migration Controller")
public class DataMigrationController extends BaseRestController {
    @Resource
    private MigrationService migrationService;


    @Operation(summary = "Data Migration",
            description = "Send empty list to migrate/update all sheets, or send a list of sheet indexes to migrate/update specific sheets",
            tags = {"migration-controller"})
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin(originPatterns = "*", allowCredentials = "true")
    @RequestMapping(value = "", method = RequestMethod.POST)
    @ResponseBody
    public Object createMigration(@RequestBody MigrationSheetReq req) {
        try {
            return migrationService.createMigration(req);
        } catch (Exception ex) {
            log.error("Error in {} ", getFunctionName(), ex);
            return getErrorException(ex);
        }
    }
}
