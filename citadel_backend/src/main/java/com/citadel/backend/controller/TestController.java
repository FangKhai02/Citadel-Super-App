package com.citadel.backend.controller;

import com.citadel.backend.entity.Products.ProductDividendSchedule;
import com.citadel.backend.service.AgentService;
import com.citadel.backend.service.BackendService;
import com.citadel.backend.service.TestService;
import com.citadel.backend.utils.BaseRestController;
import com.citadel.backend.utils.HttpHeader;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.TestIDRequest;
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

import java.time.LocalDate;

@Controller
@RequestMapping("api/test")
@Tag(name = "test-controller", description = "Test Controller")
public class TestController extends BaseRestController {

    @Resource
    private TestService testService;

    @Resource
    private AgentService agentService;

    @Resource
    private BackendService backendService;

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/clientSendEmail", method = RequestMethod.GET)
    @ResponseBody
    public Object checkExistingClient() {
        try {
            return testService.testSendEmail();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend/fixed", method = RequestMethod.GET)
    @ResponseBody
    public Object testFixedDividendCalculation(@RequestParam(value = "dd", required = false) Integer day,
                                               @RequestParam(value = "mm", required = false) Integer month,
                                               @RequestParam(value = "yyyy", required = false) Integer year,
                                               @RequestParam(value = "PayoutFrequency", required = false) ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            LocalDate today;

            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testFixedDividendCalculation(today, frequencyOfPayout);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend/final", method = RequestMethod.GET)
    @ResponseBody
    public Object testDividendCalculationFinal(@RequestParam(value = "dd", required = false) Integer day,
                                               @RequestParam(value = "mm", required = false) Integer month,
                                               @RequestParam(value = "yyyy", required = false) Integer year,
                                               @RequestParam(value = "PayoutFrequency", required = false) ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testFixedDividendCalculationFinal(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend/flexible", method = RequestMethod.GET)
    @ResponseBody
    public Object testFlexibleDividendCalculation(@RequestParam(value = "dd", required = false) Integer day,
                                                  @RequestParam(value = "mm", required = false) Integer month,
                                                  @RequestParam(value = "yyyy", required = false) Integer year,
                                                  @RequestParam(value = "PayoutFrequency", required = false) ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            LocalDate today;

            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testFlexibleDividendCalculation(today, frequencyOfPayout);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agency-monthly-commission", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgencyMonthlyCommission(@RequestParam(value = "dd", required = false) Integer day,
                                              @RequestParam(value = "mm", required = false) Integer month,
                                              @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testAgencyMonthlyCommission(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agency-yearly-commission", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgencyYearlyCommission(@RequestParam(value = "dd", required = false) Integer day,
                                             @RequestParam(value = "mm", required = false) Integer month,
                                             @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testAgencyYearlyCommission(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @Operation(summary = "This doesn't recalculate the commission, just regenerate the excel file. Need to set generated_commission_file to false in commission_calculation_history table to allow regeneration.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/regenerate-agent-commission-file", method = RequestMethod.GET)
    @ResponseBody
    public Object regenerateAgentCommissionFile(@RequestParam(value = "dd", required = false) Integer day,
                                                @RequestParam(value = "mm", required = false) Integer month,
                                                @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.regenerateAgentCommissionFile(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }


    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent-monthly-commission", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgentMonthlyCommission(@RequestParam(value = "dd", required = false) Integer day,
                                             @RequestParam(value = "mm", required = false) Integer month,
                                             @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testAgentMonthlyCommission(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent-yearly-commission", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgentYearlyCommission(@RequestParam(value = "dd", required = false) Integer day,
                                            @RequestParam(value = "mm", required = false) Integer month,
                                            @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            return testService.testAgentYearlyCommission(today);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/profit-sharing-schedule", method = RequestMethod.GET)
    @ResponseBody
    public Object testProfitSharingSchedule(@RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return testService.testGenerateProfitSharingSchedule(orderReferenceNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend-by-product-order", method = RequestMethod.GET)
    @ResponseBody
    public Object testDividendCalculationByProductOrder(@RequestParam(value = "dd") Integer day,
                                                        @RequestParam(value = "mm") Integer month,
                                                        @RequestParam(value = "yyyy") Integer year,
                                                        @RequestParam(value = "orderReferenceNumber") String orderReferenceNumber,
                                                        @RequestParam(value = "isFinal", required = false) Boolean isFinal) {
        try {
            LocalDate today = LocalDate.of(year, month, day);
            if (isFinal == null) {
                isFinal = false;
            }
            if (isFinal) {
                return testService.testFinalDividendCalculationByProductOrder(today, orderReferenceNumber);
            } else {
                return testService.testDividendCalculationByProductOrder(today, orderReferenceNumber);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend-excel", method = RequestMethod.GET)
    @ResponseBody
    public Object testGenerateDividendExcelByProductOrder(@RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return testService.testGenerateDividendExcelByProductOrder(orderReferenceNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend-excel", method = RequestMethod.POST)
    @ResponseBody
    public Object testGenerateDividendExcelByProductDividendCalculationHistory(@RequestBody TestIDRequest request) {
        try {
            return testService.testGenerateDividendExcelByProductDividendCalculationHistoryIds(request.getLongIds());
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/dividend-excel-save", method = RequestMethod.POST)
    @ResponseBody
    public Object testGenerateDividendExcelByProductDividendCalculationHistory2(@RequestBody TestIDRequest request) {
        try {
            return testService.testGenerateDividendExcelAndSave(request.getLongIds());
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/agent-upline", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgentUpLine(@RequestParam(value = "agentId") Long agentId) {
        try {
            return testService.testAgentUpLineMap(agentId);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @Parameter(in = ParameterIn.HEADER, required = true, name = "apiKey")
    @CrossOrigin("*")
    @RequestMapping(value = "/agent-commission-report-v1", method = RequestMethod.GET)
    @ResponseBody
    public Object testAgentCommissionReport(HttpServletRequest httpServletRequest,
                                            @RequestParam(value = "agentId", required = false) String agentId,
                                            @RequestParam(value = "month", required = false) Integer month,
                                            @RequestParam(value = "year", required = false) Integer year) {
        try {
            return agentService.getAgentCommissionMonthlyReport(HttpHeader.getApiKey(httpServletRequest), agentId, month, year);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/product-order/soa", method = RequestMethod.GET)
    @ResponseBody
    public Object testProductOrderSOA(@RequestParam(value = "orderReferenceNumber") String orderReferenceNumber) {
        try {
            return testService.testProductOrderSOA(orderReferenceNumber);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }

    @ApiResponses(value = {
            @ApiResponse(responseCode = SUCCESS, content = @Content(schema = @Schema(implementation = BaseResp.class))),
            @ApiResponse(responseCode = ERROR_EXCEPTION, content = @Content(schema = @Schema(implementation = ErrorResp.class)))
    })
    @CrossOrigin("*")
    @RequestMapping(value = "/cron/reminder/physical-trust-deed", method = RequestMethod.GET)
    @ResponseBody
    public Object testCronPhysicalTrustDeedReminder(@RequestParam(value = "dd", required = false) Integer day,
                                                    @RequestParam(value = "mm", required = false) Integer month,
                                                    @RequestParam(value = "yyyy", required = false) Integer year) {
        try {
            LocalDate today;
            // If all parameters are provided, use them to create the date
            if (day != null && month != null && year != null) {
                today = LocalDate.of(year, month, day);
            } else {
                today = LocalDate.now(); // Default to the current date
            }
            backendService.cronPhysicalTrustDeedReminder(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorException(e);
        }
    }
}
