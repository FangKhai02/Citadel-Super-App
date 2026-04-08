package com.citadel.backend.service;

import com.citadel.backend.dao.AgencyDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Commission.AgentCommissionCalculationHistoryDao;
import com.citadel.backend.dao.Products.ProductDividendCalculationHistoryDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.dao.UserDetailDao;
import com.citadel.backend.entity.Client;
import com.citadel.backend.entity.Products.ProductDividendCalculationHistory;
import com.citadel.backend.entity.Products.ProductDividendSchedule;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.entity.UserDetail;
import com.citadel.backend.utils.AwsS3Util;
import com.citadel.backend.utils.BaseService;
import com.citadel.backend.utils.StringUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Commission.AgentUpLineVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static com.citadel.backend.utils.ApiErrorKey.PRODUCT_ORDER_NOT_FOUND;

@Service
public class TestService extends BaseService {

    @Resource
    private UserDetailDao userDetailDao;
    @Resource
    private EmailService emailService;
    @Resource
    private ClientDao clientDao;
    @Resource
    private DividendService dividendService;
    @Resource
    private CommissionService.AgencyCommissionService agencyCommissionService;
    @Resource
    private CommissionService.AgentCommissionService agentCommissionService;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductDividendCalculationHistoryDao productDividendCalculationHistoryDao;
    @Resource
    private CSVService csvService;
    @Resource
    private AgentCommissionCalculationHistoryDao agentCommissionCalculationHistoryDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private AgentService agentService;
    @Resource
    ExcelService excelService;
    @Resource
    private ProductService productService;
    @Resource
    private CommissionService commissionService;

    public Object testSendEmail() {
        try {
            String ic = "D1234567";
            UserDetail userDetail = userDetailDao.findByIdentityCardNumber(ic);
            Client client = clientDao.findByUserDetailAndStatusIsTrue(userDetail);
            String pdfKey = emailService.sendOnboardingAgreementEmail(client, "0001");
            userDetail.setOnboardingAgreementKey(pdfKey);
            userDetailDao.save(userDetail);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to send email " + e.getMessage());
        }
    }

    public Object testFixedDividendCalculation(LocalDate today, ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            return dividendService.processFixedDividendCalculation(today, frequencyOfPayout);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate dividend " + e.getMessage());
        }
    }

    public Object testFixedDividendCalculationFinal(LocalDate today) {
        return dividendService.processFinalFixedDividendCalculation(today);
    }

    public Object testFlexibleDividendCalculation(LocalDate today, ProductDividendSchedule.FrequencyOfPayout frequencyOfPayout) {
        try {
            return dividendService.processFlexibleDividendCalculation(today, frequencyOfPayout);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate dividend " + e.getMessage());
        }
    }

    public Object testAgencyMonthlyCommission(LocalDate today) {
        try {
            agencyCommissionService.processAgencyMonthlyCommission(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate agency commission " + e.getMessage());
        }
    }

    public Object testAgencyYearlyCommission(LocalDate today) {
        try {
            agencyCommissionService.processAgencyYearlyCommission(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate agency commission " + e.getMessage());
        }
    }

    public Object regenerateAgentCommissionFile(LocalDate today) {
        try {
            commissionService.generateCommissionExcel(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate agency commission " + e.getMessage());
        }
    }

    public Object testAgentMonthlyCommission(LocalDate today) {
        try {
            agentCommissionService.processAgentMonthlyCommission(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate agent commission " + e.getMessage());
        }
    }

    public Object testAgentYearlyCommission(LocalDate today) {
        try {
            agentCommissionService.processAgentYearlyCommission(today);
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to calculate agent commission " + e.getMessage());
        }
    }

    public Object testGenerateProfitSharingSchedule(String orderReferenceNumber) {
        try {
            productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).ifPresent(productOrder -> {
                dividendService.generateProfitSharingSchedule(productOrder);
            });
            return new BaseResp();
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to generate profit sharing schedule " + e.getMessage());
        }
    }

    public Object testDividendCalculationByProductOrder(LocalDate today, String orderReferenceNumber) {
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            JSONArray jsonArray = new JSONArray();
            if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                JSONObject jsonObject = dividendService.processFixedDividendCalculationByProductOrder(today, productOrder, new ArrayList<>());
                jsonArray.put(jsonObject);
            }
            if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                JSONObject jsonObject = dividendService.processFlexibleDividendCalculationByProductOrder(today, productOrder, new ArrayList<>());
                jsonArray.put(jsonObject);
            }
            BaseResp resp = new BaseResp();
            resp.setMessage(jsonArray.toString().replace("\\", ""));
            return resp;
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to generate profit sharing schedule " + e.getMessage());
        }
    }

    public Object testFinalDividendCalculationByProductOrder(LocalDate today, String orderReferenceNumber) {
        try {
            JSONArray jsonArray = new JSONArray();
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            JSONObject jsonObject = dividendService.processFinalFixedDividendCalculationByProductOrder(today, productOrder, new ArrayList<>());
            jsonArray.put(jsonObject);
            BaseResp resp = new BaseResp();
            resp.setMessage(jsonArray.toString().replace("\\", ""));
            return resp;
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to generate profit sharing schedule " + e.getMessage());
        }
    }

    public Object testGenerateDividendExcelByProductOrder(String orderReferenceNumber) {
        try {
            BaseResp resp = new BaseResp();
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            List<ProductDividendCalculationHistory> historyList = productDividendCalculationHistoryDao.findAllByProductOrderOrderByIdAsc(productOrder);
            if (historyList.isEmpty()) {
                resp.setMessage("No dividend calculation history found for order reference number " + orderReferenceNumber);
                return resp;
            }
            File dividendExcelFile = excelService.generateDividendExcel(historyList, orderReferenceNumber);
            String s3FilePath = S3_DIVIDEND_EXCEL_DOCUMENT_PATH + "test-dividend/" + orderReferenceNumber + "/" + System.currentTimeMillis() + ".xlsx";
            AwsS3Util.uploadFile(dividendExcelFile, s3FilePath, false);
            String awsS3Url = AwsS3Util.getS3DownloadUrl(s3FilePath);
            resp.setMessage(awsS3Url);
            return resp;
        } catch (Exception ex) {
            log.error("Error in testGenerateDividendExcelByProductOrder", ex);
            return getErrorObjectWithMsg("Failed to generate dividend Excel " + ex.getMessage());
        }
    }

    public Object testGenerateDividendExcelByProductDividendCalculationHistoryIds(List<Long> ids) {
        try {
            if (ids == null || ids.isEmpty()) {
                return getErrorObjectWithMsg("Product dividend calculation history ids cannot be empty");
            }
            BaseResp resp = new BaseResp();
            List<ProductDividendCalculationHistory> historyList = productDividendCalculationHistoryDao.findAllById(ids);
            File dividendExcelFile = excelService.generateDividendExcel(historyList, null);
            String s3FilePath = S3_DIVIDEND_EXCEL_DOCUMENT_PATH + "test-dividend/" + System.currentTimeMillis() + ".xlsx";
            AwsS3Util.uploadFile(dividendExcelFile, s3FilePath, false);
            String awsS3Url = AwsS3Util.getS3DownloadUrl(s3FilePath);
            resp.setMessage(awsS3Url);
            return resp;
        } catch (Exception ex) {
            log.error("Error in testGenerateDividendExcelByProductDividendCalculationHistoryId", ex);
            return getErrorObjectWithMsg("Failed to generate dividend Excel " + ex.getMessage());
        }
    }

    public Object testGenerateDividendExcelAndSave(List<Long> ids) {
        try {
            if (ids == null || ids.isEmpty()) {
                return getErrorObjectWithMsg("Product dividend calculation history ids cannot be empty");
            }
            BaseResp resp = new BaseResp();
            List<ProductDividendCalculationHistory> historyList = productDividendCalculationHistoryDao.findAllById(ids);
            dividendService.generateDividendExcel(historyList, null);
            return resp;
        } catch (Exception ex) {
            log.error("Error in testGenerateDividendExcelByProductDividendCalculationHistoryId", ex);
            return getErrorObjectWithMsg("Failed to generate dividend Excel " + ex.getMessage());
        }
    }

    public Object testAgentUpLineMap(Long id) {
        try {
            AgentUpLineVo vo = agentCommissionService.buildAgentUpLine(id);
            return gson.toJson(vo);
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to generate agent upline map " + e.getMessage());
        }
    }

    public Object testProductOrderSOA(String orderReferenceNumber) {
        try {
            ProductOrder productOrder = productOrderDao.findByOrderReferenceNumber(orderReferenceNumber).orElseThrow(() -> new GeneralException(PRODUCT_ORDER_NOT_FOUND));
            productService.generateStatementOfAccount(productOrder);

            return AwsS3Util.getS3DownloadUrl(productOrder.getSoaKey());
        } catch (Exception e) {
            e.printStackTrace();
            return getErrorObjectWithMsg("Failed to generate product order SOA " + e.getMessage());
        }
    }
}
