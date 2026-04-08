package com.citadel.backend.service;

import com.citadel.backend.dao.SettingDao;
import com.citadel.backend.entity.Products.ProductDividendCalculationHistory;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.DateUtil;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.*;
import com.citadel.backend.vo.Commission.CommissionExcelVo;
import jakarta.annotation.Resource;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ExcelService extends BaseService {

    @Resource
    private SettingDao settingDao;

    private static final String AFFIN_BANK_TEMPLATE_KEY = "admin.affin.bank.template";
    private static final String AFFIN_BANK_TEMPLATE_FILE_NAME = "affin-bank-template";
    private static final String CIMB_BANK_COMMISSION_TEMPLATE_KEY = "admin.cimb.bank.excel.commission.template";
    private static final String CIMB_BANK_COMMISSION_TEMPLATE_FILE_NAME = "cimb-bank-commission-template";
    private static final String CIMB_BANK_DIVIDEND_TEMPLATE_KEY = "admin.cimb.bank.excel.dividend.template";
    private static final String CIMB_BANK_DIVIDEND_TEMPLATE_FILE_NAME = "cimb-bank-dividend-template";

    private final SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    public enum ParseStrategy {
        COLUMN_ORDER,
        COLUMN_NAME
    }

    public <T> List<T> parseExcelFileFromS3ToVoClass(String s3Key, String fileNameWithoutExtension, Class<T> clazz, ParseStrategy strategy) throws Exception {
        String excelFilePath = AwsS3Util.downloadFile(s3Key, fileNameWithoutExtension);
        if (StringUtil.isEmpty(excelFilePath)) {
            throw new GeneralException("Failed to download file from S3. Returned null path.");
        }

        log.info("Local Excel file downloaded at: {} for {}", excelFilePath, clazz.getSimpleName());

        try (FileInputStream fis = new FileInputStream(excelFilePath);
             Workbook workbook = WorkbookFactory.create(fis)) {

            Sheet sheet = workbook.getSheetAt(0);

            // Parse Excel rows into a list of objects of type T
            List<T> records = new ArrayList<>();
            if (ParseStrategy.COLUMN_NAME.equals(strategy)) {
                records = ExcelUtils.parseExcelToBean(sheet, clazz);
            }
            if (ParseStrategy.COLUMN_ORDER.equals(strategy)) {
                records = ExcelUtils.parseExcelToBeanByColumnOrder(sheet, clazz);
            }

            log.info("Successfully parsed {} records from Excel file for {}", records.size(), clazz.getSimpleName());
            return records;
        }
    }

    //----------------------------------------Dividend----------------------------------------

    /**
     * Generate Dividend Excel file
     * @param productDividendCalculationHistoryList Dividend calculation history list
     * @param fileNameWithoutExt File name without extension
     * @return Generated Excel file
     */
    public File generateDividendExcel(List<ProductDividendCalculationHistory> productDividendCalculationHistoryList, String fileNameWithoutExt) throws Exception {
        String fileName = StringUtil.isNotEmpty(fileNameWithoutExt) ? fileNameWithoutExt : "dividend-excel-" + System.currentTimeMillis();
        String excelFilePath = getTempDir() + fileName + ".xlsx";

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Dividend Data");

            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] headers = {
                    "Reference Number",
                    "Closing Date",
                    "Client name",
                    "Digital ID",
                    "Agreement No",
                    "Fund Amount",
                    "Dividend",
                    "Percentage",
                    "Trustee Fee",
                    "Bank Name",
                    "Bank Account Number",
                    "Bank Account Name"
            };

            // Apply header styles
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            // Create header cells
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Create data rows
            int rowNum = 1;
            for (ProductDividendCalculationHistory history : productDividendCalculationHistoryList) {
                try {
                    Row row = sheet.createRow(rowNum++);

                    row.createCell(0).setCellValue(history.getReferenceNumber());
                    row.createCell(1).setCellValue(sdf.format(DateUtil.convertLocalDateToDate(history.getPeriodEndingDate())));
                    row.createCell(2).setCellValue(
                            history.getProductOrder().getClient() != null
                                    ? history.getProductOrder().getClient().getUserDetail().getName()
                                    : history.getProductOrder().getCorporateClient().getClient().getUserDetail().getName()
                    );

                    row.createCell(3).setCellValue(
                            history.getProductOrder().getClient() != null
                                    ? history.getProductOrder().getClient().getClientId()
                                    : history.getProductOrder().getCorporateClient().getClient().getClientId()
                    );

                    row.createCell(4).setCellValue(history.getProductOrder().getAgreementFileName());

                    // Format currency cells
                    CellStyle currencyStyle = workbook.createCellStyle();
                    DataFormat format = workbook.createDataFormat();
                    currencyStyle.setDataFormat(format.getFormat("#,##0"));

                    // Fund Amount
                    Cell fundAmountCell = row.createCell(5);
                    fundAmountCell.setCellValue(history.getProductOrder().getPurchasedAmount());
                    fundAmountCell.setCellStyle(currencyStyle);

                    // Dividend Amount
                    Cell dividendCell = row.createCell(6);
                    dividendCell.setCellValue(history.getDividendAmount());
                    dividendCell.setCellStyle(currencyStyle);

                    // Dividend Percentage
                    CellStyle percentStyle = workbook.createCellStyle();
                    percentStyle.setDataFormat(format.getFormat("0.00"));

                    Cell percentCell = row.createCell(7);
                    percentCell.setCellValue(history.getProductOrder().getDividend());
                    percentCell.setCellStyle(percentStyle);

                    //Trustee fee
                    Cell trusteeFeeCell = row.createCell(8);
                    trusteeFeeCell.setCellValue(history.getTrusteeFeeAmount());
                    trusteeFeeCell.setCellStyle(currencyStyle);

                    row.createCell(9).setCellValue(history.getProductOrder().getBank().getBankName());
                    row.createCell(10).setCellValue(history.getProductOrder().getBank().getAccountNumber());
                    row.createCell(11).setCellValue(history.getProductOrder().getBank().getAccountHolderName());
                } catch (Exception ex) {
                    log.error("Error in generateDividendExcel", ex);
                }
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(excelFilePath)) {
                workbook.write(fileOut);
            }
        }

        return new File(excelFilePath);
    }

    //----------------------------------------Commission----------------------------------------

    public File generateCommissionExcel(List<CommissionExcelVo> commissionVoList, String fileNameWithoutExt) throws Exception {
        String fileName = StringUtil.isNotEmpty(fileNameWithoutExt) ? fileNameWithoutExt : "commission-excel-" + System.currentTimeMillis();
        String excelFilePath = getTempDir() + fileName + ".xlsx";

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Commission Data");

            // Create header row
            Row headerRow = sheet.createRow(0);
            String[] headers = {
                    "Reference Number",
                    "Date of Submission",
                    "Payout Date",
                    "Agreement Date",
                    "Client name",
                    "Agreement Number",
                    "Investment Amount in MYR",
                    "Agency ID",
                    "Agent",
                    "Agent ID",
                    "Position",
                    "Amount",
                    "%",
                    "P2P/A.Mgr",
                    "Agent ID",
                    "Amount",
                    "%",
                    "SM",
                    "Agent ID",
                    "Amount",
                    "%",
                    "AVP",
                    "Agent ID",
                    "Amount",
                    "%",
                    "VP/HOS",
                    "Agent ID",
                    "Amount",
                    "%",
                    "SVP",
                    "Agent ID",
                    "%",
                    "SVP",
                    "Agent ID",
                    "%",
                    "TOTAL",
                    "Remark"
            };

            // Apply header styles
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            // Create header cells
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Create data rows
            int rowNum = 1;
            for (CommissionExcelVo commissionVo : commissionVoList) {
                try {
                    // Format currency cells
                    CellStyle currencyStyle = workbook.createCellStyle();
                    DataFormat format = workbook.createDataFormat();
                    currencyStyle.setDataFormat(format.getFormat("#,##0"));

                    // Format percentage cell
                    CellStyle percentStyle = workbook.createCellStyle();
                    percentStyle.setDataFormat(format.getFormat("0.00"));

                    Row row = sheet.createRow(rowNum++);

                    row.createCell(0).setCellValue(commissionVo.getReferenceNumber());
                    row.createCell(1).setCellValue(sdf.format(commissionVo.getDateOfSubmission()));
                    row.createCell(2).setCellValue(sdf.format(commissionVo.getPayoutDate()));
                    row.createCell(3).setCellValue(sdf.format(DateUtil.convertLocalDateToDate(commissionVo.getAgreementDate())));
                    row.createCell(4).setCellValue(commissionVo.getClientName());
                    row.createCell(5).setCellValue(commissionVo.getAgreementFileName());

                    Cell investmentAmountCell = row.createCell(6);
                    investmentAmountCell.setCellValue(commissionVo.getPurchasedAmount());
                    investmentAmountCell.setCellStyle(currencyStyle);
                    //Agency ID
                    row.createCell(7).setCellValue(commissionVo.getAgencyId());
                    //MGR Name
                    row.createCell(8).setCellValue(commissionVo.getAgentName());
                    //MGR AgentID
                    row.createCell(9).setCellValue(commissionVo.getMgrAgentId());
                    //MGR Position
                    row.createCell(10).setCellValue(commissionVo.getAgentPosition());
                    //MGR Commission AMount
                    Cell agentCommissionAmount = row.createCell(11);
                    agentCommissionAmount.setCellValue(commissionVo.getAgentCommissionAmount());
                    agentCommissionAmount.setCellStyle(currencyStyle);
                    //MGR Commission Percentage
                    Cell agentCommissionPercentage = row.createCell(12);
                    agentCommissionPercentage.setCellValue(commissionVo.getAgentCommissionRate());
                    agentCommissionPercentage.setCellStyle(percentStyle);

                    //P2P Name
                    row.createCell(13).setCellValue(commissionVo.getP2pName());
                    //P2P AgentID
                    row.createCell(14).setCellValue(commissionVo.getP2pAgentId());
                    //P2P Commission Amount
                    Cell p2pCommissionAmount = row.createCell(15);
                    p2pCommissionAmount.setCellValue(commissionVo.getP2pCommissionAmount());
                    p2pCommissionAmount.setCellStyle(currencyStyle);
                    //P2P Commission Percentage
                    Cell p2pCommissionPercentage = row.createCell(16);
                    p2pCommissionPercentage.setCellValue(commissionVo.getP2pCommissionRate());
                    p2pCommissionPercentage.setCellStyle(percentStyle);

                    //SM Name
                    row.createCell(17).setCellValue(commissionVo.getSmName());
                    //SM AgentID
                    row.createCell(18).setCellValue(commissionVo.getSmAgentId());
                    //SM Commission Amount
                    Cell smCommissionAmount = row.createCell(19);
                    smCommissionAmount.setCellValue(commissionVo.getSmCommissionAmount());
                    smCommissionAmount.setCellStyle(currencyStyle);
                    //SM Commission Percentage
                    Cell smCommissionPercentage = row.createCell(20);
                    smCommissionPercentage.setCellValue(commissionVo.getSmCommissionRate());
                    smCommissionPercentage.setCellStyle(percentStyle);

                    //AVP Name
                    row.createCell(21).setCellValue(commissionVo.getAvpName());
                    //AVP AgentID
                    row.createCell(22).setCellValue(commissionVo.getAvpAgentId());
                    //AVP Commission Amount
                    Cell avpCommissionAmount = row.createCell(23);
                    avpCommissionAmount.setCellValue(commissionVo.getAvpCommissionAmount());
                    avpCommissionAmount.setCellStyle(currencyStyle);
                    //AVP Commission Percentage
                    Cell avpCommissionPercentage = row.createCell(24);
                    avpCommissionPercentage.setCellValue(commissionVo.getAvpCommissionRate());
                    avpCommissionPercentage.setCellStyle(percentStyle);

                    //VP Name
                    row.createCell(25).setCellValue(commissionVo.getVpName());
                    //VP AgentID
                    row.createCell(26).setCellValue(commissionVo.getVpAgentId());
                    //VP Commission Amount
                    Cell vpCommissionAmount = row.createCell(27);
                    vpCommissionAmount.setCellValue(commissionVo.getVpCommissionAmount());
                    vpCommissionAmount.setCellStyle(currencyStyle);
                    //VP Commission Percentage
                    Cell vpCommissionPercentage = row.createCell(28);
                    vpCommissionPercentage.setCellValue(commissionVo.getVpCommissionRate());
                    vpCommissionPercentage.setCellStyle(percentStyle);

                    //SVP 1 Name
                    row.createCell(29).setCellValue(commissionVo.getSvp1Name());
                    //SVP 1 AgentID
                    row.createCell(30).setCellValue(commissionVo.getSvp1AgentId());
                    //SVP 1 Commission Percentage
                    Cell svpCommissionPercentage = row.createCell(31);
                    svpCommissionPercentage.setCellValue(0.0);
                    svpCommissionPercentage.setCellStyle(percentStyle);

                    //SVP 2 Name
                    row.createCell(32).setCellValue("");
                    //SVP 2 AgentID
                    row.createCell(33).setCellValue("");
                    //SVP 2 Commission Percentage
                    Cell svpCommissionPercentage2 = row.createCell(34);
                    svpCommissionPercentage2.setCellValue(0.0);
                    svpCommissionPercentage2.setCellStyle(percentStyle);
                    //Total
                    Cell totalCommissionPercentage = row.createCell(35);
                    totalCommissionPercentage.setCellValue(commissionVo.getTotalCommissionRate());
                    totalCommissionPercentage.setCellStyle(percentStyle);
                    //Remark
                    row.createCell(36).setCellValue(commissionVo.getRemark());
                } catch (Exception ex) {
                    log.error("Error in {}", getFunctionName(), ex);
                }
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write to file
            try (FileOutputStream fileOut = new FileOutputStream(excelFilePath)) {
                workbook.write(fileOut);
            }
        }

        return new File(excelFilePath);
    }

    //----------------------------------------Bank File----------------------------------------

    public File generateCIMBBankFileExcel(List<CimbBankVo> cimbBankVoList, CimbBankVo.TYPE type) throws IOException {
        if (cimbBankVoList == null || cimbBankVoList.isEmpty()) {
            return new File("");
        }
        if (type == null) {
            type = CimbBankVo.TYPE.DIVIDEND;//Default
        }
        String templateKey = CIMB_BANK_DIVIDEND_TEMPLATE_KEY;
        String templateFileName = CIMB_BANK_DIVIDEND_TEMPLATE_FILE_NAME;
        if (type.equals(CimbBankVo.TYPE.COMMISSION)) {
            templateKey = CIMB_BANK_COMMISSION_TEMPLATE_KEY;
            templateFileName = CIMB_BANK_COMMISSION_TEMPLATE_FILE_NAME;
        }
        if (type.equals(CimbBankVo.TYPE.REDEMPTION)) {
            templateKey = CIMB_BANK_DIVIDEND_TEMPLATE_KEY;
            templateFileName = CIMB_BANK_DIVIDEND_TEMPLATE_FILE_NAME;
        }

        String baseDir = Paths.get(getTempDir(), "downloads").toString();
        String templateFilePath = Paths.get(baseDir, templateFileName + ".xlsx").toString();

        //check if file exist in temp directory if not then only download from s3
        File templateFile = new File(templateFilePath);
        if (!templateFile.exists()) {
            String s3Key = settingDao.findByKey(templateKey).getValue();
            s3Key = StringUtil.extractDownloadLinkFromCmsContent(s3Key);
            if (StringUtil.isNotEmpty(s3Key)) {
                String downloadedExcelFilePath = AwsS3Util.downloadFile(s3Key, templateFileName);
                if (StringUtil.isNotEmpty(downloadedExcelFilePath)) {
                    templateFilePath = downloadedExcelFilePath;
                }
            }
        }

        String excelFilePath = getTempDir() + "cimb-bank-file-excel-" + System.currentTimeMillis() + ".xlsx";

        try (FileInputStream fis = new FileInputStream(templateFilePath);
             Workbook workbook = WorkbookFactory.create(fis)) {

            Sheet sheet = workbook.getSheetAt(2);//Bulk Payments - With Email (Dividend)
            if (type.equals(CimbBankVo.TYPE.COMMISSION)) {
                sheet = workbook.getSheetAt(3);//Bulk Payments - Without Email
            }

            // Use a dedicated row as a style reference.
            // Here we assume row 2 contains the desired formatting (borders, colors, dropdowns, etc.).
            int dataStyleRowIndex = 3;
            Map<Integer, CellStyle> columnStyles = new HashMap<>();
            Row styleRow = sheet.getRow(dataStyleRowIndex);
            if (styleRow != null) {
                for (int j = 0; j < styleRow.getLastCellNum(); j++) {
                    Cell cell = styleRow.getCell(j);
                    if (cell != null && cell.getCellStyle() != null) {
                        // Clone the style to use it for new cells.
                        CellStyle clonedStyle = workbook.createCellStyle();
                        clonedStyle.cloneStyleFrom(cell.getCellStyle());
                        columnStyles.put(j, clonedStyle);
                    }
                }
            } else {
                // Fallback: use header row (assumed at row index 1) as style reference.
                Row headerRow = sheet.getRow(2);
                if (headerRow != null) {
                    for (int j = 0; j < headerRow.getLastCellNum(); j++) {
                        Cell cell = headerRow.getCell(j);
                        if (cell != null && cell.getCellStyle() != null) {
                            CellStyle clonedStyle = workbook.createCellStyle();
                            clonedStyle.cloneStyleFrom(cell.getCellStyle());
                            columnStyles.put(j, clonedStyle);
                        }
                    }
                }
            }

            // Remove any existing rows beyond the header rows (assume rows 0 and 1 are static).
            int dataStartRow = 3;
            for (int i = sheet.getLastRowNum(); i >= dataStartRow; i--) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    sheet.removeRow(row);
                }
            }

            // Determine total number of columns from the header row.
            int totalColumns = sheet.getRow(2).getLastCellNum();

            // Add new data rows starting at row index 2.
            int rowNum = dataStartRow;
            for (CimbBankVo record : cimbBankVoList) {
                // Payment Record Row
                Row paymentRow = sheet.createRow(rowNum++);
                List<String> paymentValues = new ArrayList<>();
                if (type.equals(CimbBankVo.TYPE.DIVIDEND)) {
                    paymentValues = record.getDividendRecordRow();
                } else if (type.equals(CimbBankVo.TYPE.COMMISSION)) {
                    paymentValues = record.getCommissionRecordRow();
                }
                for (int col = 0; col < totalColumns; col++) {
                    Cell cell = paymentRow.createCell(col);
                    String value = (col < paymentValues.size()) ? paymentValues.get(col) : "";
                    cell.setCellValue(value);
                    if (columnStyles.containsKey(col)) {
                        cell.setCellStyle(columnStyles.get(col));
                    }
                }
            }

            // Write the workbook to the output file.
            try (FileOutputStream fos = new FileOutputStream(excelFilePath)) {
                workbook.write(fos);
            }
            return new File(excelFilePath);
        }
    }

    public File generateAFFINBankFileExcel(List<AffinBankVo> affinBankVoList) throws IOException {
        if (affinBankVoList == null || affinBankVoList.isEmpty()) {
            return new File("");
        }

        String baseDir = Paths.get(getTempDir(), "downloads").toString();
        String templateFilePath = Paths.get(baseDir, AFFIN_BANK_TEMPLATE_FILE_NAME + ".xlsx").toString();

        //check if file exist in temp directory if not then only download from s3
        File templateFile = new File(templateFilePath);
        if (!templateFile.exists()) {
            String s3Key = settingDao.findByKey(AFFIN_BANK_TEMPLATE_KEY).getValue();
            s3Key = StringUtil.extractDownloadLinkFromCmsContent(s3Key);
            if (StringUtil.isNotEmpty(s3Key)) {
                String downloadedExcelFilePath = AwsS3Util.downloadFile(s3Key, AFFIN_BANK_TEMPLATE_FILE_NAME);
                if (StringUtil.isNotEmpty(downloadedExcelFilePath)) {
                    templateFilePath = downloadedExcelFilePath;
                }
            }
        }

        String excelFilePath = getTempDir() + "affin-bank-file-excel-" + System.currentTimeMillis() + ".xlsx";

        try (FileInputStream fis = new FileInputStream(templateFilePath);
             Workbook workbook = WorkbookFactory.create(fis)) {

            Sheet sheet = workbook.getSheetAt(0);

            // Use a dedicated row as a style reference.
            // Here we assume row 2 contains the desired formatting (borders, colors, dropdowns, etc.).
            int dataStyleRowIndex = 2;
            Map<Integer, CellStyle> columnStyles = new HashMap<>();
            Row styleRow = sheet.getRow(dataStyleRowIndex);
            if (styleRow != null) {
                for (int j = 0; j < styleRow.getLastCellNum(); j++) {
                    Cell cell = styleRow.getCell(j);
                    if (cell != null && cell.getCellStyle() != null) {
                        // Clone the style to use it for new cells.
                        CellStyle clonedStyle = workbook.createCellStyle();
                        clonedStyle.cloneStyleFrom(cell.getCellStyle());
                        columnStyles.put(j, clonedStyle);
                    }
                }
            } else {
                // Fallback: use header row (assumed at row index 1) as style reference.
                Row headerRow = sheet.getRow(1);
                if (headerRow != null) {
                    for (int j = 0; j < headerRow.getLastCellNum(); j++) {
                        Cell cell = headerRow.getCell(j);
                        if (cell != null && cell.getCellStyle() != null) {
                            CellStyle clonedStyle = workbook.createCellStyle();
                            clonedStyle.cloneStyleFrom(cell.getCellStyle());
                            columnStyles.put(j, clonedStyle);
                        }
                    }
                }
            }

            // Remove any existing rows beyond the header rows (assume rows 0 and 1 are static).
            int dataStartRow = 2;
            for (int i = sheet.getLastRowNum(); i >= dataStartRow; i--) {
                Row row = sheet.getRow(i);
                if (row != null) {
                    sheet.removeRow(row);
                }
            }

            // Determine total number of columns from the header row.
            int totalColumns = sheet.getRow(1).getLastCellNum();

            // Track summary information.
            int sumOfRecords = 0;
            double sumOfAmounts = 0.0;

            // Add new data rows starting at row index 2.
            int rowNum = dataStartRow;
            for (AffinBankVo record : affinBankVoList) {
                // Payment Record Row
                Row paymentRow = sheet.createRow(rowNum++);
                List<String> paymentValues = record.getPaymentRecordRow();
                for (int col = 0; col < totalColumns; col++) {
                    Cell cell = paymentRow.createCell(col);
                    String value = (col < paymentValues.size()) ? paymentValues.get(col) : "";
                    cell.setCellValue(value);
                    if (columnStyles.containsKey(col)) {
                        cell.setCellStyle(columnStyles.get(col));
                    }
                }

                // Payment Advice Row
                Row adviceRow = sheet.createRow(rowNum++);
                List<String> adviceValues = record.getPaymentAdviceRow();
                for (int col = 0; col < totalColumns; col++) {
                    Cell cell = adviceRow.createCell(col);
                    String value = (col < adviceValues.size()) ? adviceValues.get(col) : "";
                    cell.setCellValue(value);
                    if (columnStyles.containsKey(col)) {
                        cell.setCellStyle(columnStyles.get(col));
                    }
                }

                sumOfRecords++;
                sumOfAmounts += record.getColERowOnePaymentAmount();
            }

            // Create summary row.
            Row summaryRow = sheet.createRow(rowNum);
            for (int col = 0; col < totalColumns; col++) {
                Cell cell = summaryRow.createCell(col);
                switch (col) {
                    case 0:
                        cell.setCellValue(AffinBankUtil.RecordTypeSummaryRow);
                        break;
                    case 1:
                        cell.setCellValue(String.valueOf(sumOfRecords));
                        break;
                    case 2:
                        cell.setCellValue(String.format("%.2f", sumOfAmounts));
                        break;
                    default:
                        cell.setCellValue("");
                        break;
                }
                if (columnStyles.containsKey(col)) {
                    cell.setCellStyle(columnStyles.get(col));
                }
            }

            // Write the workbook to the output file.
            try (FileOutputStream fos = new FileOutputStream(excelFilePath)) {
                workbook.write(fos);
            }
            return new File(excelFilePath);
        }
    }
} 