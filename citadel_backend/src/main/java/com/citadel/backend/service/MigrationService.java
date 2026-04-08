package com.citadel.backend.service;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Agent.AgentRoleSettingsDao;
import com.citadel.backend.dao.AppUser.AppUserDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Client.IndividualBeneficiaryDao;
import com.citadel.backend.dao.Client.IndividualBeneficiaryGuardianDao;
import com.citadel.backend.dao.Client.IndividualGuardianDao;
import com.citadel.backend.dao.Commission.AgencyCommissionCalculationHistoryDao;
import com.citadel.backend.dao.Commission.AgentCommissionCalculationHistoryDao;
import com.citadel.backend.dao.Commission.AgentCommissionConfigurationDao;
import com.citadel.backend.dao.Commission.AgentCommissionHistoryDao;
import com.citadel.backend.dao.Corporate.*;
import com.citadel.backend.dao.Products.*;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Commission.AgencyCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.AgentCommissionCalculationHistory;
import com.citadel.backend.entity.Commission.AgentCommissionHistory;
import com.citadel.backend.entity.Corporate.*;
import com.citadel.backend.entity.Products.*;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.Commission.AgentCommissionConfigurationVo;
import com.citadel.backend.vo.DigitalIDResultVo;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.Migration.*;
import com.citadel.backend.vo.QuarterVo;
import jakarta.annotation.Resource;
import jakarta.transaction.Transactional;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.time.LocalDate;
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Collectors;

import static com.citadel.backend.utils.ApiErrorKey.CLIENT_NOT_FOUND;
import static com.citadel.backend.utils.ApiErrorKey.INVALID_AGENCY_ID;
import static com.citadel.backend.utils.DigitalIDUtil.createDigitalID;

@SuppressWarnings({"LoggingSimilarMessage", "DuplicatedCode"})
@Service
public class MigrationService extends BaseService {

    @Resource
    private AppUserDao appUserDao;
    @Resource
    private UserDetailDao userDetailDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private AgentRoleSettingsDao agentRoleSettingsDao;
    @Resource
    private AgentDao agentDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    private PepInfoDao pepInfoDao;
    @Resource
    private SettingDao settingDao;
    @Resource
    private IndividualBeneficiaryDao individualBeneficiaryDao;
    @Resource
    private IndividualGuardianDao individualGuardianDao;
    @Resource
    private IndividualBeneficiaryGuardianDao individualBeneficiaryGuardianDao;
    @Resource
    private CorporateClientDao corporateClientDao;
    @Resource
    private CorporateDetailsDao corporateDetailsDao;
    @Resource
    private CorporateShareholderDao corporateShareholderDao;
    @Resource
    private CorporateShareholdersPivotDao corporateShareholdersPivotDao;
    @Resource
    private CorporateBeneficiaryDao corporateBeneficiaryDao;
    @Resource
    private CorporateGuardianDao corporateGuardianDao;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private ProductDividendScheduleDao productDividendScheduleDao;
    @Resource
    private ProductBeneficiariesDao productBeneficiariesDao;
    @Resource
    private ProductDividendCalculationHistoryDao productDividendCalculationHistoryDao;
    @Resource
    private AgentCommissionCalculationHistoryDao agentCommissionCalculationHistoryDao;
    @Resource
    private AgentCommissionConfigurationDao agentCommissionConfigurationDao;
    @Resource
    private AgentCommissionHistoryDao agentCommissionHistoryDao;
    @Resource
    private AgencyCommissionCalculationHistoryDao agencyCommissionCalculationHistoryDao;
    @Resource
    private ProductRedemptionDao productRedemptionDao;
    @Resource
    private ProductEarlyRedemptionHistoryDao productEarlyRedemptionHistoryDao;
    @Resource
    private ExcelStreamingUtil excelStreamingUtil;

    public Object createMigration(MigrationSheetReq req) {
        try {
            MigrationLogRespVo migrationLogRespVo = new MigrationLogRespVo();
            List<MigrationLogRespVo.Tab> tabAndContentList = new ArrayList<>();
            String s3url = StringUtil.extractDownloadLinkFromCmsContent(settingDao.findByKey("admin.data.migration.file").getValue());

            if (StringUtil.isEmpty(s3url)) {
                return getErrorObjectWithMsg("File URL is empty");
            }
            String fileNameWithoutExtension = "data_migration_" + System.currentTimeMillis();
            String excelFilePath = AwsS3Util.downloadFile(s3url, fileNameWithoutExtension);
            if (StringUtil.isEmpty(excelFilePath)) {
                throw new GeneralException("Failed to download file from S3. Returned null path.");
            }

            log.info("Local Excel file downloaded at: {}", excelFilePath);

            //Workbook workbook = readWorkbookFromFile(excelFilePath);
            List<Integer> sheetIndexList = req.getSheetIndexList();
            if (sheetIndexList == null || sheetIndexList.isEmpty()) {
                // Migrate/Update all sheets
                sheetIndexList = List.of(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23);
            }
            if (sheetIndexList.contains(3)) {
                MigrationLogRespVo.Tab agentTabAndContent = migrateAgent(excelFilePath);
                if (agentTabAndContent != null) {
                    tabAndContentList.add(agentTabAndContent);
                }
            }
            if (sheetIndexList.contains(4)) {
                MigrationLogRespVo.Tab agentUplineTabAndContent = migrateAgentUpLine(excelFilePath);
                if (agentUplineTabAndContent != null) {
                    tabAndContentList.add(agentUplineTabAndContent);
                }
            }
            if (sheetIndexList.contains(5)) {
                MigrationLogRespVo.Tab clientTabAndContent = migrateClient(excelFilePath);
                if (clientTabAndContent != null) {
                    tabAndContentList.add(clientTabAndContent);
                }
            }
            if (sheetIndexList.contains(6)) {
                MigrationLogRespVo.Tab clientBankAccountsTabAndContent = migrateClientBankAccounts(excelFilePath);
                if (clientBankAccountsTabAndContent != null) {
                    tabAndContentList.add(clientBankAccountsTabAndContent);
                }
            }
            if (sheetIndexList.contains(7)) {
                MigrationLogRespVo.Tab clientBeneficiariesTabAndContent = migrateClientBeneficiaries(excelFilePath);
                if (clientBeneficiariesTabAndContent != null) {
                    tabAndContentList.add(clientBeneficiariesTabAndContent);
                }
            }
            if (sheetIndexList.contains(8)) {
                MigrationLogRespVo.Tab clientGuardiansTabAndContent = migrateClientGuardians(excelFilePath);
                if (clientGuardiansTabAndContent != null) {
                    tabAndContentList.add(clientGuardiansTabAndContent);
                }
            }
            if (sheetIndexList.contains(9)) {
                MigrationLogRespVo.Tab clientBeneficiariesGuardiansTabAndContent = migrateClientBeneficiariesGuardians(excelFilePath);
                if (clientBeneficiariesGuardiansTabAndContent != null) {
                    tabAndContentList.add(clientBeneficiariesGuardiansTabAndContent);
                }
            }
            if (sheetIndexList.contains(10)) {
                MigrationLogRespVo.Tab corporateTabAndContent = migrateCorporate(excelFilePath);
                if (corporateTabAndContent != null) {
                    tabAndContentList.add(corporateTabAndContent);
                }
            }
            if (sheetIndexList.contains(11)) {
                MigrationLogRespVo.Tab corporateShareholdersTabAndContent = migrateCorporateShareholders(excelFilePath);
                if (corporateShareholdersTabAndContent != null) {
                    tabAndContentList.add(corporateShareholdersTabAndContent);
                }
            }
            if (sheetIndexList.contains(12)) {
                MigrationLogRespVo.Tab corporateBeneficiariesTabAndContent = migrateCorporateBeneficiaries(excelFilePath);
                if (corporateBeneficiariesTabAndContent != null) {
                    tabAndContentList.add(corporateBeneficiariesTabAndContent);
                }
            }
            if (sheetIndexList.contains(13)) {
                MigrationLogRespVo.Tab corporateGuardiansTabAndContent = migrateCorporateGuardians(excelFilePath);
                if (corporateGuardiansTabAndContent != null) {
                    tabAndContentList.add(corporateGuardiansTabAndContent);
                }
            }
            if (sheetIndexList.contains(14)) {
                MigrationLogRespVo.Tab corporateBeneficiariesGuardiansTabAndContent = migrateCorporateBeneficiariesGuardians(excelFilePath);
                if (corporateBeneficiariesGuardiansTabAndContent != null) {
                    tabAndContentList.add(corporateBeneficiariesGuardiansTabAndContent);
                }
            }
            if (sheetIndexList.contains(15)) {
                MigrationLogRespVo.Tab corporateBankAccountsTabAndContent = migrateCorporateBankAccounts(excelFilePath);
                if (corporateBankAccountsTabAndContent != null) {
                    tabAndContentList.add(corporateBankAccountsTabAndContent);
                }
            }
            if (sheetIndexList.contains(16)) {
                MigrationLogRespVo.Tab productOrderTabAndContent = migrateProductOder(excelFilePath);
                if (productOrderTabAndContent != null) {
                    tabAndContentList.add(productOrderTabAndContent);
                }
            }
            if (sheetIndexList.contains(17)) {
                MigrationLogRespVo.Tab productOrderBeneficiariesTabAndContent = migrateProductOrderBeneficiaries(excelFilePath);
                if (productOrderBeneficiariesTabAndContent != null) {
                    tabAndContentList.add(productOrderBeneficiariesTabAndContent);
                }
            }
            if (sheetIndexList.contains(19)) {
                MigrationLogRespVo.Tab productDividendCalculationHistoryTabAndContent = migrateProductDividendCalculationHistory(excelFilePath);
                if (productDividendCalculationHistoryTabAndContent != null) {
                    tabAndContentList.add(productDividendCalculationHistoryTabAndContent);
                }
            }
            if (sheetIndexList.contains(20)) {
                MigrationLogRespVo.Tab agentCommissionHistoryTabAndContent = migrateAgentCommissionHistory(excelFilePath);
                if (agentCommissionHistoryTabAndContent != null) {
                    tabAndContentList.add(agentCommissionHistoryTabAndContent);
                }
            }
            if (sheetIndexList.contains(21)) {
                MigrationLogRespVo.Tab agencyCommissionHistoryTabAndContent = migrateAgencyCommissionHistory(excelFilePath);
                if (agencyCommissionHistoryTabAndContent != null) {
                    tabAndContentList.add(agencyCommissionHistoryTabAndContent);
                }
            }
            if (sheetIndexList.contains(22)) {
                MigrationLogRespVo.Tab productRedemptionTabAndContent = migrateProductRedemption(excelFilePath);
                if (productRedemptionTabAndContent != null) {
                    tabAndContentList.add(productRedemptionTabAndContent);
                }
            }
            if (sheetIndexList.contains(23)) {
                MigrationLogRespVo.Tab productEarlyRedemptionTabAndContent = migrateProductEarlyRedemption(excelFilePath);
                if (productEarlyRedemptionTabAndContent != null) {
                    tabAndContentList.add(productEarlyRedemptionTabAndContent);
                }
            }
            migrationLogRespVo.setTabAndContentList(tabAndContentList);
            return migrationLogRespVo;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private Workbook readWorkbookFromFile(String excelFilePath) throws IOException {
        // Open the downloaded file as a FileInputStream and create a Workbook object
        try (FileInputStream fis = new FileInputStream(excelFilePath);
             Workbook workbook = WorkbookFactory.create(fis)) {

            // Here you can access all sheets in the workbook
            log.info("Successfully loaded Excel workbook with {} sheet(s).", workbook.getNumberOfSheets());

            // Return the workbook object with all sheets
            return workbook;
        }
    }

    private <T> List<T> parseSheetFromWorkbookToVoClass(Sheet sheet, Class<T> clazz, ExcelService.ParseStrategy strategy) {
        List<T> records = new ArrayList<>();
        if (ExcelService.ParseStrategy.COLUMN_NAME.equals(strategy)) {
            records = ExcelUtils.parseExcelToBean(sheet, clazz);
        }
        if (ExcelService.ParseStrategy.COLUMN_ORDER.equals(strategy)) {
            records = ExcelUtils.parseExcelToBeanByColumnOrder(sheet, clazz);
        }

        log.info("Successfully parsed {} records from Excel file for {}", records.size(), clazz.getSimpleName());

        return records;
    }

    private <T> boolean isEmptyRow(T voObject) {
        if (voObject == null) {
            return true;
        }

        Class<?> clazz = voObject.getClass();
        Field[] fields = clazz.getDeclaredFields();

        for (Field field : fields) {
            field.setAccessible(true);
            try {
                Object value = field.get(voObject);
                if (value != null && StringUtil.isNotEmpty(value.toString().strip())) {
                    return false;
                }
            } catch (IllegalAccessException e) {
                log.warn("Could not access field {} in class {}", field.getName(), clazz.getSimpleName());
            }
        }
        return true;
    }

    //Import Agents -3
    @Transactional
    public MigrationLogRespVo.Tab migrateAgent(String filePath) {
        String tabName = "Agent";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Agent migration...");
            List<AgentMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 3, AgentMigrationVo.class);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                MigrationLogRespVo.Tab tabAndContent = new MigrationLogRespVo.Tab();
                tabAndContent.setTabName(tabName);
                tabAndContent.setMessage("File is empty or has less than 3 records");
                return tabAndContent;
            }
            int totalRecordsProcessedSuccessfully = 0;
            // Skip row 1,2,3 from Excel (0,1,2 in list)
            for (int i = 2; i < records.size(); i++) {
                AgentMigrationVo record = records.get(i);
                if (isEmptyRow(record)) {
                    continue;
                }
                if (StringUtil.isEmpty(record.getEmail()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    log.warn("Email or Identity Card Number is empty for record {} : {}", (i + 2), record);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i);
                    tabContent.setRowError("Email or Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Email or Identity Card Number is empty", (i + 2));
                    throw new GeneralException(errorMessage);
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getEmail());
                    // Create AppUser
                    AppUser appUser = findWithCustomErrorHandling(() -> appUserDao.findByEmailAddressAndIsDeletedIsFalse(record.getEmail()), "AppUser", "Email", record.getEmail(), (i + 2));
                    if (appUser == null) {
                        appUser = new AppUser();
                        appUser.setEmailAddress(StringUtil.strip(record.getEmail()));
                        String password = "PASSWORD";
                        String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, password.toCharArray());
                        appUser.setPassword(hashedPassword);
                        appUser.setUserType(UserType.AGENT);
                        appUser.setIsDeleted(Boolean.FALSE);
                        appUser = appUserDao.save(appUser);
                    } else if (!UserType.AGENT.equals(appUser.getUserType())) {
                        // Verify if the email is taken by client profile
                        String errorMessage = String.format("record %d : Email %s has been taken by client profile", (i + 2), record.getEmail());
                        throw new GeneralException(errorMessage);
                    } else {
                        // Verify if the email is taken by other agent profile with different identity card number
                        UserDetail userDetail = userDetailDao.findByAppUserId(appUser);
                        if (userDetail != null) {
                            if (!userDetail.getIdentityCardNumber().equals(record.getIdentityCardNumber())) {
                                String errorMessage = String.format("record %d : Email %s has been taken by an other agent with ID number %s", (i + 2), record.getEmail(), userDetail.getIdentityCardNumber());
                                throw new GeneralException(errorMessage);
                            }
                        }
                    }

                    // Create UserDetail
                    UserDetail userDetail = findWithCustomErrorHandling(() -> userDetailDao.checkExistingUser(record.getIdentityCardNumber(), UserType.AGENT), "UserDetail", "IdentityCardNumber", record.getIdentityCardNumber(), (i + 2));
                    if (userDetail == null) {
                        userDetail = new UserDetail();
                        userDetail.setEmail(record.getEmail());
                        userDetail.setAppUserId(appUser);
                        userDetail.setIdentityCardNumber(record.getIdentityCardNumber());
                        String dobString = StringUtil.isEmpty(record.getDob()) ? "1990-01-01" : record.getDob();
                        userDetail.setDob(DateUtil.convertStringToDate(dobString));
                    }
                    // Validation if name is empty in both userDetail and record, throw error
                    if (StringUtil.isEmpty(userDetail.getName()) && StringUtil.isEmpty(record.getName())) {
                        String errorMessage = String.format("record %d : Name is empty", (i + 2));
                        throw new GeneralException(errorMessage);
                    } else {
                        // Only update userDetail name if record is not empty
                        if (StringUtil.isNotEmpty(record.getName())) {
                            userDetail.setName(record.getName());
                        }
                    }
                    userDetail.setMobileCountryCode(record.getMobileCountryCode());
                    userDetail.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    userDetail.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));

                    if (StringUtil.isNotEmpty(record.getAddress())) {
                        userDetail.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    }
                    if (StringUtil.isNotEmpty(record.getPostcode())) {
                        if (record.getPostcode().endsWith(".0")) {
                            record.setPostcode(record.getPostcode().substring(0, record.getPostcode().length() - 2).trim());
                        }
                        userDetail.setPostcode(record.getPostcode());
                    }
                    if (StringUtil.isNotEmpty(record.getCity())) {
                        userDetail.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    }
                    if (StringUtil.isNotEmpty(record.getState())) {
                        userDetail.setState(StringUtil.capitalizeEachWord(record.getState()));
                    }
                    if (StringUtil.isNotEmpty(record.getCountry())) {
                        userDetail.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    }

                    userDetail = userDetailDao.save(userDetail);

                    // Create Agent
                    Agency agency = agencyDao.findByAgencyId(record.getAgencyId()).orElseThrow(() -> new GeneralException(INVALID_AGENCY_ID));
                    Agent agent = agentDao.findByUserDetailAndStatus(userDetail, Agent.AgentStatus.ACTIVE);
                    if (agent == null) {
                        agent = new Agent();
                        DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                                .builderType(DigitalIDBuilder.BuilderType.AGENT)
                                .name(userDetail.getName())
                                .agencyCode(agency.getAgencyCode()));
                        // Digital ID
                        agent.setAgentId(digitalIDResult.getDigitalID());
                        // Referral Code
                        String referralCode = agency.getAgencyCode() + digitalIDResult.getRunningNumber();
                        agent.setReferralCode(referralCode);
                        agent.setAppUser(appUser);
                        agent.setUserDetail(userDetail);
                    }
                    agent.setAgency(agency);

                    // Agent Role from record overwrites existing agent role
                    AgentRole agentRole = AgentRole.MGR; //Default to MGR
                    if (StringUtil.isNotEmpty(record.getAgentRole())) {
                        agentRole = StringUtil.getEnumFromString(AgentRole.class, record.getAgentRole());
                    }
                    if (agentRole != null) {
                        agent.setAgentRole(agentRoleSettingsDao.findByRoleCode(agentRole));
                    }
                    agent.setStatus(Agent.AgentStatus.ACTIVE);
                    agent.setUpdatedAt(new Date());
                    agentDao.save(agent);

                    // Bank Details
                    if (StringUtil.isNotEmpty(record.getBankAccountNumber())) {
                        BankDetails bankDetails = bankDetailsDao.findByAccountNumberAndAppUserAndIsDeletedFalse(record.getBankAccountNumber(), appUser);
                        if (bankDetails == null) {
                            bankDetails = new BankDetails();
                            bankDetails.setAppUser(appUser);
                            bankDetails.setAccountNumber(record.getBankAccountNumber());
                        }
                        bankDetails.setBankName(record.getBankName());
                        bankDetails.setAccountHolderName(record.getBankAccountHolderName());
                        if (StringUtil.isNotEmpty(record.getBankSwiftCode())) {
                            record.setBankSwiftCode(record.getBankSwiftCode());
                        }
                        if (StringUtil.isNotEmpty(record.getBankAddress())) {
                            bankDetails.setBankAddress(StringUtil.capitalizeEachWord(record.getBankAddress()));
                        }
                        if (StringUtil.isNotEmpty(record.getBankPostcode())) {
                            bankDetails.setPostcode(record.getBankPostcode());
                        }
                        if (StringUtil.isNotEmpty(record.getBankCity())) {
                            bankDetails.setCity(StringUtil.capitalizeEachWord(record.getBankCity()));
                        }
                        if (StringUtil.isNotEmpty(record.getBankState())) {
                            bankDetails.setState(StringUtil.capitalizeEachWord(record.getBankState()));
                        }
                        if (StringUtil.isNotEmpty(record.getBankCountry())) {
                            bankDetails.setCountry(StringUtil.capitalizeEachWord(record.getBankCountry()));
                        }
                        bankDetails.setIsDeleted(Boolean.FALSE);
                        bankDetailsDao.save(bankDetails);
                    }
                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Error Message : %s", (i + 2), ex.getMessage());
                    throw new GeneralException(errorMessage);
                }
            }
            log.info("Total Agents Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Agents migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    //Import Agent Upline -4
    @Transactional
    public MigrationLogRespVo.Tab migrateAgentUpLine(String filePath) {
        String tabName = "Agent UpLine";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Agent Upline migration...");
            List<AgentUplineMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 4, AgentUplineMigrationVo.class);
            // List<AgentUplineMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, AgentUplineMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                AgentUplineMigrationVo record = records.get(i);
                if (isEmptyRow(record)) {
                    continue;
                }
                if (StringUtil.isEmpty(record.getAgentIdentityCardNumber()) || StringUtil.isEmpty(record.getRecruitManagerIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agent or Recruit Manager Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Agent IdentityCardNumber or RecruitManager IdentityCardNumber is empty", (i + 2));
                    throw new GeneralException(errorMessage);
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgentIdentityCardNumber());
                    Agent downLine = agentDao.findAgentByIdentityCardNumber(record.getAgentIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                    Agent upLine = agentDao.findAgentByIdentityCardNumber(record.getRecruitManagerIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                    if (downLine == null || upLine == null) {
                        String errorMessage = String.format("record %d : Agent or Recruit Manager not found", (i + 2));
                        throw new GeneralException(errorMessage);
                    }
                    downLine.setRecruitManager(upLine);
                    agentDao.save(downLine);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                    throw new GeneralException(ex.getMessage());
                }
            }
            log.info("Total UpLine Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Agents UpLine migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    //Import Client -5
    @Transactional
    public MigrationLogRespVo.Tab migrateClient(String filePath) {
        String tabName = "Client";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Client migration...");
            List<ClientMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 5, ClientMigrationVo.class);
            // List<ClientMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ClientMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            int totalRecordsProcessedSuccessfully = 0;
            // Skip row 1,2,3 from Excel (0,1,2 in list)
            for (int i = 2; i < records.size(); i++) {
                ClientMigrationVo record = records.get(i);
                if (isEmptyRow(record)) {
                    continue;
                }
                if (StringUtil.isEmpty(record.getEmail()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Email or Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Email or Identity Card Number is empty", (i + 2));
                    throw new GeneralException(errorMessage);
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    // Create AppUser
                    AppUser appUser = findWithCustomErrorHandling(() -> appUserDao.findByEmailAddressAndIsDeletedIsFalse(record.getEmail()), "AppUser", "Email", record.getEmail(), (i + 2));
                    if (appUser == null) {
                        appUser = new AppUser();
                        appUser.setEmailAddress(StringUtil.strip(record.getEmail()));
                        String password = "PASSWORD";
                        String hashedPassword = BCrypt.with(BCrypt.Version.VERSION_2Y).hashToString(6, password.toCharArray());
                        appUser.setPassword(hashedPassword);
                        appUser.setUserType(UserType.CLIENT);
                        appUser.setIsDeleted(Boolean.FALSE);
                        appUser = appUserDao.save(appUser);
                    } else if (!UserType.CLIENT.equals(appUser.getUserType())) {
                        // Verify if the email is taken by agent profile
                        String errorMessage = String.format("record %d : Email %s has been taken by agent profile", (i + 2), record.getEmail());
                        throw new GeneralException(errorMessage);
                    } else {
                        // Verify if the email is taken by other client profile with different identity card number
                        UserDetail userDetail = userDetailDao.findByAppUserId(appUser);
                        if (userDetail != null) {
                            if (!userDetail.getIdentityCardNumber().equals(record.getIdentityCardNumber())) {
                                String errorMessage = String.format("record %d : Email %s has been taken by an other client with ID number %s", (i + 2), record.getEmail(), userDetail.getIdentityCardNumber());
                                throw new GeneralException(errorMessage);
                            }
                        }
                    }

                    // Create UserDetail
                    UserDetail userDetail = findWithCustomErrorHandling(() -> userDetailDao.checkExistingUser(record.getIdentityCardNumber(), UserType.CLIENT), "UserDetail", "IdentityCardNumber", record.getIdentityCardNumber(), (i + 2));
                    if (userDetail == null) {
                        userDetail = new UserDetail();
                        userDetail.setEmail(record.getEmail());
                        userDetail.setAppUserId(appUser);
                        userDetail.setIdentityCardNumber(record.getIdentityCardNumber());
                        String dobString = StringUtil.isEmpty(record.getDob()) ? "1990-01-01" : record.getDob();
                        userDetail.setDob(DateUtil.convertStringToDate(dobString));
                    }
                    // Validation if name is empty in both userDetail and record, throw error
                    if (StringUtil.isEmpty(userDetail.getName()) && StringUtil.isEmpty(record.getName())) {
                        String errorMessage = String.format("record %d : Name is empty", (i + 2));
                        throw new GeneralException(errorMessage);
                    } else {
                        // Only update userDetail name if record is not empty
                        if (StringUtil.isNotEmpty(record.getName())) {
                            userDetail.setName(record.getName());
                        }
                    }
                    userDetail.setMobileCountryCode(record.getMobileCountryCode());
                    userDetail.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    userDetail.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));

                    if (StringUtil.isNotEmpty(record.getAddress())) {
                        userDetail.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    }
                    if (StringUtil.isNotEmpty(record.getPostcode())) {
                        if (record.getPostcode().endsWith(".0")) {
                            record.setPostcode(record.getPostcode().substring(0, record.getPostcode().length() - 2).trim());
                        }
                        userDetail.setPostcode(record.getPostcode());
                    }
                    if (StringUtil.isNotEmpty(record.getCity())) {
                        userDetail.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    }
                    if (StringUtil.isNotEmpty(record.getState())) {
                        userDetail.setState(StringUtil.capitalizeEachWord(record.getState()));
                    }
                    if (StringUtil.isNotEmpty(record.getCountry())) {
                        userDetail.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    }

                    String recordIsSameCorrespondingAddress = record.getIsSameCorrespondingAddress();
                    if (StringUtil.isNotEmpty(recordIsSameCorrespondingAddress)) {
                        boolean isCorrespondingAddress = "TRUE".equalsIgnoreCase(recordIsSameCorrespondingAddress);
                        if (isCorrespondingAddress) {
                            userDetail.setCorrespondingAddress(StringUtil.capitalizeEachWord(userDetail.getAddress()));
                            userDetail.setCorrespondingPostcode(StringUtil.capitalizeEachWord(userDetail.getPostcode()));
                            userDetail.setCorrespondingCity(StringUtil.capitalizeEachWord(userDetail.getCity()));
                            userDetail.setCorrespondingState(StringUtil.capitalizeEachWord(userDetail.getState()));
                            userDetail.setCorrespondingCountry(StringUtil.capitalizeEachWord(userDetail.getCountry()));
                        } else {
                            userDetail.setCorrespondingAddress(StringUtil.capitalizeEachWord(record.getCorrespondingAddress()));
                            userDetail.setCorrespondingPostcode(StringUtil.capitalizeEachWord(record.getCorrespondingPostcode()));
                            userDetail.setCorrespondingCity(StringUtil.capitalizeEachWord(record.getCorrespondingCity()));
                            userDetail.setCorrespondingState(StringUtil.capitalizeEachWord(record.getCorrespondingState()));
                            userDetail.setCorrespondingCountry(StringUtil.capitalizeEachWord(record.getCorrespondingCountry()));
                        }
                    } else {
                        //Assume address from userDetail is the corresponding address
                        userDetail.setCorrespondingAddress(StringUtil.capitalizeEachWord(userDetail.getAddress()));
                        userDetail.setCorrespondingPostcode(StringUtil.capitalizeEachWord(userDetail.getPostcode()));
                        userDetail.setCorrespondingCity(StringUtil.capitalizeEachWord(userDetail.getCity()));
                        userDetail.setCorrespondingState(StringUtil.capitalizeEachWord(userDetail.getState()));
                        userDetail.setCorrespondingCountry(StringUtil.capitalizeEachWord(userDetail.getCountry()));
                    }
                    userDetail.setGender(StringUtil.getEnumFromString(Gender.class, record.getGender()));
                    userDetail.setNationality(StringUtil.capitalizeEachWord(record.getNationality()));
                    userDetail.setMaritalStatus(StringUtil.getEnumFromString(MaritalStatus.class, record.getMaritalStatus()));
                    userDetail.setResidentialStatus(StringUtil.getEnumFromString(ResidentialStatus.class, record.getResidentialStatus()));

                    userDetail = userDetailDao.save(userDetail);

                    // Create Client
                    Client client = clientDao.findByUserDetailAndStatusIsTrue(userDetail);
                    if (client == null) {
                        client = new Client();
                        if (StringUtil.isEmpty(record.getClientId())) {
                            DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                                    .builderType(DigitalIDBuilder.BuilderType.CLIENT)
                                    .name(userDetail.getName())
                                    .date(userDetail.getDob()));
                            client.setClientId(digitalIDResult.getDigitalID());
                        }
                        client.setAppUser(appUser);
                        client.setUserDetail(userDetail);
                        client.setStatus(true);
                    }

                    // Client is allowed to import without agent assigned
                    client.setAgent(agentDao.findAgentByIdentityCardNumber(record.getAgentIdentityCardNumber(), Agent.AgentStatus.ACTIVE));

                    // If client already has employment type, keep it (don't override with migration data)
                    if (client.getEmploymentType() == null) {
                        String employmentTypeStr = StringUtil.isEmpty(record.getEmploymentType()) ? "EMPLOYED" : record.getEmploymentType();
                        client.setEmploymentType(StringUtil.getEnumFromString(EmploymentType.class, employmentTypeStr));
                    }
                    if (StringUtil.isEmpty(client.getEmployerName()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerName(StringUtil.isNotEmpty(record.getEmployerName()) ? record.getEmployerName() : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getIndustryType()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setIndustryType(StringUtil.isNotEmpty(record.getIndustryType()) ? record.getIndustryType() : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getJobTitle()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setJobTitle(StringUtil.isNotEmpty(record.getJobTitle()) ? record.getJobTitle() : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getEmployerAddress()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerAddress(StringUtil.isNotEmpty(record.getEmployerAddress()) ? StringUtil.capitalizeEachWord(record.getEmployerAddress()) : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getEmployerPostcode()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerPostcode(StringUtil.isNotEmpty(record.getEmployerPostcode()) ? record.getEmployerPostcode() : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getEmployerCity()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerCity(StringUtil.isNotEmpty(record.getEmployerCity()) ? StringUtil.capitalizeEachWord(record.getEmployerCity()) : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getEmployerState()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerState(StringUtil.isNotEmpty(record.getEmployerState()) ? StringUtil.capitalizeEachWord(record.getEmployerState()) : "Please Update");
                    }
                    if (StringUtil.isEmpty(client.getEmployerCountry()) && EmploymentType.EMPLOYED.equals(client.getEmploymentType())) {
                        client.setEmployerCountry(StringUtil.isNotEmpty(record.getEmployerCountry()) ? StringUtil.capitalizeEachWord(record.getEmployerCountry()) : "Please Update");
                    }

                    if (StringUtil.isNotEmpty(record.getAnnualIncomeDeclaration())) {
                        client.setAnnualIncomeDeclaration(record.getAnnualIncomeDeclaration());
                    }
                    if (StringUtil.isNotEmpty(record.getSourceOfIncome())) {
                        client.setSourceOfIncome(record.getSourceOfIncome());
                    }
                    if (StringUtil.isNotEmpty(record.getSourceOfIncomeRemark())) {
                        client.setSourceOfIncomeRemark(record.getSourceOfIncomeRemark());
                    }

                    // Client PEP info
                    PepInfo pepInfo = client.getPepInfo();
                    if (pepInfo == null) {
                        pepInfo = new PepInfo();
                    }
                    pepInfo.setPep("TRUE".equalsIgnoreCase(record.getIsPep()));
                    if (pepInfo.getPep()) {
                        pepInfo.setPepType(StringUtil.getEnumFromString(Relationship.class, record.getPepRelationship()));
                        pepInfo.setPepImmediateFamilyName(record.getPepRelationshipName());
                        pepInfo.setPepPosition(record.getPepPosition());
                        pepInfo.setPepOrganisation(record.getPepOrganisation());
                    }
                    pepInfo = pepInfoDao.save(pepInfo);
                    client.setPepInfo(pepInfo);
                    clientDao.save(client);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Error Message : %s", (i + 2), ex.getMessage());
                    throw new GeneralException(errorMessage);
                }
            }
            log.info("Total Clients Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Clients migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Client Bank Accounts -6
    @Transactional
    public MigrationLogRespVo.Tab migrateClientBankAccounts(String filePath) {
        String tabName = "Client Bank Accounts";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Client Bank Accounts migration...");
            List<ClientBankAccountMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 6, ClientBankAccountMigrationVo.class);
            // List<ClientBankAccountMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ClientBankAccountMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ClientBankAccountMigrationVo record = records.get(i);
                if (isEmptyRow(record)) {
                    continue;
                }
                if (StringUtil.isEmpty(record.getClientIdentityCardNumber()) || StringUtil.isEmpty(record.getBankAccountNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Client Identity Card Number or Bank Account Number is empty");
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Client Identity Card Number or Bank Account Number is empty", (i + 2));
                    throw new GeneralException(errorMessage);
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getClientIdentityCardNumber());

                    Client client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getClientIdentityCardNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    String sanitizedBankAccountNumber = StringUtil.removeAllSpecialCharacters(record.getBankAccountNumber());
                    BankDetails bankDetails = bankDetailsDao.findByAccountNumberAndAppUserAndIsDeletedFalse(sanitizedBankAccountNumber, client.getAppUser());
                    if (bankDetails == null) {
                        bankDetails = new BankDetails();
                        bankDetails.setAppUser(client.getAppUser());
                        bankDetails.setAccountNumber(sanitizedBankAccountNumber);
                    }
                    bankDetails.setBankName(record.getBankName());
                    bankDetails.setAccountHolderName(record.getBankAccountHolderName());
                    bankDetails.setSwiftCode(record.getBankSwiftCode());
                    bankDetails.setBankAddress(StringUtil.capitalizeEachWord(record.getBankAddress()));
                    if (StringUtil.isNotEmpty(record.getBankPostcode())) {
                        bankDetails.setPostcode(record.getBankPostcode());
                    }
                    if (StringUtil.isNotEmpty(record.getBankCity())) {
                        bankDetails.setCity(StringUtil.capitalizeEachWord(record.getBankCity()));
                    }
                    if (StringUtil.isNotEmpty(record.getBankState())) {
                        bankDetails.setState(StringUtil.capitalizeEachWord(record.getBankState()));
                    }
                    if (StringUtil.isNotEmpty(record.getBankCountry())) {
                        bankDetails.setCountry(StringUtil.capitalizeEachWord(record.getBankCountry()));
                    }
                    bankDetails.setIsDeleted(Boolean.FALSE);
                    bankDetailsDao.save(bankDetails);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                    String errorMessage = String.format("record %d : Error Message : %s", (i + 2), ex.getMessage());
                    throw new GeneralException(errorMessage);
                }
            }
            log.info("Total Bank Accounts Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Client Bank Accounts migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Client Beneficiaries -7
    private MigrationLogRespVo.Tab migrateClientBeneficiaries(String filePath) {
        String tabName = "Client Beneficiaries";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Client Beneficiaries migration...");
            List<ClientBeneficiariesMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 7, ClientBeneficiariesMigrationVo.class);
            // List<ClientBeneficiariesMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ClientBeneficiariesMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ClientBeneficiariesMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getClientIdentityCardNumber()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Client Identity Card Number or Beneficiary Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    Client client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getClientIdentityCardNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    if (client == null) {
                        log.warn("Client not found for record {} : {}", (i + 2), record.getClientIdentityCardNumber());
                        continue;
                    }
                    IndividualBeneficiary beneficiary = individualBeneficiaryDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getIdentityCardNumber(), client);
                    if (beneficiary == null) {
                        beneficiary = new IndividualBeneficiary();
                    }
                    beneficiary.setClient(client);
                    beneficiary.setRelationshipToSettlor(StringUtil.getEnumFromString(Relationship.class, record.getRelationshipToClient()));
                    beneficiary.setFullName(record.getName());
                    beneficiary.setIdentityCardNumber(record.getIdentityCardNumber());
                    beneficiary.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));
                    beneficiary.setDob(DateUtil.convertStringToDate(record.getDob()));
                    if (StringUtil.isNotEmpty(record.getGender())) {
                        record.setGender(record.getGender().toUpperCase());
                    }
                    beneficiary.setGender(StringUtil.getEnumFromString(Gender.class, record.getGender()));
                    beneficiary.setNationality(StringUtil.capitalizeEachWord(record.getNationality()));
                    beneficiary.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    beneficiary.setPostcode(StringUtil.capitalizeEachWord(record.getPostcode()));
                    beneficiary.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    beneficiary.setState(StringUtil.capitalizeEachWord(record.getState()));
                    beneficiary.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    if (StringUtil.isNotEmpty(record.getMobileCountryCode())) {
                        if (!record.getMobileCountryCode().startsWith("+")) {
                            record.setMobileCountryCode("+" + record.getMobileCountryCode());
                        }
                    }
                    beneficiary.setMobileCountryCode(record.getMobileCountryCode());
                    beneficiary.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    beneficiary.setEmail(record.getEmail());
                    beneficiary.setMaritalStatus(StringUtil.getEnumFromString(MaritalStatus.class, record.getMaritalStatus()));
                    beneficiary.setResidentialStatus(StringUtil.getEnumFromString(ResidentialStatus.class, record.getResidentialStatus()));
                    beneficiary.setIsDeleted(false);
                    individualBeneficiaryDao.save(beneficiary);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Beneficiaries Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Client Beneficiaries migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Client Guardians -8
    private MigrationLogRespVo.Tab migrateClientGuardians(String filePath) {
        String tabName = "Client Guardians";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Client Guardians migration...");
            List<ClientGuardiansMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 8, ClientGuardiansMigrationVo.class);
            // List<ClientGuardiansMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ClientGuardiansMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ClientGuardiansMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getClientIdentityCardNumber()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Client Identity Card Number or Guardian Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    Client client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getClientIdentityCardNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    if (client == null) {
                        log.warn("Client not found for record {} : {}", (i + 2), record.getClientIdentityCardNumber());
                        continue;
                    }
                    IndividualGuardian guardian = individualGuardianDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getIdentityCardNumber(), client);
                    if (guardian == null) {
                        guardian = new IndividualGuardian();
                    }
                    guardian.setClient(client);
                    guardian.setFullName(record.getName());
                    guardian.setIdentityCardNumber(record.getIdentityCardNumber());
                    guardian.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));
                    guardian.setDob(DateUtil.convertStringToDate(record.getDob()));
                    if (StringUtil.isNotEmpty(record.getGender())) {
                        record.setGender(record.getGender().toUpperCase());
                    }
                    guardian.setGender(StringUtil.getEnumFromString(Gender.class, record.getGender()));
                    guardian.setNationality(StringUtil.capitalizeEachWord(record.getNationality()));
                    if (StringUtil.isEmpty(record.getAddress())) {
                        guardian.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    }
                    if (StringUtil.isEmpty(record.getPostcode())) {
                        guardian.setPostcode(StringUtil.capitalizeEachWord(record.getPostcode()));
                    }
                    if (StringUtil.isEmpty(record.getCity())) {
                        guardian.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    }
                    if (StringUtil.isEmpty(record.getState())) {
                        guardian.setState(StringUtil.capitalizeEachWord(record.getState()));
                    }
                    if (StringUtil.isEmpty(record.getCountry())) {
                        guardian.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    }
                    if (StringUtil.isNotEmpty(record.getMobileCountryCode())) {
                        if (!record.getMobileCountryCode().startsWith("+")) {
                            record.setMobileCountryCode("+" + record.getMobileCountryCode());
                        }
                        guardian.setMobileCountryCode(record.getMobileCountryCode());
                    }
                    if (StringUtil.isNotEmpty(record.getMobileNumber())) {
                        guardian.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    }
                    if (StringUtil.isNotEmpty(record.getEmail())) {
                        guardian.setEmail(record.getEmail());
                    }
                    guardian.setMaritalStatus(StringUtil.getEnumFromString(MaritalStatus.class, record.getMaritalStatus()));
                    guardian.setResidentialStatus(StringUtil.getEnumFromString(ResidentialStatus.class, record.getResidentialStatus()));
                    guardian.setIsDeleted(false);
                    individualGuardianDao.save(guardian);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Guardians Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Client Guardians migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Client Beneficiaries Guardians -9
    private MigrationLogRespVo.Tab migrateClientBeneficiariesGuardians(String filePath) {
        String tabName = "Client Beneficiaries Guardians";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Client Beneficiary Guardians migration...");
            List<ClientBeneficiariesGuardiansMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 9, ClientBeneficiariesGuardiansMigrationVo.class);
            // List<ClientBeneficiariesGuardiansMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ClientBeneficiariesGuardiansMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ClientBeneficiariesGuardiansMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getClientIdentityCardNumber()) || StringUtil.isEmpty(record.getBeneficiaryIdentityCardNumber()) || StringUtil.isEmpty(record.getGuardianIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Client, Beneficiary or Guardian Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getClientIdentityCardNumber());
                    Client client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getClientIdentityCardNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    if (client == null) {
                        log.warn("Client not found for record {} : {}", (i + 2), record.getClientIdentityCardNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Client not found: " + record.getClientIdentityCardNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    IndividualBeneficiary beneficiary = individualBeneficiaryDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getBeneficiaryIdentityCardNumber(), client);
                    IndividualGuardian guardian = individualGuardianDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getGuardianIdentityCardNumber(), client);
                    if (beneficiary == null || guardian == null) {
                        log.warn("Beneficiary or Guardian not found for record {} ", (i + 2));
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Beneficiary or Guardian not found");
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    IndividualBeneficiaryGuardian beneficiaryGuardian = individualBeneficiaryGuardianDao.findByIndividualBeneficiaryAndIndividualGuardianAndIsDeletedIsFalse(beneficiary, guardian);
                    if (beneficiaryGuardian == null) {
                        beneficiaryGuardian = new IndividualBeneficiaryGuardian();
                    }
                    beneficiaryGuardian.setIndividualBeneficiary(beneficiary);
                    beneficiaryGuardian.setIndividualGuardian(guardian);
                    beneficiaryGuardian.setRelationshipToGuardian(StringUtil.getEnumFromString(Relationship.class, record.getRelationshipToGuardian()));
                    beneficiaryGuardian.setRelationshipToBeneficiary(StringUtil.getEnumFromString(Relationship.class, record.getRelationshipToBeneficiary()));
                    beneficiaryGuardian.setIsDeleted(false);
                    individualBeneficiaryGuardianDao.save(beneficiaryGuardian);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Client Beneficiary Guardians Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Client Beneficiary Guardians migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Corporate -10
    private MigrationLogRespVo.Tab migrateCorporate(String filePath) {
        String tabName = "Corporate";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate migration...");
            List<CorporateMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 10, CorporateMigrationVo.class);
            // List<CorporateMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getClientIdentityCardNumber()) || StringUtil.isEmpty(record.getRegistrationNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Client Identity Card Number or Registration Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getRegistrationNumber());
                    Client client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getClientIdentityCardNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    if (client == null) {
                        log.warn("Client not found for record {} : {}", (i + 2), record.getRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Client not found: " + record.getClientIdentityCardNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    CorporateClient corporateClient = corporateClientDao.findByRegistrationNumberAndClientAndIsDeletedIsFalse(record.getRegistrationNumber(), client);
                    if (corporateClient == null) {
                        corporateClient = new CorporateClient();
                        String corReferenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                                .prefix("COR" + System.currentTimeMillis())
                                .postfix(RandomCodeBuilder.NUMBERS)
                                .postfixLength(3));
                        corporateClient.setReferenceNumber(corReferenceNumber);
                        DigitalIDResultVo digitalIDResult = createDigitalID(new DigitalIDBuilder()
                                .builderType(DigitalIDBuilder.BuilderType.CORPORATE_CLIENT)
                                .name(record.getEntityName())
                                .date(DateUtil.convertStringToDate(record.getDateIncorporation())));
                        String corporateDigitalId = digitalIDResult.getDigitalID();
                        corporateClient.setCorporateClientId(corporateDigitalId);
                    }
                    corporateClient.setClient(client);
                    corporateClient.setUserDetail(client.getUserDetail());
                    corporateClient.setStatus(CorporateClient.CorporateClientStatus.DRAFT);
                    corporateClient.setAgent(client.getAgent());
                    corporateClient.setAnnualIncomeDeclaration(record.getAnnualIncomeDeclaration());
                    corporateClient.setSourceOfIncome(record.getSourceOfIncome());
                    corporateClient.setSourceOfIncomeRemark(record.getSourceOfIncomeRemark());
                    corporateClient.setStatus(CorporateClient.CorporateClientStatus.DRAFT);
                    corporateClient.setIsDeleted(false);

                    // Corporate Details
                    CorporateDetails corporateDetails = corporateClient.getCorporateDetails();
                    if (corporateDetails == null) {
                        corporateDetails = new CorporateDetails();
                    }
                    corporateDetails.setEntityName(record.getEntityName());
                    // Convert string to enum for entityType
                    if (record.getEntityType() != null) {
                        try {
                            corporateDetails.setEntityType(CorporateTypeOfEntity.valueOf(record.getEntityType().toUpperCase()));
                        } catch (IllegalArgumentException e) {
                            // Handle case where string doesn't match any enum value
                            corporateDetails.setEntityType(null);
                        }
                    }
                    corporateDetails.setRegistrationNumber(record.getRegistrationNumber());
                    corporateDetails.setDateIncorporation(DateUtil.convertStringToDate(record.getDateIncorporation()));
                    corporateDetails.setPlaceIncorporation(record.getPlaceIncorporation());
                    corporateDetails.setBusinessType(record.getBusinessType());
                    corporateDetails.setRegisteredAddress(StringUtil.capitalizeEachWord(record.getRegisteredAddress()));
                    corporateDetails.setPostcode(record.getPostcode());
                    corporateDetails.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    corporateDetails.setState(StringUtil.capitalizeEachWord(record.getState()));
                    corporateDetails.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    corporateDetails.setIsDifferentBusinessAddress("TRUE".equalsIgnoreCase(record.getIsDifferentBusinessAddress()));
                    if (corporateDetails.getIsDifferentBusinessAddress()) {
                        corporateDetails.setBusinessAddress(StringUtil.capitalizeEachWord(record.getBusinessAddress()));
                        corporateDetails.setBusinessPostcode(record.getBusinessPostcode());
                        corporateDetails.setBusinessCity(StringUtil.capitalizeEachWord(record.getBusinessCity()));
                        corporateDetails.setBusinessState(StringUtil.capitalizeEachWord(record.getBusinessState()));
                        corporateDetails.setBusinessCountry(StringUtil.capitalizeEachWord(record.getBusinessCountry()));
                    } else {
                        corporateDetails.setBusinessAddress(corporateDetails.getRegisteredAddress());
                        corporateDetails.setBusinessPostcode(corporateDetails.getPostcode());
                        corporateDetails.setBusinessCity(corporateDetails.getCity());
                        corporateDetails.setBusinessState(corporateDetails.getState());
                        corporateDetails.setBusinessCountry(corporateDetails.getCountry());
                    }
                    corporateDetails.setContactIsMyself("TRUE".equalsIgnoreCase(record.getContactIsMyself()));
                    if (!corporateDetails.getContactIsMyself()) {
                        corporateDetails.setContactDesignation(record.getContactDesignation());
                        if (StringUtil.isNotEmpty(record.getContactMobileCountryCode())) {
                            if (!record.getContactMobileCountryCode().startsWith("+")) {
                                record.setContactMobileCountryCode("+" + record.getContactMobileCountryCode());
                            }
                        }
                        corporateDetails.setContactMobileCountryCode(record.getContactMobileCountryCode());
                        corporateDetails.setContactMobileNumber(StringUtil.removeCharacters(record.getContactMobileNumber(), List.of(' ', '-', '+')));
                        corporateDetails.setContactEmail(record.getContactEmail());
                    }
                    corporateDetails.setIsDeleted(false);
                    corporateDetails.setStatus(CorporateDetails.CorporateDetailsStatus.DRAFT);
                    corporateDetails = corporateDetailsDao.save(corporateDetails);

                    corporateClient.setCorporateDetails(corporateDetails);
                    corporateClientDao.save(corporateClient);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Corporate Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Corporate Shareholders -11
    private MigrationLogRespVo.Tab migrateCorporateShareholders(String filePath) {
        String tabName = "Corporate Shareholders";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate Shareholders migration...");
            List<CorporateShareholderMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 11, CorporateShareholderMigrationVo.class);
            // List<CorporateShareholderMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateShareholderMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateShareholderMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getCompanyRegistrationNumber()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Company Registration Number or Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    CorporateClient corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getCompanyRegistrationNumber());
                    if (corporateClient == null) {
                        log.warn("Corporate Client not found for record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Corporate Client not found: " + record.getCompanyRegistrationNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    CorporateShareholder shareholder = corporateShareholderDao.findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(corporateClient, record.getIdentityCardNumber());
                    if (shareholder == null) {
                        shareholder = new CorporateShareholder();
                    }
                    shareholder.setCorporateClient(corporateClient);
                    shareholder.setName(record.getName());
                    shareholder.setIdentityCardNumber(record.getIdentityCardNumber());
                    shareholder.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));
                    shareholder.setPercentageOfShareholdings(Double.valueOf(record.getPercentageOfShareholdings()));
                    if (StringUtil.isNotEmpty(record.getMobileCountryCode())) {
                        if (!record.getMobileCountryCode().startsWith("+")) {
                            record.setMobileCountryCode("+" + record.getMobileCountryCode());
                        }
                    }
                    shareholder.setMobileCountryCode(record.getMobileCountryCode());
                    shareholder.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    shareholder.setEmail(record.getEmail());
                    shareholder.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    shareholder.setPostcode(StringUtil.capitalizeEachWord(record.getPostcode()));
                    shareholder.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    shareholder.setState(StringUtil.capitalizeEachWord(record.getState()));
                    shareholder.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    shareholder.setStatus(CorporateShareholder.CorporateShareholderStatus.DRAFT);
                    shareholder.setIsDeleted(false);
                    shareholder = corporateShareholderDao.save(shareholder);

                    // Shareholder PEP info
                    PepInfo pepInfo = shareholder.getPepInfo();
                    if (pepInfo == null) {
                        pepInfo = new PepInfo();
                    }
                    pepInfo.setPep("TRUE".equalsIgnoreCase(record.getIsPep()));
                    if (pepInfo.getPep()) {
                        pepInfo.setPepType(StringUtil.getEnumFromString(Relationship.class, record.getPepRelationship()));
                        pepInfo.setPepImmediateFamilyName(record.getPepRelationshipName());
                        pepInfo.setPepPosition(record.getPepPosition());
                        pepInfo.setPepOrganisation(record.getPepOrganisation());
                    }
                    pepInfo = pepInfoDao.save(pepInfo);
                    shareholder.setPepInfo(pepInfo);
                    corporateShareholderDao.save(shareholder);

                    CorporateShareholdersPivot pivot = corporateShareholdersPivotDao.findByCorporateClientAndCorporateShareholderAndIsDeletedIsFalse(corporateClient, shareholder);
                    if (pivot == null) {
                        pivot = new CorporateShareholdersPivot();
                        pivot.setCorporateClient(corporateClient);
                        pivot.setCorporateShareholder(shareholder);
                        pivot.setIsDeleted(false);
                        corporateShareholdersPivotDao.save(pivot);
                    }

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Corporate Shareholders Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate Shareholders migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    //Import Corporate Beneficiaries -12
    private MigrationLogRespVo.Tab migrateCorporateBeneficiaries(String filePath) {
        String tabName = "Corporate Beneficiaries";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate Beneficiaries migration...");
            List<CorporateBeneficiariesMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 12, CorporateBeneficiariesMigrationVo.class);
            // List<CorporateBeneficiariesMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateBeneficiariesMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateBeneficiariesMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getCompanyRegistrationNumber()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Company Registration Number or Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    CorporateClient corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getCompanyRegistrationNumber());
                    if (corporateClient == null) {
                        log.warn("Corporate Client not found for record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Corporate Client not found: " + record.getCompanyRegistrationNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    CorporateBeneficiaries beneficiary = corporateBeneficiaryDao.findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(corporateClient, record.getIdentityCardNumber());
                    if (beneficiary == null) {
                        beneficiary = new CorporateBeneficiaries();
                    }
                    beneficiary.setCorporateClient(corporateClient);
                    beneficiary.setFullName(record.getName());
                    beneficiary.setIdentityCardNumber(record.getIdentityCardNumber());
                    beneficiary.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));
                    beneficiary.setDob(DateUtil.convertStringToDate(record.getDob()));
                    if (StringUtil.isNotEmpty(record.getGender())) {
                        record.setGender(record.getGender().toUpperCase());
                    }
                    beneficiary.setGender(StringUtil.getEnumFromString(Gender.class, record.getGender()));
                    beneficiary.setNationality(StringUtil.capitalizeEachWord(record.getNationality()));
                    beneficiary.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    beneficiary.setPostcode(StringUtil.capitalizeEachWord(record.getPostcode()));
                    beneficiary.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    beneficiary.setState(StringUtil.capitalizeEachWord(record.getState()));
                    beneficiary.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    if (StringUtil.isNotEmpty(record.getMobileCountryCode())) {
                        if (!record.getMobileCountryCode().startsWith("+")) {
                            record.setMobileCountryCode("+" + record.getMobileCountryCode());
                        }
                    }
                    beneficiary.setMobileCountryCode(record.getMobileCountryCode());
                    beneficiary.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    beneficiary.setEmail(record.getEmail());
                    beneficiary.setMaritalStatus(StringUtil.getEnumFromString(MaritalStatus.class, record.getMaritalStatus()));
                    beneficiary.setResidentialStatus(StringUtil.getEnumFromString(ResidentialStatus.class, record.getResidentialStatus()));
                    beneficiary.setIsDeleted(false);
                    corporateBeneficiaryDao.save(beneficiary);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Corporate Beneficiaries Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate Beneficiaries migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Corporate Guardians -13
    private MigrationLogRespVo.Tab migrateCorporateGuardians(String filePath) {
        String tabName = "Corporate Guardians";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate Guardians migration...");
            List<CorporateGuardiansMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 13, CorporateGuardiansMigrationVo.class);
            // List<CorporateGuardiansMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateGuardiansMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateGuardiansMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getCompanyRegistrationNumber()) || StringUtil.isEmpty(record.getIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Company Registration Number or Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getIdentityCardNumber());
                    CorporateClient corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getCompanyRegistrationNumber());
                    if (corporateClient == null) {
                        log.warn("Corporate Client not found for record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Corporate Client not found: " + record.getCompanyRegistrationNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    CorporateGuardian guardian = corporateGuardianDao.findByCorporateClientAndIdentityCardNumber(corporateClient, record.getIdentityCardNumber());
                    if (guardian == null) {
                        guardian = new CorporateGuardian();
                    }
                    guardian.setCorporateClient(corporateClient);
                    guardian.setFullName(record.getName());
                    guardian.setIdentityCardNumber(record.getIdentityCardNumber());
                    guardian.setIdentityDocumentType(StringUtil.getEnumFromString(IdentityDocumentType.class, record.getIdentityDocType()));
                    guardian.setDob(DateUtil.convertStringToDate(record.getDob()));
                    if (StringUtil.isNotEmpty(record.getGender())) {
                        record.setGender(record.getGender().toUpperCase());
                    }
                    guardian.setGender(StringUtil.getEnumFromString(Gender.class, record.getGender()));
                    guardian.setNationality(StringUtil.capitalizeEachWord(record.getNationality()));
                    guardian.setAddress(StringUtil.capitalizeEachWord(record.getAddress()));
                    guardian.setPostcode(StringUtil.capitalizeEachWord(record.getPostcode()));
                    guardian.setCity(StringUtil.capitalizeEachWord(record.getCity()));
                    guardian.setState(StringUtil.capitalizeEachWord(record.getState()));
                    guardian.setCountry(StringUtil.capitalizeEachWord(record.getCountry()));
                    if (StringUtil.isNotEmpty(record.getMobileCountryCode())) {
                        if (!record.getMobileCountryCode().startsWith("+")) {
                            record.setMobileCountryCode("+" + record.getMobileCountryCode());
                        }
                    }
                    guardian.setMobileCountryCode(record.getMobileCountryCode());
                    guardian.setMobileNumber(StringUtil.removeCharacters(record.getMobileNumber(), List.of(' ', '-', '+')));
                    guardian.setEmail(record.getEmail());
                    guardian.setMaritalStatus(StringUtil.getEnumFromString(MaritalStatus.class, record.getMaritalStatus()));
                    guardian.setResidentialStatus(StringUtil.getEnumFromString(ResidentialStatus.class, record.getResidentialStatus()));
                    guardian.setIsDeleted(false);
                    corporateGuardianDao.save(guardian);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Corporate Guardians Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate Guardians migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Corporate Beneficiaries Guardians -14
    private MigrationLogRespVo.Tab migrateCorporateBeneficiariesGuardians(String filePath) {
        String tabName = "Corporate Beneficiaries Guardians";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate Beneficiary Guardians migration...");
            List<CorporateBeneficiariesGuardiansMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 14, CorporateBeneficiariesGuardiansMigrationVo.class);
            // List<CorporateBeneficiariesGuardiansMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateBeneficiariesGuardiansMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateBeneficiariesGuardiansMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getCompanyRegistrationNumber()) || StringUtil.isEmpty(record.getBeneficiaryIdentityCardNumber()) || StringUtil.isEmpty(record.getGuardianIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Company Registration Number, Beneficiary or Guardian Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                    CorporateClient corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getCompanyRegistrationNumber());
                    if (corporateClient == null) {
                        log.warn("Corporate Client not found for record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Corporate Client not found: " + record.getCompanyRegistrationNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    CorporateBeneficiaries beneficiary = corporateBeneficiaryDao.findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(corporateClient, record.getBeneficiaryIdentityCardNumber());
                    CorporateGuardian guardian = corporateGuardianDao.findByCorporateClientAndIdentityCardNumber(corporateClient, record.getGuardianIdentityCardNumber());
                    if (beneficiary == null || guardian == null) {
                        log.warn("Beneficiary or Guardian not found for record {} ", (i + 2));
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Beneficiary or Guardian not found");
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    beneficiary.setCorporateGuardian(guardian);
                    beneficiary.setRelationshipToSettlor(StringUtil.getEnumFromString(Relationship.class, record.getRelationshipToBeneficiary()));
                    beneficiary.setRelationshipToGuardian(StringUtil.getEnumFromString(Relationship.class, record.getRelationshipToGuardian()));
                    corporateBeneficiaryDao.save(beneficiary);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Corporate Beneficiary Guardians Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate Beneficiary Guardians migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Corporate Bank Accounts -15
    private MigrationLogRespVo.Tab migrateCorporateBankAccounts(String filePath) {
        String tabName = "Corporate Bank Accounts";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Corporate Bank Accounts migration...");
            List<CorporateBankAccountMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 15, CorporateBankAccountMigrationVo.class);
            // List<CorporateBankAccountMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, CorporateBankAccountMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                CorporateBankAccountMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getCompanyRegistrationNumber()) || StringUtil.isEmpty(record.getBankAccountNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Company Registration Number or Bank Account Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getBankAccountNumber());
                    CorporateClient corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getCompanyRegistrationNumber());
                    if (corporateClient != null) {
                        BankDetails bankDetails = bankDetailsDao.findByAccountNumberAndIsDeletedFalse(record.getBankAccountNumber());
                        if (bankDetails == null) {
                            bankDetails = new BankDetails();
                        }
                        bankDetails.setBankName(record.getBankName());
                        bankDetails.setAccountNumber(record.getBankAccountNumber());
                        bankDetails.setAccountHolderName(record.getBankAccountHolderName());
                        bankDetails.setSwiftCode(record.getBankSwiftCode());
                        bankDetails.setBankAddress(StringUtil.capitalizeEachWord(record.getBankAddress()));
                        bankDetails.setPostcode(record.getBankPostcode());
                        bankDetails.setCity(StringUtil.capitalizeEachWord(record.getBankCity()));
                        bankDetails.setState(StringUtil.capitalizeEachWord(record.getBankState()));
                        bankDetails.setCountry(StringUtil.capitalizeEachWord(record.getBankCountry()));
                        bankDetails.setIsDeleted(Boolean.FALSE);
                        bankDetails.setCorporateClient(corporateClient);
                        bankDetailsDao.save(bankDetails);

                        log.info("Record {} : processed successfully", (i + 2));
                        totalRecordsProcessedSuccessfully++;
                    } else {
                        log.warn("Corporate Client not found for record {} : {}", (i + 2), record.getCompanyRegistrationNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Corporate Client not found: " + record.getCompanyRegistrationNumber());
                        tab.getTabContentList().add(tabContent);
                    }
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Bank Accounts Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Corporate Bank Accounts migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    private static String sanitizeAgreementNumber(String agreementNumber) {
        if (StringUtil.isEmpty(agreementNumber)) {
            return null;
        }
        return agreementNumber.replaceAll("/", "-").strip();
    }

    public static int getFixedQuarterSequence(LocalDate givenDate, LocalDate currentDate) {
        int givenYear = givenDate.getYear();
        int currentYear = currentDate.getYear();
        int givenQuarter = (givenDate.getMonthValue() - 1) / 3 + 1;
        int currentQuarter = (currentDate.getMonthValue() - 1) / 3 + 1;

        int yearDiff = currentYear - givenYear;
        int quarterDiff = currentQuarter - givenQuarter;

        // +1 to include the current quarter in the count
        return yearDiff * 4 + quarterDiff + 1;
    }

    public static int getQuarterIntervalsByAddingMonths(LocalDate givenDate, LocalDate currentDate) {
        int count = 0;
        LocalDate tempDate = givenDate;
        while (tempDate.isBefore(currentDate)) {
            tempDate = tempDate.plusMonths(3);
            count++;
        }
        return count;
    }

    public static LocalDate[] getLastPeriodBeforeCurrent(LocalDate periodStartingDate) {
        int monthsToAdd = 12 / 4; // 3 months per period (quarter)
        LocalDate now = LocalDate.now();
        LocalDate start = periodStartingDate;
        LocalDate end = start.plusMonths(monthsToAdd).minusDays(1);

        while (end.isBefore(now)) {
            start = end.plusDays(1);
            end = start.plusMonths(monthsToAdd).minusDays(1);
        }

        return new LocalDate[]{start, end};
    }

    // Import Product Orders -16
    private MigrationLogRespVo.Tab migrateProductOder(String filePath) {
        String tabName = "Product Orders";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Product Order migration...");
            List<ProductOrderMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 16, ProductOrderMigrationVo.class);
            // List<ProductOrderMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ProductOrderMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ProductOrderMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getPurchaserIdentityNumber()) || StringUtil.isEmpty(record.getAgreementNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Purchaser Identity Number or Agreement Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    record.setAgreementNumber(sanitizeAgreementNumber(record.getAgreementNumber()));

                    Client client = null;
                    CorporateClient corporateClient = null;
                    Agent agent = null;
                    String clientName = null;
                    client = clientDao.findClientByIdentityCardNumberAndStatusIsTrue(record.getPurchaserIdentityNumber()).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
                    if (client == null) {
                        corporateClient = corporateClientDao.findByCorporateRegistrationNumberAndIsDeletedIsFalse(record.getPurchaserIdentityNumber());
                        if (corporateClient != null) {
                            agent = corporateClient.getAgent();
                            clientName = corporateClient.getCorporateDetails().getEntityName();
                        }
                    } else {
                        agent = client.getAgent();
                        clientName = client.getUserDetail().getName();
                    }

                    if (client == null && corporateClient == null) {
                        log.warn("Client not found for record {} : {}", (i + 2), record.getPurchaserIdentityNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Client not found: " + record.getPurchaserIdentityNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }

                    Product product = productDao.findByCode(record.getProductCode()).orElse(null);
                    if (product == null) {
                        log.warn("Product not found for record {} : {}", (i + 2), record.getProductCode());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Product not found: " + record.getProductCode());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }

                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        productOrder = new ProductOrder();
                        productOrder.setOrderReferenceNumber(ProductService.createOrderReferenceNumber());
                    }
                    productOrder.setProductOrderType(StringUtil.getEnumFromString(ProductOrderType.class, record.getProductOrderType()));
                    if (ProductOrderType.REALLOCATE.equals(productOrder.getProductOrderType())) {
                        productOrder.setProductOrderType(ProductOrderType.ROLLOVER);
                    }
                    productOrder.setClient(client);
                    productOrder.setCorporateClient(corporateClient);
                    productOrder.setAgent(agent);
                    productOrder.setAgency(agent.getAgency());
                    productOrder.setProduct(product);
                    productOrder.setPurchasedAmount(Double.valueOf(record.getPurchasedAmount()));
                    productOrder.setDividend(Double.valueOf(record.getDividendPercentage()));
                    productOrder.setInvestmentTenureMonth(Integer.valueOf(record.getInvestmentTenureMonth()));
                    productOrder.setBank(bankDetailsDao.findByAccountNumberAndIsDeletedFalse(record.getPurchaserBankAccountNumber()));
                    productOrder.setStatus(StringUtil.getEnumFromString(ProductOrder.ProductOrderStatus.class, record.getStatus()));
                    productOrder.setSubmissionDate(DateUtil.convertStringToDate(record.getSubmissionDate()));
                    productOrder.setStatusChecker(CmsAdmin.CheckerStatus.APPROVE_CHECKER);
                    productOrder.setStatusFinance(CmsAdmin.FinanceStatus.APPROVE_FINANCE);
                    productOrder.setStatusApprover(CmsAdmin.ApproverStatus.APPROVE_APPROVER);
                    productOrder.setAgreementFileName(record.getAgreementNumber());
                    productOrder.setClientAgreementStatus(Status.SUCCESS);
                    productOrder.setWitnessAgreementStatus(Status.SUCCESS);
                    productOrder.setStructureType(StringUtil.getEnumFromString(ProductDividendSchedule.StructureType.class, record.getDividendType()));

                    Date agreementDate = DateUtil.convertStringToDate(record.getAgreementDate());
                    LocalDate agreementDateLocal = DateUtil.convertDateToLocalDate(agreementDate);
                    productOrder.setAgreementDate(agreementDateLocal);

                    productOrder.setStartTenure(agreementDateLocal);
                    productOrder.setEndTenure(agreementDateLocal.plusMonths(productOrder.getInvestmentTenureMonth()).minusDays(1));

                    productOrder.setPaymentMethod(PaymentMethod.MANUAL_TRANSFER);
                    productOrder.setPaymentStatus(Status.SUCCESS);
                    productOrder.setIsProrated("TRUE".equalsIgnoreCase(record.getIsProrated()));
                    List<ProductDividendSchedule> dividendScheduleList = productDividendScheduleDao.findAllByProductId(productOrder.getProduct().getId());
                    if (!dividendScheduleList.isEmpty()) {
                        productOrder.setPayoutFrequency(dividendScheduleList.get(0).getFrequencyOfPayout());
                    }
                    productOrder.setClientName(clientName);

                    if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                        QuarterVo quarter = DateUtil.getQuarter(LocalDate.now());
                        productOrder.setPeriodStartingDate(quarter.getStartDate());
                        productOrder.setPeriodEndingDate(quarter.getEndDate());

                        productOrder.setDividendCounter(getFixedQuarterSequence(productOrder.getAgreementDate(), LocalDate.now()) - 1);
                    } else if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                        LocalDate[] localDates = getLastPeriodBeforeCurrent(productOrder.getAgreementDate());
                        productOrder.setPeriodStartingDate(localDates[0]);
                        productOrder.setPeriodEndingDate(localDates[1]);

                        productOrder.setDividendCounter(getQuarterIntervalsByAddingMonths(productOrder.getAgreementDate(), LocalDate.now()) - 1);
                    }

                    productOrder.setPaymentDate(DateUtil.convertLocalDateToDate(productOrder.getAgreementDate().minusDays(5)));
                    productOrder.setEnableLivingTrust(Boolean.FALSE);
                    productOrder.setImported(Boolean.TRUE);
                    productOrderDao.save(productOrder);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Product Orders Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Product Orders migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Product Orders Beneficiaries -17
    private MigrationLogRespVo.Tab migrateProductOrderBeneficiaries(String filePath) {
        String tabName = "Product Orders Beneficiaries";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Product Orders Beneficiaries migration...");
            List<ProductOrderBeneficiariesMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 17, ProductOrderBeneficiariesMigrationVo.class);
            // List<ProductOrderBeneficiariesMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ProductOrderBeneficiariesMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ProductOrderBeneficiariesMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber()) || StringUtil.isEmpty(record.getBeneficiaryIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number or Beneficiary Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getBeneficiaryIdentityCardNumber());
                    record.setAgreementNumber(sanitizeAgreementNumber(record.getAgreementNumber()));

                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Product Order not found: " + record.getAgreementNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    if (productOrder.getClient() != null) {
                        IndividualBeneficiary beneficiary = individualBeneficiaryDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getBeneficiaryIdentityCardNumber(), productOrder.getClient());
                        if (beneficiary == null) {
                            log.warn("Beneficiary not found for record {} : {}", (i + 2), record.getBeneficiaryIdentityCardNumber());
                            MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                            tabContent.setRowNumber(i + 2);
                            tabContent.setRowError("Beneficiary not found: " + record.getBeneficiaryIdentityCardNumber());
                            tab.getTabContentList().add(tabContent);
                            continue;
                        }
                        ProductBeneficiaries productBeneficiaries = productBeneficiariesDao.findByProductOrderAndBeneficiary(productOrder, beneficiary);
                        if (productBeneficiaries == null) {
                            productBeneficiaries = new ProductBeneficiaries();
                        }
                        productBeneficiaries.setProductOrder(productOrder);
                        productBeneficiaries.setBeneficiary(beneficiary);
                        productBeneficiaries.setType(UserType.MAIN_BENEFICIARY);
                        if (StringUtil.isNotEmpty(record.getMainBeneficiaryIdentityCardNumber())) {
                            IndividualBeneficiary mainBeneficiary = individualBeneficiaryDao.findByIdentityCardNumberAndClientAndIsDeletedIsFalse(record.getMainBeneficiaryIdentityCardNumber(), productOrder.getClient());
                            if (mainBeneficiary != null) {
                                productBeneficiaries.setMainBeneficiary(mainBeneficiary);
                                productBeneficiaries.setType(UserType.SUB_BENEFICIARY);
                            }
                        }
                        productBeneficiaries.setPercentage(Double.valueOf(record.getPercentageOfDistribution()));
                        productBeneficiariesDao.save(productBeneficiaries);
                    } else if (productOrder.getCorporateClient() != null) {
                        CorporateBeneficiaries beneficiary = corporateBeneficiaryDao.findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(productOrder.getCorporateClient(), record.getBeneficiaryIdentityCardNumber());
                        if (beneficiary == null) {
                            log.warn("Corporate Beneficiary not found for record {} : {}", (i + 2), record.getBeneficiaryIdentityCardNumber());
                            MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                            tabContent.setRowNumber(i + 2);
                            tabContent.setRowError("Corporate Beneficiary not found: " + record.getBeneficiaryIdentityCardNumber());
                            tab.getTabContentList().add(tabContent);
                            continue;
                        }
                        ProductBeneficiaries productBeneficiaries = productBeneficiariesDao.findByProductOrderAndCorporateBeneficiary(productOrder, beneficiary);
                        if (productBeneficiaries == null) {
                            productBeneficiaries = new ProductBeneficiaries();
                        }
                        productBeneficiaries.setProductOrder(productOrder);
                        productBeneficiaries.setCorporateBeneficiary(beneficiary);
                        productBeneficiaries.setType(UserType.MAIN_BENEFICIARY);
                        if (StringUtil.isNotEmpty(record.getMainBeneficiaryIdentityCardNumber())) {
                            CorporateBeneficiaries mainBeneficiary = corporateBeneficiaryDao.findByCorporateClientAndIdentityCardNumberAndIsDeletedIsFalse(productOrder.getCorporateClient(), record.getMainBeneficiaryIdentityCardNumber());
                            if (mainBeneficiary != null) {
                                productBeneficiaries.setCorporateMainBeneficiary(mainBeneficiary);
                                productBeneficiaries.setType(UserType.SUB_BENEFICIARY);
                            }
                        }
                        productBeneficiaries.setPercentage(Double.valueOf(record.getPercentageOfDistribution()));
                        productBeneficiariesDao.save(productBeneficiaries);
                    }
                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Product Orders Beneficiaries Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Product Orders Beneficiaries migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    private void createAndSaveProductDividendCalculationHistory(ProductOrder productOrder, LocalDate periodStartingDateLocalDate, LocalDate periodEndingDateLocalDate, int dividendCount) throws Exception {
        ProductDividendCalculationHistory history = productDividendCalculationHistoryDao.findByProductOrderAndPeriodStartingDateAndPeriodEndingDate(productOrder, periodStartingDateLocalDate, periodEndingDateLocalDate);
        if (history == null) {
            history = new ProductDividendCalculationHistory();
            String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                    .prefix("DIV" + System.currentTimeMillis())
                    .postfix(RandomCodeBuilder.NUMBERS)
                    .postfixLength(3));
            history.setReferenceNumber(referenceNumber);
            history.setProductOrder(productOrder);

            double periodicRate = productOrder.getDividend() / DividendService.getPayoutFrequency(productOrder.getPayoutFrequency());
            double proratedFactor = DividendService.calculateProratedFactorByMonths(productOrder.getIsProrated(), productOrder.getAgreementDate(), periodStartingDateLocalDate, periodEndingDateLocalDate, null);
            double dividendPayoutAmount = productOrder.getPurchasedAmount() * (periodicRate / 100.00) * proratedFactor;
            history.setDividendAmount(MathUtil.roundHalfUp(dividendPayoutAmount));

            history.setPeriodStartingDate(periodStartingDateLocalDate);
            history.setPeriodEndingDate(periodEndingDateLocalDate);
            history.setClosingDate(periodEndingDateLocalDate);
            if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                if (periodEndingDateLocalDate.getDayOfMonth() > 17) {
                    // If period ending date is after the 17th, set closing date as the end of the month
                    history.setClosingDate(periodEndingDateLocalDate.withDayOfMonth(periodEndingDateLocalDate.lengthOfMonth()));
                }
            }
            history.setPaymentStatus(Status.SUCCESS);
            history.setPaymentDate(DateUtil.convertLocalDateToDate(periodEndingDateLocalDate.plusDays(15)));
            history.setDividendQuarter(dividendCount + 1);
            productDividendCalculationHistoryDao.save(history);
        }
    }

    // Import Product Dividend Calculation History -19
    private MigrationLogRespVo.Tab migrateProductDividendCalculationHistory(String filePath) {
        String tabName = "Product Dividend Calculation History";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Product Dividend Calculation History migration...");
            List<ProductDividendCalculationHistoryMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 19, ProductDividendCalculationHistoryMigrationVo.class);
            // List<ProductDividendCalculationHistoryMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ProductDividendCalculationHistoryMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ProductDividendCalculationHistoryMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number, Quarter Starting Date or Quarter Ending Date is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    record.setAgreementNumber(sanitizeAgreementNumber(record.getAgreementNumber()));

                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Product Order not found: " + record.getAgreementNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }

                    int payoutFrequency = DividendService.getPayoutFrequency(productOrder.getPayoutFrequency());
                    final LocalDate agreementDateLocal = productOrder.getAgreementDate();
                    final LocalDate currentDate = LocalDate.now();

                    //Assume the dividend has been paid until Q1-2025
                    if (ProductDividendSchedule.StructureType.FIXED.equals(productOrder.getStructureType())) {
                        LocalDate firstPeriodStartingDate = DividendService.calculateFixedPeriodStartingDate(agreementDateLocal, payoutFrequency);
                        LocalDate firstPeriodEndingDate = DividendService.calculateFixedPeriodEndingDate(firstPeriodStartingDate, payoutFrequency);

                        LocalDate periodStartingDate = firstPeriodStartingDate;
                        LocalDate periodEndingDate = firstPeriodEndingDate;

                        int dividendCount = 0;
                        while (!(periodStartingDate.isBefore(currentDate) && periodEndingDate.isAfter(currentDate))) {
                            // Your custom logic here
                            createAndSaveProductDividendCalculationHistory(productOrder, periodStartingDate, periodEndingDate, dividendCount);

                            periodStartingDate = periodEndingDate.plusDays(1);
                            periodEndingDate = periodStartingDate.plusMonths(12 / payoutFrequency).minusDays(1);
                            dividendCount++;
                        }
                    }
                    if (ProductDividendSchedule.StructureType.FLEXIBLE.equals(productOrder.getStructureType())) {
                        LocalDate firstPeriodStartingDate = productOrder.getAgreementDate();
                        LocalDate firstPeriodEndingDate = DividendService.calculateFlexiblePeriodEndingDate(firstPeriodStartingDate, payoutFrequency);

                        LocalDate periodStartingDate = firstPeriodStartingDate;
                        LocalDate periodEndingDate = firstPeriodEndingDate;

                        int dividendCount = 0;
                        while (!(periodStartingDate.isBefore(currentDate) && periodEndingDate.isAfter(currentDate))) {
                            // Your custom logic here
                            createAndSaveProductDividendCalculationHistory(productOrder, periodStartingDate, periodEndingDate, dividendCount);

                            periodStartingDate = periodEndingDate.plusDays(1);
                            periodEndingDate = DividendService.calculateFlexiblePeriodEndingDate(periodStartingDate, payoutFrequency);
                            dividendCount++;
                        }
                    }

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Product Dividend Calculation History Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Product Dividend Calculation History migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Agent Commission History -20
    private MigrationLogRespVo.Tab migrateAgentCommissionHistory(String filePath) {
        String tabName = "Agent Commission History";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Agent Commission History migration...");
            List<AgentCommissionHistoryMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 20, AgentCommissionHistoryMigrationVo.class);
            // List<AgentCommissionHistoryMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, AgentCommissionHistoryMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                AgentCommissionHistoryMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber()) || StringUtil.isEmpty(record.getManagerIdentityCardNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number or Manager Identity Card Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    record.setAgreementNumber(sanitizeAgreementNumber(record.getAgreementNumber()));

                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        continue;
                    }
                    AgentCommissionCalculationHistory history = null;
                    Agent mgrAgent = agentDao.findAgentByIdentityCardNumber(record.getManagerIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                    if (mgrAgent == null) {
                        log.warn("Manager Agent not found for record {} : {}", (i + 2), record.getManagerIdentityCardNumber());
                        continue;
                    }

                    //If monthly commission
                    List<AgentCommissionConfigurationVo> configList = agentCommissionConfigurationDao.findAllMonthlyAgentCommissionConfigurations();
                    Set<Long> monthlyProductIdList = configList.stream().map(AgentCommissionConfigurationVo::getProductId).collect(Collectors.toSet());
                    if (!monthlyProductIdList.isEmpty()) {
                        if (monthlyProductIdList.contains(productOrder.getProduct().getId())) {
                            history = agentCommissionCalculationHistoryDao.findFirstByProductOrderIdAndMgrIdOrderByIdDesc(productOrder.getId(), mgrAgent.getId()).orElse(null);
                        }
                    }

                    if (history == null) {
                        history = new AgentCommissionCalculationHistory();
                        String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                                .prefix("COM" + System.currentTimeMillis())
                                .postfix(RandomCodeBuilder.NUMBERS)
                                .postfixLength(3));
                        history.setReferenceNumber(referenceNumber);
                    }
                    history.setOrderSubmissionDate(productOrder.getSubmissionDate());
                    history.setOrderAgreementDate(productOrder.getAgreementDate());
                    history.setClientName(productOrder.getClientName());
                    history.setOrderAgreementNumber(productOrder.getAgreementFileName());
                    history.setPurchasedAmount(productOrder.getPurchasedAmount());
                    history.setProductId(productOrder.getProduct().getId());
                    history.setProductOrderId(productOrder.getId());
                    history.setProductOrderType(productOrder.getProductOrderType());
                    history.setMgrId(mgrAgent.getId());
                    history.setMgrDigitalId(mgrAgent.getAgentId());
                    history.setMgrName(mgrAgent.getUserDetail().getName());
                    history.setMgrRole(mgrAgent.getAgentRole().getRoleCode());
                    history.setMgrCommissionPercentage(Double.valueOf(record.getManagerCommissionPercentage()));
                    history.setMgrCommissionAmount(Double.valueOf(record.getManagerCommissionAmount()));

                    // P2P
                    if (StringUtil.isNotEmpty(record.getP2pIdentityCardNumber())) {
                        Agent p2pAgent = agentDao.findAgentByIdentityCardNumber(record.getManagerIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                        Optional.ofNullable(p2pAgent).map(Agent::getId).ifPresent(history::setP2pId);
                        Optional.ofNullable(p2pAgent).map(Agent::getAgentId).ifPresent(history::setP2pDigitalId);
                        Optional.ofNullable(p2pAgent).map(Agent::getUserDetail).map(UserDetail::getName).ifPresent(history::setP2pName);
                        history.setP2pCommissionPercentage(Double.valueOf(record.getP2pCommissionPercentage()));
                        history.setP2pCommissionAmount(Double.valueOf(record.getP2pCommissionAmount()));
                    }
                    // SM
                    if (StringUtil.isNotEmpty(record.getSmIdentityCardNumber())) {
                        Agent smAgent = agentDao.findAgentByIdentityCardNumber(record.getSmIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                        Optional.ofNullable(smAgent).map(Agent::getId).ifPresent(history::setSmId);
                        Optional.ofNullable(smAgent).map(Agent::getAgentId).ifPresent(history::setSmDigitalId);
                        Optional.ofNullable(smAgent).map(Agent::getUserDetail).map(UserDetail::getName).ifPresent(history::setSmName);
                        history.setSmCommissionPercentage(Double.valueOf(record.getSmCommissionPercentage()));
                        history.setSmCommissionAmount(Double.valueOf(record.getSmCommissionAmount()));
                    }
                    // AVP
                    if (StringUtil.isNotEmpty(record.getAvpIdentityCardNumber())) {
                        Agent avpAgent = agentDao.findAgentByIdentityCardNumber(record.getAvpIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                        Optional.ofNullable(avpAgent).map(Agent::getId).ifPresent(history::setAvpId);
                        Optional.ofNullable(avpAgent).map(Agent::getAgentId).ifPresent(history::setAvpDigitalId);
                        Optional.ofNullable(avpAgent).map(Agent::getUserDetail).map(UserDetail::getName).ifPresent(history::setAvpName);
                        history.setAvpCommissionPercentage(Double.valueOf(record.getAvpCommissionPercentage()));
                        history.setAvpCommissionAmount(Double.valueOf(record.getAvpCommissionAmount()));
                    }
                    // VP
                    if (StringUtil.isNotEmpty(record.getVpIdentityCardNumber())) {
                        Agent vpAgent = agentDao.findAgentByIdentityCardNumber(record.getVpIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                        Optional.ofNullable(vpAgent).map(Agent::getId).ifPresent(history::setVpId);
                        Optional.ofNullable(vpAgent).map(Agent::getAgentId).ifPresent(history::setVpDigitalId);
                        Optional.ofNullable(vpAgent).map(Agent::getUserDetail).map(UserDetail::getName).ifPresent(history::setVpName);
                        history.setVpCommissionPercentage(Double.valueOf(record.getVpCommissionPercentage()));
                        history.setVpCommissionAmount(Double.valueOf(record.getVpCommissionAmount()));
                    }
                    // SVP
                    if (StringUtil.isNotEmpty(record.getSvpIdentityCardNumber())) {
                        Agent svpAgent = agentDao.findAgentByIdentityCardNumber(record.getSvpIdentityCardNumber(), Agent.AgentStatus.ACTIVE);
                        Optional.ofNullable(svpAgent).map(Agent::getId).ifPresent(history::setSvpId);
                        Optional.ofNullable(svpAgent).map(Agent::getAgentId).ifPresent(history::setSvpDigitalId);
                        Optional.ofNullable(svpAgent).map(Agent::getUserDetail).map(UserDetail::getName).ifPresent(history::setSvpName);
                    }
                    history.setCalculatedDate(LocalDate.parse(record.getCommissionCalculatedDate()));
                    history.setGeneratedCommissionFile(true);
                    agentCommissionCalculationHistoryDao.save(history);


                    // Agent Commission History
                    // MGR
                    AgentCommissionHistory mgrCommissionHistory = agentCommissionHistoryDao.findFirstByAgentIdAndAgentCommissionCalculationHistoryOrderByIdDesc(history.getMgrDigitalId(), history).orElseGet(AgentCommissionHistory::new);
                    mgrCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.PERSONAL);
                    mgrCommissionHistory.setAgentId(history.getMgrDigitalId());
                    mgrCommissionHistory.setAgentCommissionCalculationHistory(history);
                    mgrCommissionHistory.setCommissionPercentage(history.getMgrCommissionPercentage());
                    mgrCommissionHistory.setCommissionAmount(history.getMgrCommissionAmount());
                    mgrCommissionHistory.setPaymentStatus(Status.SUCCESS);
                    mgrCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    agentCommissionHistoryDao.save(mgrCommissionHistory);

                    // P2P
                    if (StringUtil.isNotEmpty(history.getP2pDigitalId()) && history.getP2pCommissionAmount() > 0) {
                        AgentCommissionHistory p2pCommissionHistory = new AgentCommissionHistory();
                        p2pCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        p2pCommissionHistory.setAgentId(history.getP2pDigitalId());
                        p2pCommissionHistory.setAgentCommissionCalculationHistory(history);
                        p2pCommissionHistory.setCommissionPercentage(history.getP2pCommissionPercentage());
                        p2pCommissionHistory.setCommissionAmount(history.getP2pCommissionAmount());
                        p2pCommissionHistory.setPaymentStatus(Status.SUCCESS);
                        p2pCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                        agentCommissionHistoryDao.save(p2pCommissionHistory);
                    }
                    // SM
                    if (StringUtil.isNotEmpty(history.getSmDigitalId()) && history.getSmCommissionAmount() > 0) {
                        AgentCommissionHistory smCommissionHistory = new AgentCommissionHistory();
                        smCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        smCommissionHistory.setAgentId(history.getSmDigitalId());
                        smCommissionHistory.setAgentCommissionCalculationHistory(history);
                        smCommissionHistory.setCommissionPercentage(history.getSmCommissionPercentage());
                        smCommissionHistory.setCommissionAmount(history.getSmCommissionAmount());
                        smCommissionHistory.setPaymentStatus(Status.SUCCESS);
                        smCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                        agentCommissionHistoryDao.save(smCommissionHistory);
                    }
                    // AVP
                    if (StringUtil.isNotEmpty(history.getAvpDigitalId()) && history.getAvpCommissionAmount() > 0) {
                        AgentCommissionHistory avpCommissionHistory = new AgentCommissionHistory();
                        avpCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        avpCommissionHistory.setAgentId(history.getAvpDigitalId());
                        avpCommissionHistory.setAgentCommissionCalculationHistory(history);
                        avpCommissionHistory.setCommissionPercentage(history.getAvpCommissionPercentage());
                        avpCommissionHistory.setCommissionAmount(history.getAvpCommissionAmount());
                        avpCommissionHistory.setPaymentStatus(Status.SUCCESS);
                        avpCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                        agentCommissionHistoryDao.save(avpCommissionHistory);
                    }
                    // VP
                    if (StringUtil.isNotEmpty(history.getVpDigitalId()) && history.getVpCommissionAmount() > 0) {
                        AgentCommissionHistory vpCommissionHistory = new AgentCommissionHistory();
                        vpCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        vpCommissionHistory.setAgentId(history.getVpDigitalId());
                        vpCommissionHistory.setAgentCommissionCalculationHistory(history);
                        vpCommissionHistory.setCommissionPercentage(history.getVpCommissionPercentage());
                        vpCommissionHistory.setCommissionAmount(history.getVpCommissionAmount());
                        vpCommissionHistory.setPaymentStatus(Status.SUCCESS);
                        vpCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                        agentCommissionHistoryDao.save(vpCommissionHistory);
                    }

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Agent Commission History Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Agent Commission History migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Agency Commission History -21
    private MigrationLogRespVo.Tab migrateAgencyCommissionHistory(String filePath) {
        String tabName = "Agency Commission History";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Agency Commission History migration...");
            List<AgencyCommissionHistoryMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 21, AgencyCommissionHistoryMigrationVo.class);
            // List<AgencyCommissionHistoryMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, AgencyCommissionHistoryMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                AgencyCommissionHistoryMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber()) || StringUtil.isEmpty(record.getAgencyRegistrationNumber())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number or Agency Registration Number is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    record.setAgreementNumber(sanitizeAgreementNumber(record.getAgreementNumber()));

                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        continue;
                    }
                    Agency agency = agencyDao.findAgencyByAgencyRegNumber(record.getAgencyRegistrationNumber());
                    if (agency == null) {
                        log.warn("Agency not found for record {} : {}", (i + 2), record.getAgencyRegistrationNumber());
                        continue;
                    }

                    AgencyCommissionCalculationHistory history = agencyCommissionCalculationHistoryDao.findFirstByAgencyIdAndProductOrderId(agency.getId(), productOrder.getId()).orElse(null);
                    if (history == null) {
                        history = new AgencyCommissionCalculationHistory();
                        history.setAgencyId(agency.getId());
                        String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                                .prefix("COM" + System.currentTimeMillis())
                                .postfix(RandomCodeBuilder.NUMBERS)
                                .postfixLength(3));
                        history.setReferenceNumber(referenceNumber);
                        history.setAgencyName(agency.getAgencyName());
                        history.setProductId(productOrder.getProduct().getId());
                        history.setProductOrderId(productOrder.getId());
                        history.setProductOrderType(productOrder.getProductOrderType());
                        history.setPurchasedAmount(productOrder.getPurchasedAmount());
                        history.setClientName(productOrder.getClientName());
                        history.setOrderSubmissionDate(productOrder.getSubmissionDate());
                        history.setOrderAgreementDate(productOrder.getAgreementDate());
                        history.setOrderAgreementNumber(productOrder.getAgreementFileName());
                        history.setGeneratedCommissionFile(true);
                    }
                    history.setYtdSales(Double.valueOf(record.getYtdSales()));
                    history.setCommissionRate(Double.valueOf(record.getAgencyCommissionPercentage()));
                    history.setCommissionAmount(Double.valueOf(record.getAgencyCommissionAmount()));
                    history.setCalculatedDate(LocalDate.parse(record.getCalculatedDate()));
                    history.setPaymentStatus(Status.SUCCESS);
                    if (StringUtil.isNotEmpty(record.getPaymentDate())) {
                        history.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    } else {
                        history.setPaymentDate(new Date());
                    }
                    agencyCommissionCalculationHistoryDao.save(history);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Agency Commission History Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Agency Commission History migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Product Redemption -22
    private MigrationLogRespVo.Tab migrateProductRedemption(String filePath) {
        String tabName = "Product Redemption";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Product Redemption migration...");
            List<ProductOrderRedemptionMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 22, ProductOrderRedemptionMigrationVo.class);
            // List<ProductOrderRedemptionMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ProductOrderRedemptionMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ProductOrderRedemptionMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber()) || StringUtil.isEmpty(record.getWithdrawalMethod())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number or Withdrawal Method is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                        tabContent.setRowNumber(i + 2);
                        tabContent.setRowError("Product Order not found: " + record.getAgreementNumber());
                        tab.getTabContentList().add(tabContent);
                        continue;
                    }
                    ProductRedemption redemption = productRedemptionDao.findByProductOrder(productOrder);
                    if (redemption == null) {
                        redemption = new ProductRedemption();
                        redemption.setProductOrder(productOrder);
                    }
                    redemption.setFundStatus(productOrder.getStatus());
                    redemption.setRedemptionType(StringUtil.getEnumFromString(ProductRedemption.RedemptionType.class, record.getWithdrawalMethod()));
                    redemption.setAmount(Double.valueOf(record.getWithdrawalAmount()));
                    redemption.setStatus(Status.SUCCESS);
                    redemption.setStatusChecker(CmsAdmin.CheckerStatus.APPROVE_CHECKER);
                    redemption.setStatusApprover(CmsAdmin.ApproverStatus.APPROVE_APPROVER);
                    redemption.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                    redemption.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    redemption.setUpdatedBankResult(true);
                    redemption.setGeneratedBankFile(true);
                    productRedemptionDao.save(redemption);

                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Product Redemption Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Product Redemption migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    // Import Product Early Redemption -23
    private MigrationLogRespVo.Tab migrateProductEarlyRedemption(String filePath) {
        String tabName = "Product Early Redemption";
        MigrationLogRespVo.Tab tab = new MigrationLogRespVo.Tab();
        tab.setTabName(tabName);
        try {
            log.info("Starting Product Early Redemption migration...");
            List<ProductOrderEarlyRedemptionMigrationVo> records = ExcelSaxBeanMapper.processExcelFile(filePath, 23, ProductOrderEarlyRedemptionMigrationVo.class);
            // List<ProductOrderEarlyRedemptionMigrationVo> records = parseSheetFromWorkbookToVoClass(sheet, ProductOrderEarlyRedemptionMigrationVo.class, ExcelService.ParseStrategy.COLUMN_NAME);
            if (records.isEmpty() || records.size() < 3) {
                log.warn("File is empty or has less than 3 records");
                tab.setMessage("File is empty or has less than 3 records");
                return tab;
            }
            // Skip row 2 and row 3 (index 1 and 2)
            int totalRecordsProcessedSuccessfully = 0;
            for (int i = 2; i < records.size(); i++) {
                ProductOrderEarlyRedemptionMigrationVo record = records.get(i);
                if (StringUtil.isEmpty(record.getAgreementNumber()) || StringUtil.isEmpty(record.getWithdrawalMethod())) {
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError("Agreement Number or Early Redemption Type is empty");
                    tab.getTabContentList().add(tabContent);
                    continue;
                }
                try {
                    log.info("Processing record {} : {}", (i + 2), record.getAgreementNumber());
                    ProductOrder productOrder = productOrderDao.findByAgreementFileName(record.getAgreementNumber());
                    if (productOrder == null) {
                        log.warn("Product Order not found for record {} : {}", (i + 2), record.getAgreementNumber());
                        continue;
                    }
                    ProductEarlyRedemptionHistory earlyRedemption = new ProductEarlyRedemptionHistory();
                    earlyRedemption.setRedemptionReferenceNumber(RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                            .prefix("RED" + System.currentTimeMillis())
                            .postfix(RandomCodeBuilder.NUMBERS)
                            .postfixLength(3)));
                    earlyRedemption.setProductOrder(productOrder);
                    earlyRedemption.setOrderReferenceNumber(productOrder.getOrderReferenceNumber());
                    earlyRedemption.setWithdrawalMethod(StringUtil.getEnumFromString(RedemptionMethod.class, record.getWithdrawalMethod()));
                    earlyRedemption.setAmount(Double.valueOf(record.getWithdrawalAmount()));
                    earlyRedemption.setPenaltyAmount(Double.valueOf(record.getPenaltyAmount()));
                    earlyRedemption.setPenaltyPercentage(Double.valueOf(record.getPenaltyPercentage()));
                    earlyRedemption.setStatus(Status.SUCCESS);
                    earlyRedemption.setStatusChecker(CmsAdmin.CheckerStatus.APPROVE_CHECKER);
                    earlyRedemption.setStatusApprover(CmsAdmin.ApproverStatus.APPROVE_APPROVER);
                    earlyRedemption.setClientSignatureStatus(Status.SUCCESS);
                    earlyRedemption.setWitnessSignatureStatus(Status.SUCCESS);
                    earlyRedemption.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                    earlyRedemption.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                    earlyRedemption.setGeneratedBankFile(true);
                    earlyRedemption.setUpdatedBankResult(true);
                    earlyRedemption.setAgent(productOrder.getAgent());
                    productEarlyRedemptionHistoryDao.save(earlyRedemption);


                    log.info("Record {} : processed successfully", (i + 2));
                    totalRecordsProcessedSuccessfully++;
                } catch (Exception ex) {
                    log.error("Error in {} : for record : {}", getFunctionName(), (i + 2), ex);
                    MigrationLogRespVo.Tab.TabContent tabContent = new MigrationLogRespVo.Tab.TabContent();
                    tabContent.setRowNumber(i + 2);
                    tabContent.setRowError(ex.getMessage());
                    tab.getTabContentList().add(tabContent);
                }
            }
            log.info("Total Product Early Redemption Processed: {}", totalRecordsProcessedSuccessfully);
            log.info("Product Early Redemption migration completed successfully.");
            log.info("{} success response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        } catch (Exception ex) {
            log.error("Error in {}: ", getFunctionName(), ex);
            tab.setMessage(ex.getMessage());
            log.info("{} error response : {}", getFunctionName(), gson.toJson(tab));
            return tab;
        }
    }

    private <T> T findWithCustomErrorHandling(Supplier<T> querySupplier, String tableName, String fieldName, Object fieldValue, int recordIndex) {
        try {
            return querySupplier.get();
        } catch (IncorrectResultSizeDataAccessException e) {
            String errorMessage = String.format("record %d : Duplicate entry found for %s '%s' in %s table. Expected 1 result but found %d",
                    recordIndex,
                    fieldName,
                    fieldValue,
                    tableName,
                    e.getActualSize());
            throw new RuntimeException(errorMessage);
        }
    }


    public static void main(String[] args) {
        String test = null;
        System.out.println(test.strip());
    }
}