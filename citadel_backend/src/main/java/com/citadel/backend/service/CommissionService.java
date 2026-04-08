package com.citadel.backend.service;

import com.citadel.backend.dao.AgencyDao;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.BankDetailsDao;
import com.citadel.backend.dao.Commission.*;
import com.citadel.backend.dao.Products.ProductDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.entity.Agent;
import com.citadel.backend.entity.BankDetails;
import com.citadel.backend.entity.Commission.*;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.CimbBankVo;
import com.citadel.backend.vo.Commission.*;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.SendGrid.Attachment;
import io.micrometer.common.util.StringUtils;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@Service
public class CommissionService extends BaseService {

    @Resource
    private AgencyCommissionConfigurationDao agencyCommissionConfigurationDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private AgencyCommissionCalculationHistoryDao agencyCommissionCalculationHistoryDao;
    @Resource
    private AgentCommissionConfigurationDao agentCommissionConfigurationDao;
    @Resource
    private AgentDao agentDao;
    @Resource
    private AgentCommissionCalculationHistoryDao agentCommissionCalculationHistoryDao;
    @Resource
    private ExcelService excelService;
    @Resource
    private ProductCommissionHistoryDao productCommissionHistoryDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private EmailService emailService;
    @Resource
    private AgentCommissionHistoryDao agentCommissionHistoryDao;
    @Resource
    private AgencyProductTierDao agencyProductTierDao;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");

    @Service
    public class AgencyCommissionService {
        // calculateAgencyHoldingPeriodCommission
        public void calculateAndSaveAgencyMonthlyCommission(CommissionProductOrderVo commissionProductOrderVo) {
            try {
                double previousTotalSales = commissionProductOrderVo.getPreviousTotalSales();
                double currentTotalSales = commissionProductOrderVo.getPurchasedAmount();
                double thresholdAmount = commissionProductOrderVo.getThreshold();
                double baseCommission = commissionProductOrderVo.getBaseCommissionRate();
                double commissionAboveThreshold = commissionProductOrderVo.getCommissionAboveThreshold();

                if (baseCommission < 0 || commissionAboveThreshold < 0) {
                    throw new IllegalArgumentException("Commission rate cannot be negative");
                }

                baseCommission = baseCommission / 100; // Convert percentage to decimal
                commissionAboveThreshold = commissionAboveThreshold / 100; // Convert percentage to decimal

                double totalSales = previousTotalSales + currentTotalSales;
                commissionProductOrderVo.setYtdSales(totalSales);
                double totalCommission;
                if (totalSales > thresholdAmount && baseCommission < commissionAboveThreshold) {
                    // Calculate the part of sales below the thresholdAmount
                    double salesBelowThreshold = Math.max(thresholdAmount - previousTotalSales, 0);
                    if (salesBelowThreshold > 0) {
                        double commissionAmountBelowThreshold = salesBelowThreshold * baseCommission;
                        commissionProductOrderVo.setCommissionRate(baseCommission);
                        commissionProductOrderVo.setCommissionAmount(commissionAmountBelowThreshold);
                        saveAgencyCommissionCalculationHistory(commissionProductOrderVo);
                    }

                    // Calculate the part of sales above the thresholdAmount
                    double salesAboveThreshold = currentTotalSales - salesBelowThreshold;
                    double commissionAmountAboveThreshold = salesAboveThreshold * commissionAboveThreshold;
                    commissionProductOrderVo.setCommissionRate(commissionAboveThreshold);
                    commissionProductOrderVo.setCommissionAmount(commissionAmountAboveThreshold);
                    saveAgencyCommissionCalculationHistory(commissionProductOrderVo);
                } else {
                    totalCommission = currentTotalSales * baseCommission;
                    commissionProductOrderVo.setCommissionRate(baseCommission);
                    commissionProductOrderVo.setCommissionAmount(totalCommission);
                    saveAgencyCommissionCalculationHistory(commissionProductOrderVo);
                }
            } catch (Exception ex) {
                log.error("Error calculating commission for product order: {}", commissionProductOrderVo.getAgreementFileName(), ex);
                throw new GeneralException("Error calculating commission " + ex.getMessage());
            }
        }

        private double[] calculateProductOrderBaseCommission(Long agencyId, Long productId, LocalDate startDate, LocalDate endDate, ProductOrderType productOrderType) {
            // Calculate total purchased amount
            double totalSales = agencyCommissionCalculationHistoryDao.calculateTotalPurchasedAmountByAgencyAndProductAndDateRange(agencyId, productId, startDate, endDate, productOrderType)
                    .orElse(0.0);

            // Calculate base commission based on total sales
            double baseCommission = agencyCommissionConfigurationDao.findCommissionRateByProductAndProductTypeAndThreshold(productId, productOrderType, totalSales).orElse(0.0);
            // Return both totalSales and baseCommission as an array
            return new double[]{totalSales, baseCommission};
        }

        public Map<ProductOrderType, List<CommissionProductOrderVo>> sortCommissionProductOrderVoByProductOrderType(List<CommissionProductOrderVo> commissionProductOrderVoList) {
            if (commissionProductOrderVoList == null || commissionProductOrderVoList.isEmpty()) {
                return new HashMap<>();
            }
            return commissionProductOrderVoList.stream()
                    .filter(vo -> vo.getProductOrderType() != null) // Exclude null ProductOrderType
                    .collect(Collectors.groupingBy(CommissionProductOrderVo::getProductOrderType));
        }

        public void calculateCommissionByProductOrderType(ProductOrderType productOrderType, Long productId, List<CommissionProductOrderVo> commissionProductOrderVoList, Double previousTotalSales, Double baseCommission, Boolean saveTier, Integer currentYear, Integer previousYear, Long agencyId) {
            if (commissionProductOrderVoList == null || commissionProductOrderVoList.isEmpty()) {
                return;
            }
            AgencyMonthlyCommissionConfigurationVo configVo = agencyCommissionConfigurationDao.findByProductIdAndProductOrderTypeAndConditionType(productId, productOrderType, AgencyCommissionConfiguration.AgencyCommissionConfigCondition.ABOVE);
            // Calculate commission for each product order type
            Double ytdTotalSales = previousTotalSales;
            for (CommissionProductOrderVo commissionProductOrderVo : commissionProductOrderVoList) {
                Double purchasedAmount = commissionProductOrderVo.getPurchasedAmount();
                commissionProductOrderVo.setPreviousTotalSales(ytdTotalSales);
                commissionProductOrderVo.setThreshold(configVo.getThreshold());
                commissionProductOrderVo.setBaseCommissionRate(baseCommission);
                commissionProductOrderVo.setCommissionAboveThreshold(configVo.getCommission());
                calculateAndSaveAgencyMonthlyCommission(commissionProductOrderVo);
                ytdTotalSales += purchasedAmount;
            }
            if (saveTier) {
                AgencyProductTier previousYearTier = agencyProductTierDao.findByAgencyIdAndProductIdAndProductOrderTypeAndYear(agencyId, productId, productOrderType, previousYear);
                double tier2CommissionRate = 0.0;
                if (previousYearTier != null) {
                    tier2CommissionRate = agencyCommissionConfigurationDao.findCommissionRateForTier2(productId, productOrderType, AgencyCommissionConfiguration.AgencyCommissionConfigCondition.TIER2, ytdTotalSales).orElse(0.0);
                } else if (ytdTotalSales >= configVo.getThreshold()) {
                    tier2CommissionRate = configVo.getCommission();
                }

                if (tier2CommissionRate > 0.0) {
                    AgencyProductTier tierToSave = new AgencyProductTier();
                    tierToSave.setAgencyId(agencyId);
                    tierToSave.setProductId(productId);
                    tierToSave.setProductOrderType(productOrderType);
                    tierToSave.setYear(currentYear);
                    tierToSave.setCommission(tier2CommissionRate);
                    agencyProductTierDao.save(tierToSave);
                }
            }
        }

        public void saveAgencyCommissionCalculationHistory(CommissionProductOrderVo commissionProductOrderVo) throws Exception {
            if (commissionProductOrderVo != null) {
                AgencyCommissionCalculationHistory history = new AgencyCommissionCalculationHistory();
                history.setAgencyId(commissionProductOrderVo.getAgencyId());
                String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                        .prefix("COM" + System.currentTimeMillis())
                        .postfix(RandomCodeBuilder.NUMBERS)
                        .postfixLength(3));
                history.setReferenceNumber(referenceNumber);
                history.setAgencyName(commissionProductOrderVo.getAgencyName());
                history.setProductId(commissionProductOrderVo.getProductId());
                history.setProductOrderId(commissionProductOrderVo.getId());
                history.setProductOrderType(commissionProductOrderVo.getProductOrderType());
                history.setPurchasedAmount(commissionProductOrderVo.getPurchasedAmount());
                history.setYtdSales(commissionProductOrderVo.getYtdSales());
                history.setCommissionRate(commissionProductOrderVo.getCommissionRate() * 100);
                history.setCommissionAmount(commissionProductOrderVo.getCommissionAmount());
                history.setClientName(commissionProductOrderVo.getClientName());
                history.setOrderSubmissionDate(commissionProductOrderVo.getSubmissionDate());
                history.setOrderAgreementDate(commissionProductOrderVo.getAgreementDate());
                history.setOrderAgreementNumber(commissionProductOrderVo.getAgreementFileName());
                history.setCalculatedDate(commissionProductOrderVo.getCalculatedDate());
                history.setGeneratedCommissionFile(Boolean.FALSE);
                history.setCreatedAt(new Date());
                history.setUpdatedAt(new Date());
                agencyCommissionCalculationHistoryDao.save(history);
            }
        }

        //Called by cron executes 1st day of every month
        public void processAgencyMonthlyCommission(LocalDate currentDate) {
            if (currentDate == null) {
                currentDate = LocalDate.now();
            }
            // Get the first day of the calculating month
            LocalDate calculatingMonthStartDate = currentDate.minusMonths(1).withDayOfMonth(1);
            // Get the last day of the calculating month
            LocalDate calculatingMonthEndDate = calculatingMonthStartDate.withDayOfMonth(calculatingMonthStartDate.lengthOfMonth());
            // Get the first day of the calculating year
            LocalDate calculatingYearStartDate = calculatingMonthStartDate.withDayOfYear(1);
            // Get the last day of the calculating year
            LocalDate calculatingYearEndDate = calculatingYearStartDate.withDayOfYear(calculatingYearStartDate.lengthOfYear());

            //Find all products with monthly commission configurations, fail-safe
            Set<Long> productIdList = agencyCommissionConfigurationDao.findAllProductIdWithMonthlyConfigurations();

            //Find all agencies
            List<Long> agencyIdList = agencyDao.findAgencyIdsByAgencyType(AgencyType.OTHER);

            //Sort the products by product id sold by each agency
            Map<Long, Map<Long, List<CommissionProductOrderVo>>> agencyProductOrderMapByProduct = new HashMap<>();
            for (Long agencyId : agencyIdList) {
                List<CommissionProductOrderVo> orders = productOrderDao.findProductOrdersByAgencyAndByDateRange(agencyId, calculatingMonthStartDate, calculatingMonthEndDate, ProductOrder.ProductOrderStatus.ACTIVE, productIdList);
                // Group by product ID
                LocalDate finalCurrentDate = currentDate;
                Map<Long, List<CommissionProductOrderVo>> productOrderMap = orders.stream()
                        .peek(order -> order.setCalculatedDate(finalCurrentDate))
                        .collect(Collectors.groupingBy(CommissionProductOrderVo::getProductId));

                // Associate the product orders with the agency
                agencyProductOrderMapByProduct.put(agencyId, productOrderMap);
            }

            //Calculate commission for each product sold by each agency
            // Previous year's start and end dates
            LocalDate previousYearStartDate = calculatingYearStartDate.minusYears(1).withDayOfYear(1);
            LocalDate previousYearEndDate = previousYearStartDate.withDayOfYear(previousYearStartDate.lengthOfYear());

            agencyProductOrderMapByProduct.forEach((agencyId, productOrderMap) -> productOrderMap.forEach((productId, productOrderList) -> {
                // Sort the product orders by product order type
                Map<ProductOrderType, List<CommissionProductOrderVo>> sortedProductOrderMap = sortCommissionProductOrderVoByProductOrderType(productOrderList);

                //IF tier is null calculate previous year sales to get the base commission
                // Calculate base commissions for NEW product orders for previous year
                double previousYearNewProductOrderBaseCommission = agencyProductTierDao.findCommissionByAgencyIdAndProductIdAndProductOrderTypeAndYear(agencyId, productId, ProductOrderType.NEW, previousYearStartDate.getYear()).orElse(0.0);
                if (previousYearNewProductOrderBaseCommission == 0) {
                    double[] previousYearNewProductResult = calculateProductOrderBaseCommission(agencyId, productId, previousYearStartDate, previousYearEndDate, ProductOrderType.NEW);
                    previousYearNewProductOrderBaseCommission = previousYearNewProductResult[1];
                }
                // Calculate base commissions for NEW product orders for calculating year
                double[] calculatingYearNewProductResult = calculateProductOrderBaseCommission(agencyId, productId, calculatingYearStartDate, calculatingYearEndDate, ProductOrderType.NEW);
                double calculatingYearNewProductOrderTotalSales = calculatingYearNewProductResult[0];
                double calculatingYearNewProductOrderBaseCommission = calculatingYearNewProductResult[1];
                // New product base commission
                double newProductOrderBaseCommission = Math.max(previousYearNewProductOrderBaseCommission, calculatingYearNewProductOrderBaseCommission);

                // Calculate base commissions for ROLLOVER product orders for previous year
                double previousYearRolloverProductOrderBaseCommission = agencyProductTierDao.findCommissionByAgencyIdAndProductIdAndProductOrderTypeAndYear(agencyId, productId, ProductOrderType.ROLLOVER, previousYearStartDate.getYear()).orElse(0.0);
                if (previousYearRolloverProductOrderBaseCommission == 0) {
                    double[] previousYearRolloverProductResult = calculateProductOrderBaseCommission(agencyId, productId, previousYearStartDate, previousYearEndDate, ProductOrderType.ROLLOVER);
                    previousYearRolloverProductOrderBaseCommission = previousYearRolloverProductResult[1];
                }
                // Calculate base commissions for ROLLOVER product orders for calculating year
                double[] calculatingYearRolloverProductResult = calculateProductOrderBaseCommission(agencyId, productId, calculatingYearStartDate, calculatingYearEndDate, ProductOrderType.ROLLOVER);
                double calculatingYearRolloverProductOrderTotalSales = calculatingYearRolloverProductResult[0];
                double calculatingYearRolloverProductOrderBaseCommission = calculatingYearRolloverProductResult[1];
                //Rollover product base commission
                double rolloverProductOrderBaseCommission = Math.max(previousYearRolloverProductOrderBaseCommission, calculatingYearRolloverProductOrderBaseCommission);

                // Calculate commission for NEW product orders
                CompletableFuture.runAsync(() -> calculateCommissionByProductOrderType(ProductOrderType.NEW, productId, sortedProductOrderMap.getOrDefault(ProductOrderType.NEW, Collections.emptyList()), calculatingYearNewProductOrderTotalSales, newProductOrderBaseCommission, calculatingMonthEndDate.isEqual(calculatingYearEndDate), calculatingMonthEndDate.getYear(), previousYearEndDate.getYear(), agencyId));

                // Calculate commission for ROLLOVER product orders
                CompletableFuture.runAsync(() -> calculateCommissionByProductOrderType(ProductOrderType.ROLLOVER, productId, sortedProductOrderMap.getOrDefault(ProductOrderType.ROLLOVER, Collections.emptyList()), calculatingYearRolloverProductOrderTotalSales, rolloverProductOrderBaseCommission, calculatingMonthEndDate.isEqual(calculatingYearEndDate), calculatingMonthEndDate.getYear(), previousYearEndDate.getYear(), agencyId));
            }));
        }

        //Called by cron every 1st and 16th day of month
        public void processAgencyYearlyCommission(LocalDate currentDate) {
            if (currentDate == null) {
                currentDate = LocalDate.now();
            }
            //Subtract one day from the currentDate.
            LocalDate cutoffDate = currentDate.minusDays(1);

            //Find all agencies
            final List<Long> agencyIdList = agencyDao.findAgencyIdsByAgencyType(AgencyType.OTHER);

            // Create yearly commission configuration map grouped by product and year
            Map<Long, Map<Integer, List<AgencyYearlyCommissionConfigurationVo>>> configMapSortedByYear = agencyCommissionConfigurationDao.findAllYearlyCommissionConfigurations().stream()
                    .collect(Collectors.groupingBy(
                            AgencyYearlyCommissionConfigurationVo::getProductId,
                            Collectors.groupingBy(AgencyYearlyCommissionConfigurationVo::getYear)));

            configMapSortedByYear.forEach((productId, yearMap) -> {
                yearMap.forEach((year, configs) -> {
                    configs.forEach(config -> {
                        calculateYearlyCommission(config, cutoffDate, agencyIdList);
                    });
                });
            });
        }

        public void calculateYearlyCommission(AgencyYearlyCommissionConfigurationVo config, LocalDate cutoffDate, List<Long> agencyIdList) {
            Long productId = config.getProductId();
            Integer year = config.getYear();
            ProductOrderType productOrderType = config.getProductOrderType();
            Double commission = config.getCommission();

            LocalDate comparingDate = cutoffDate.minusYears(year);
            LocalDate calculatedDate = cutoffDate.plusDays(1);

            //Query product orders for the given product and year
            List<CommissionProductOrderVo> orders = productOrderDao.findProductOrdersByAgencyAndByYearInterval(comparingDate, productId, productOrderType, agencyIdList);
            if (orders == null || orders.isEmpty()) {
                return;
            }
            orders.forEach(order -> {
                order.setCalculatedDate(calculatedDate);
                order.setBaseCommissionRate(commission);
                try {
                    calculateAndSaveAgencyYearlyCommission(order);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });
        }

        public void calculateAndSaveAgencyYearlyCommission(CommissionProductOrderVo commissionProductOrderVo) throws Exception {
            double commissionRate = commissionProductOrderVo.getBaseCommissionRate() / 100;
            double currentTotalSales = commissionProductOrderVo.getPurchasedAmount();
            double commissionAmount = currentTotalSales * commissionRate;
            commissionProductOrderVo.setCommissionRate(commissionRate);
            commissionProductOrderVo.setCommissionAmount(commissionAmount);
            saveAgencyCommissionCalculationHistory(commissionProductOrderVo);
        }
    }

    @Service
    public class AgentCommissionService {

        private String generateKey(Long productId, ProductOrderType productOrderType) {
            return productId + "-" + productOrderType.name();
        }

        // Agent up line
        public Map<Long, AgentUpLineVo> createAgentUpLineMap(Set<Long> citadelAgentIdList) {
            Map<Long, AgentUpLineVo> agentUpLineMap = new HashMap<>();
            if (citadelAgentIdList != null && !citadelAgentIdList.isEmpty()) {
                citadelAgentIdList.forEach(agentId -> {
                    AgentUpLineVo agentUpLineVo = buildAgentUpLine(agentId);
                    agentUpLineMap.put(agentId, agentUpLineVo);
                });
            }
            return agentUpLineMap;
        }

        public AgentUpLineVo buildAgentUpLine(Long id) {
            try {
                AgentUpLineVo agentUpLineVo = new AgentUpLineVo();
                CitadelAgentVo citadelAgentVo = agentDao.findCitadelAgentVoByAgentId(id);
                if (citadelAgentVo != null) {
                    agentUpLineVo.setMgrId(citadelAgentVo.getAgentId());
                    agentUpLineVo.setMgrDigitalId(citadelAgentVo.getAgentDigitalId());
                    agentUpLineVo.setMgrName(citadelAgentVo.getAgentName());
                    agentUpLineVo.setMgrRole(citadelAgentVo.getAgentRole());

                    CitadelAgentVo currentAgent = citadelAgentVo;
                    while (currentAgent != null && currentAgent.getRecruitManagerId() != null) {
                        Long recruitManagerId = currentAgent.getRecruitManagerId();
                        if (agentUpLineVo.getRecruitMangerId() == null) {
                            agentUpLineVo.setRecruitMangerId(recruitManagerId);
                            agentUpLineVo.setRecruitManagerDigitalId(currentAgent.getRecruitManagerDigitalId());
                            agentUpLineVo.setRecruitManagerName(currentAgent.getRecruitManagerName());
                        }

                        // Fill up based on the recruit manager's role
                        switch (currentAgent.getRecruitManagerRole()) {
                            case MGR -> {
                                if (agentUpLineVo.getP2pAgentId() == null) {
                                    agentUpLineVo.setP2pAgentId(recruitManagerId);
                                    agentUpLineVo.setP2pAgentDigitalId(currentAgent.getRecruitManagerDigitalId());
                                    agentUpLineVo.setP2pAgentName(currentAgent.getRecruitManagerName());
                                }
                            }
                            case SM -> {
                                if (agentUpLineVo.getSmAgentId() == null) {
                                    agentUpLineVo.setSmAgentId(recruitManagerId);
                                    agentUpLineVo.setSmAgentDigitalId(currentAgent.getRecruitManagerDigitalId());
                                    agentUpLineVo.setSmAgentName(currentAgent.getRecruitManagerName());
                                }
                            }
                            case AVP -> {
                                if (agentUpLineVo.getAvpAgentId() == null) {
                                    agentUpLineVo.setAvpAgentId(recruitManagerId);
                                    agentUpLineVo.setAvpAgentDigitalId(currentAgent.getRecruitManagerDigitalId());
                                    agentUpLineVo.setAvpAgentName(currentAgent.getRecruitManagerName());
                                }
                            }
                            case VP -> {
                                if (agentUpLineVo.getVpAgentId() == null) {
                                    agentUpLineVo.setVpAgentId(recruitManagerId);
                                    agentUpLineVo.setVpAgentDigitalId(currentAgent.getRecruitManagerDigitalId());
                                    agentUpLineVo.setVpAgentName(currentAgent.getRecruitManagerName());
                                }
                            }
                            case SVP -> {
                                if (agentUpLineVo.getSvpAgentId() == null) {
                                    agentUpLineVo.setSvpAgentId(recruitManagerId);
                                    agentUpLineVo.setSvpAgentDigitalId(currentAgent.getRecruitManagerDigitalId());
                                    agentUpLineVo.setSvpAgentName(currentAgent.getRecruitManagerName());
                                }
                            }
                        }

                        currentAgent = agentDao.findCitadelAgentVoByAgentId(recruitManagerId);
                    }
                }
                return agentUpLineVo;
            } catch (Exception ex) {
                log.error("Error building agent up line for agent ID: {}", id, ex);
                throw new GeneralException("Error building agent up line " + ex.getMessage());
            }
        }

        public double getMgrCommissionBasedOnRole(AgentRole agentRole, AgentCommissionConfigurationVo productCommissionConfig) {
            return switch (agentRole) {
                case MGR -> productCommissionConfig.getMgrCommissionPercentage();
                case SM ->
                        productCommissionConfig.getMgrCommissionPercentage() + productCommissionConfig.getP2pCommissionPercentage() + productCommissionConfig.getSmCommissionPercentage();
                case AVP ->
                        productCommissionConfig.getMgrCommissionPercentage() + productCommissionConfig.getP2pCommissionPercentage() + productCommissionConfig.getSmCommissionPercentage() + productCommissionConfig.getAvpCommissionPercentage();
                case VP ->
                        productCommissionConfig.getMgrCommissionPercentage() + productCommissionConfig.getP2pCommissionPercentage() + productCommissionConfig.getSmCommissionPercentage() + productCommissionConfig.getAvpCommissionPercentage() + productCommissionConfig.getVpCommissionPercentage();
                default -> 0.0;
            };
        }

        public void calculateAndSaveAgentCommissionAmount(AgentUpLineCommissionVo agentUpLineCommissionVo, CommissionProductOrderVo commissionProductOrderVo) {
            try {
                List<AgentCommissionHistory> agentCommissionHistoryList = new ArrayList<>();
                AgentCommissionCalculationHistory history = new AgentCommissionCalculationHistory();
                String referenceNumber = RandomCodeUtil.generateRandomCode(new RandomCodeBuilder()
                        .prefix("COM" + System.currentTimeMillis())
                        .postfix(RandomCodeBuilder.NUMBERS)
                        .postfixLength(3));
                history.setReferenceNumber(referenceNumber);
                history.setOrderSubmissionDate(commissionProductOrderVo.getSubmissionDate());
                history.setOrderAgreementDate(commissionProductOrderVo.getAgreementDate());
                history.setClientName(commissionProductOrderVo.getClientName());
                history.setOrderAgreementNumber(commissionProductOrderVo.getAgreementFileName());
                history.setPurchasedAmount(commissionProductOrderVo.getPurchasedAmount());
                history.setProductId(commissionProductOrderVo.getProductId());
                history.setProductOrderId(commissionProductOrderVo.getId());
                history.setProductOrderType(commissionProductOrderVo.getProductOrderType());
                history.setCalculatedDate(commissionProductOrderVo.getCalculatedDate());

                double purchasedAmount = commissionProductOrderVo.getPurchasedAmount();

                //MGR Commission Amount
                double mgrCommissionPercentage = agentUpLineCommissionVo.getMgrCommissionPercentage() / 100;
                double mgrCommissionAmount = MathUtil.multiplyAndRoundOff(purchasedAmount, mgrCommissionPercentage, 2);

                history.setMgrId(agentUpLineCommissionVo.getMgrId());
                history.setMgrDigitalId(agentUpLineCommissionVo.getMgrDigitalId());
                history.setMgrName(agentUpLineCommissionVo.getMgrName());
                history.setMgrRole(agentUpLineCommissionVo.getMgrRole());
                history.setMgrCommissionPercentage(agentUpLineCommissionVo.getMgrCommissionPercentage());
                history.setMgrCommissionAmount(mgrCommissionAmount);

                AgentCommissionHistory mgrCommissionHistory = new AgentCommissionHistory();
                mgrCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.PERSONAL);
                mgrCommissionHistory.setAgentId(history.getMgrDigitalId());
                mgrCommissionHistory.setAgentCommissionCalculationHistory(history);
                mgrCommissionHistory.setCommissionPercentage(history.getMgrCommissionPercentage());
                mgrCommissionHistory.setCommissionAmount(history.getMgrCommissionAmount());
                mgrCommissionHistory.setCreatedAt(new Date());
                mgrCommissionHistory.setUpdatedAt(new Date());
                agentCommissionHistoryList.add(mgrCommissionHistory);

                //P2P Commission Amount
                history.setP2pCommissionPercentage(0.0);
                history.setP2pCommissionAmount(0.0);
                if (agentUpLineCommissionVo.getP2pAgentId() != null) {
                    double p2pCommissionPercentage = agentUpLineCommissionVo.getP2pCommissionPercentage() / 100;
                    double p2pCommissionAmount = MathUtil.multiplyAndRoundOff(purchasedAmount, p2pCommissionPercentage, 2);

                    history.setP2pId(agentUpLineCommissionVo.getP2pAgentId());
                    history.setP2pDigitalId(agentUpLineCommissionVo.getP2pAgentDigitalId());
                    history.setP2pName(agentUpLineCommissionVo.getP2pAgentName());
                    history.setP2pCommissionPercentage(agentUpLineCommissionVo.getP2pCommissionPercentage());
                    history.setP2pCommissionAmount(p2pCommissionAmount);

                    if (history.getP2pCommissionAmount() > 0) {
                        AgentCommissionHistory p2pCommissionHistory = new AgentCommissionHistory();
                        p2pCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        p2pCommissionHistory.setAgentId(history.getP2pDigitalId());
                        p2pCommissionHistory.setAgentCommissionCalculationHistory(history);
                        p2pCommissionHistory.setCommissionPercentage(history.getP2pCommissionPercentage());
                        p2pCommissionHistory.setCommissionAmount(history.getP2pCommissionAmount());
                        p2pCommissionHistory.setCreatedAt(new Date());
                        p2pCommissionHistory.setUpdatedAt(new Date());
                        agentCommissionHistoryList.add(p2pCommissionHistory);
                    }
                }

                //SM Commission Amount
                history.setSmCommissionPercentage(0.0);
                history.setSmCommissionAmount(0.0);
                if (agentUpLineCommissionVo.getSmAgentId() != null) {
                    double smCommissionPercentage = agentUpLineCommissionVo.getSmCommissionPercentage() / 100;
                    double smCommissionAmount = MathUtil.multiplyAndRoundOff(purchasedAmount, smCommissionPercentage, 2);

                    history.setSmId(agentUpLineCommissionVo.getSmAgentId());
                    history.setSmDigitalId(agentUpLineCommissionVo.getSmAgentDigitalId());
                    history.setSmName(agentUpLineCommissionVo.getSmAgentName());
                    history.setSmCommissionPercentage(agentUpLineCommissionVo.getSmCommissionPercentage());
                    history.setSmCommissionAmount(smCommissionAmount);

                    if (history.getSmCommissionAmount() > 0) {
                        AgentCommissionHistory smCommissionHistory = new AgentCommissionHistory();
                        smCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        smCommissionHistory.setAgentId(history.getSmDigitalId());
                        smCommissionHistory.setAgentCommissionCalculationHistory(history);
                        smCommissionHistory.setCommissionPercentage(history.getSmCommissionPercentage());
                        smCommissionHistory.setCommissionAmount(history.getSmCommissionAmount());
                        smCommissionHistory.setCreatedAt(new Date());
                        smCommissionHistory.setUpdatedAt(new Date());
                        agentCommissionHistoryList.add(smCommissionHistory);
                    }
                }

                //AVP Commission Amount
                history.setAvpCommissionPercentage(0.0);
                history.setAvpCommissionAmount(0.0);
                if (agentUpLineCommissionVo.getAvpAgentId() != null) {
                    double avpCommissionPercentage = agentUpLineCommissionVo.getAvpCommissionPercentage() / 100;
                    double avpCommissionAmount = MathUtil.multiplyAndRoundOff(purchasedAmount, avpCommissionPercentage, 2);

                    history.setAvpId(agentUpLineCommissionVo.getAvpAgentId());
                    history.setAvpDigitalId(agentUpLineCommissionVo.getAvpAgentDigitalId());
                    history.setAvpName(agentUpLineCommissionVo.getAvpAgentName());
                    history.setAvpCommissionPercentage(agentUpLineCommissionVo.getAvpCommissionPercentage());
                    history.setAvpCommissionAmount(avpCommissionAmount);

                    if (history.getAvpCommissionAmount() > 0) {
                        AgentCommissionHistory avpCommissionHistory = new AgentCommissionHistory();
                        avpCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        avpCommissionHistory.setAgentId(history.getAvpDigitalId());
                        avpCommissionHistory.setAgentCommissionCalculationHistory(history);
                        avpCommissionHistory.setCommissionPercentage(history.getAvpCommissionPercentage());
                        avpCommissionHistory.setCommissionAmount(history.getAvpCommissionAmount());
                        avpCommissionHistory.setCreatedAt(new Date());
                        avpCommissionHistory.setUpdatedAt(new Date());
                        agentCommissionHistoryList.add(avpCommissionHistory);
                    }
                }

                //VP Commission Amount
                history.setVpCommissionPercentage(0.0);
                history.setVpCommissionAmount(0.0);
                if (agentUpLineCommissionVo.getVpAgentId() != null) {
                    double vpCommissionPercentage = agentUpLineCommissionVo.getVpCommissionPercentage() / 100;
                    double vpCommissionAmount = MathUtil.multiplyAndRoundOff(purchasedAmount, vpCommissionPercentage, 2);

                    history.setVpId(agentUpLineCommissionVo.getVpAgentId());
                    history.setVpDigitalId(agentUpLineCommissionVo.getVpAgentDigitalId());
                    history.setVpName(agentUpLineCommissionVo.getVpAgentName());
                    history.setVpCommissionPercentage(agentUpLineCommissionVo.getVpCommissionPercentage());
                    history.setVpCommissionAmount(vpCommissionAmount);

                    if (history.getVpCommissionAmount() > 0) {
                        AgentCommissionHistory vpCommissionHistory = new AgentCommissionHistory();
                        vpCommissionHistory.setCommissionType(AgentCommissionHistory.CommissionType.OVERRIDING);
                        vpCommissionHistory.setAgentId(history.getVpDigitalId());
                        vpCommissionHistory.setAgentCommissionCalculationHistory(history);
                        vpCommissionHistory.setCommissionPercentage(history.getVpCommissionPercentage());
                        vpCommissionHistory.setCommissionAmount(history.getVpCommissionAmount());
                        vpCommissionHistory.setCreatedAt(new Date());
                        vpCommissionHistory.setUpdatedAt(new Date());
                        agentCommissionHistoryList.add(vpCommissionHistory);
                    }
                }

                //SVP Details
                if (agentUpLineCommissionVo.getSvpAgentId() != null) {
                    history.setSvpId(agentUpLineCommissionVo.getSvpAgentId());
                    history.setSvpDigitalId(agentUpLineCommissionVo.getSvpAgentDigitalId());
                    history.setSvpName(agentUpLineCommissionVo.getSvpAgentName());
                }
                history.setGeneratedCommissionFile(Boolean.FALSE);
                history.setCreatedAt(new Date());
                history.setUpdatedAt(new Date());
                agentCommissionCalculationHistoryDao.save(history);

                agentCommissionHistoryDao.saveAll(agentCommissionHistoryList);
            } catch (Exception ex) {
                log.error("Error calculating agent commission for agent ID: {}", agentUpLineCommissionVo.getMgrId(), ex);
                throw new GeneralException("Error calculating agent commission " + ex.getMessage());
            }
        }

        public void calculateAgentCommissionPercentage(AgentCommissionConfigurationVo productCommissionConfig, AgentUpLineVo agentUpLineVo, List<CommissionProductOrderVo> commissionProductOrderVoList) {
            try {
                if (commissionProductOrderVoList == null || commissionProductOrderVoList.isEmpty()) {
                    return;
                }

                AgentUpLineCommissionVo agentUpLineCommissionVo = AgentUpLineCommissionVo.agentUpLineToAgentUpLineCommissionVo(agentUpLineVo);
                double totalMaxCommission = productCommissionConfig.getMgrCommissionPercentage() + productCommissionConfig.getP2pCommissionPercentage() + productCommissionConfig.getSmCommissionPercentage() + productCommissionConfig.getAvpCommissionPercentage() + productCommissionConfig.getVpCommissionPercentage();
                agentUpLineCommissionVo.setTotalMaxCommissionPercentage(totalMaxCommission);

                //MGR Commission %
                agentUpLineCommissionVo.setMgrCommissionPercentage(getMgrCommissionBasedOnRole(agentUpLineCommissionVo.getMgrRole(), productCommissionConfig));

                //P2P Commission %
                if (agentUpLineCommissionVo.getP2pAgentId() != null) {
                    agentUpLineCommissionVo.setP2pCommissionPercentage(productCommissionConfig.getP2pCommissionPercentage());
                } else {
                    agentUpLineCommissionVo.setP2pCommissionPercentage(0.0);
                }

                //SM Commission %
                if (agentUpLineCommissionVo.getSmAgentId() != null) {
                    Double smCommission = totalMaxCommission - (agentUpLineCommissionVo.getMgrCommissionPercentage() + agentUpLineCommissionVo.getP2pCommissionPercentage() + productCommissionConfig.getAvpCommissionPercentage() + productCommissionConfig.getVpCommissionPercentage());
                    agentUpLineCommissionVo.setSmCommissionPercentage(smCommission);
                } else {
                    agentUpLineCommissionVo.setSmCommissionPercentage(0.0);
                }

                //AVP Commission %
                if (agentUpLineCommissionVo.getAvpAgentId() != null) {
                    Double avpCommission = totalMaxCommission - (agentUpLineCommissionVo.getMgrCommissionPercentage() + agentUpLineCommissionVo.getP2pCommissionPercentage() + agentUpLineCommissionVo.getSmCommissionPercentage() + productCommissionConfig.getVpCommissionPercentage());
                    agentUpLineCommissionVo.setAvpCommissionPercentage(avpCommission);
                } else {
                    agentUpLineCommissionVo.setAvpCommissionPercentage(0.0);
                }

                //VP Commission %
                if (agentUpLineCommissionVo.getVpAgentId() != null) {
                    Double vpCommission = totalMaxCommission - (agentUpLineCommissionVo.getMgrCommissionPercentage() + agentUpLineCommissionVo.getP2pCommissionPercentage() + agentUpLineCommissionVo.getSmCommissionPercentage() + agentUpLineCommissionVo.getAvpCommissionPercentage());
                    agentUpLineCommissionVo.setVpCommissionPercentage(vpCommission);
                } else {
                    agentUpLineCommissionVo.setVpCommissionPercentage(0.0);
                }

                commissionProductOrderVoList.forEach(order -> calculateAndSaveAgentCommissionAmount(agentUpLineCommissionVo, order));
            } catch (Exception ex) {
                log.error("Error in {} for agent ID: {}", getFunctionName(), agentUpLineVo.getMgrId(), ex);
                throw new GeneralException("Error calculating agent monthly commission " + ex.getMessage());
            }
        }

        public Map<Long, AgentUpLineVo> getAgentUpLineMap() {
            // Get all citadel agents
            Long citadelAgencyId = null;
            List<Long> agencyIdList = agencyDao.findAgencyIdsByAgencyType(AgencyType.CITADEL);
            if (agencyIdList != null && !agencyIdList.isEmpty()) {
                citadelAgencyId = agencyIdList.get(0);
            }

            if (citadelAgencyId == null) {
                log.error("Citadel agency not found");
                return null;
            }

            Set<Long> citadelAgentIdList = agentDao.findAgentIdsByAgencyId(citadelAgencyId);
            return createAgentUpLineMap(citadelAgentIdList);
        }

        //Monthly Commission
        public void processAgentMonthlyCommission(LocalDate currentDate) {
            try {
                Map<Long, AgentUpLineVo> agentUpLineMap = getAgentUpLineMap();

                if (agentUpLineMap == null) {
                    return;
                }

                if (currentDate == null) {
                    currentDate = LocalDate.now();
                }
                // Get the first day of the calculating month
                LocalDate calculatingMonthStartDate = currentDate.minusMonths(1).withDayOfMonth(1);
                // Get the last day of the calculating month
                LocalDate calculatingMonthEndDate = calculatingMonthStartDate.withDayOfMonth(calculatingMonthStartDate.lengthOfMonth());

                // Get Monthly Commission configurations
                List<AgentCommissionConfigurationVo> configList = agentCommissionConfigurationDao.findAllMonthlyAgentCommissionConfigurations();
                Set<Long> productIdList = configList.stream().map(AgentCommissionConfigurationVo::getProductId).collect(Collectors.toSet());

                Map<String, AgentCommissionConfigurationVo> commissionConfigMap = configList.stream()
                        .collect(Collectors.toMap(
                                config -> generateKey(config.getProductId(), config.getProductOrderType()),
                                config -> config
                        ));

                LocalDate finalCurrentDate = currentDate;
                agentUpLineMap.forEach((agentId, agentUpLineVo) -> {
                    List<CommissionProductOrderVo> orders = productOrderDao.findProductOrdersByAgentAndByDateRange(agentId, calculatingMonthStartDate, calculatingMonthEndDate, ProductOrder.ProductOrderStatus.ACTIVE, productIdList);
                    if (orders == null || orders.isEmpty()) {
                        return;
                    }

                    // Group by ProductId
                    Map<Long, List<CommissionProductOrderVo>> productOrderMap = orders.stream()
                            .peek(order -> order.setCalculatedDate(finalCurrentDate))
                            .collect(Collectors.groupingBy(CommissionProductOrderVo::getProductId));

                    // Group by ProductOrderType
                    productOrderMap.forEach((productId, productOrderList) -> {
                        Map<ProductOrderType, List<CommissionProductOrderVo>> sortedProductOrderMap = productOrderList.stream()
                                .filter(vo -> vo.getProductOrderType() != null) // Exclude null ProductOrderType
                                .collect(Collectors.groupingBy(CommissionProductOrderVo::getProductOrderType));

                        // NEW ProductOrderType
                        String newProductKey = generateKey(productId, ProductOrderType.NEW);
                        AgentCommissionConfigurationVo newProductCommissionConfig = commissionConfigMap.get(newProductKey);

                        CompletableFuture.runAsync(() -> calculateAgentCommissionPercentage(newProductCommissionConfig, agentUpLineVo, sortedProductOrderMap.getOrDefault(ProductOrderType.NEW, Collections.emptyList())));

                        // ROLLOVER ProductOrderType
                        String rolloverProductKey = generateKey(productId, ProductOrderType.ROLLOVER);
                        AgentCommissionConfigurationVo rolloverProductCommissionConfig = commissionConfigMap.get(rolloverProductKey);

                        CompletableFuture.runAsync(() -> calculateAgentCommissionPercentage(rolloverProductCommissionConfig, agentUpLineVo, sortedProductOrderMap.getOrDefault(ProductOrderType.ROLLOVER, Collections.emptyList())));
                    });
                });
            } catch (Exception ex) {
                log.error("Error processing agent monthly commission", ex);
                throw new GeneralException(ex.getMessage());
            }
        }

        //Yearly Commission
        public void processAgentYearlyCommission(LocalDate currentDate) {
            try {
                Map<Long, AgentUpLineVo> agentUpLineMap = getAgentUpLineMap();

                if (agentUpLineMap == null) {
                    return;
                }

                if (currentDate == null) {
                    currentDate = LocalDate.now();
                }

                // Get Yearly Commission configurations
                List<AgentCommissionConfigurationVo> configList = agentCommissionConfigurationDao.findAllYearlyAgentCommissionConfigurations();

                Map<Long, Map<Integer, List<AgentCommissionConfigurationVo>>> configMapSortedByYear = configList.stream()
                        .collect(Collectors.groupingBy(
                                AgentCommissionConfigurationVo::getProductId,
                                Collectors.groupingBy(AgentCommissionConfigurationVo::getYear)));

                LocalDate finalCurrentDate = currentDate;
                configMapSortedByYear.forEach((productId, yearMap) -> {
                    yearMap.forEach((year, configs) -> {
                        configs.forEach(config -> {
                            calculateAgentYearlyCommission(config, finalCurrentDate, agentUpLineMap);
                        });
                    });
                });
            } catch (Exception ex) {
                log.error("Error processing agent yearly commission", ex);
                throw new GeneralException(ex.getMessage());
            }
        }

        public void calculateAgentYearlyCommission(AgentCommissionConfigurationVo config, LocalDate currentDate, Map<Long, AgentUpLineVo> agentUpLineMap) {
            Long productId = config.getProductId();
            Integer year = config.getYear();
            ProductOrderType productOrderType = config.getProductOrderType();

            LocalDate cutoffDate = currentDate.minusMonths(1);

            int yearToDeduct = year - 1;
            LocalDate comparingDate = cutoffDate.minusYears(yearToDeduct);

            agentUpLineMap.forEach((agentId, agentUpLineVo) -> {
                //Query product orders for the given product and year
                List<CommissionProductOrderVo> orders = productOrderDao.findProductOrdersByAgentAndByYearInterval(comparingDate, productId, productOrderType, agentId);
                if (orders == null || orders.isEmpty()) {
                    return;
                }

                orders.forEach(order -> order.setCalculatedDate(currentDate));

                calculateAgentCommissionPercentage(config, agentUpLineVo, orders);
            });
        }
    }

    //Called by cron executes 2nd day of each month
    public void generateCommissionExcel(LocalDate today) {
        String redisKey = "generate_commission_excel";
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            if (today == null) {
                today = LocalDate.now();
            }

            String yearStr = today.format(DateTimeFormatter.ofPattern("yyyy"));
            String monthStr = today.format(DateTimeFormatter.ofPattern("MM"));

            //Agency Commission Excel
            List<AgencyCommissionCalculationHistory> agencyCommissionHistoryList = agencyCommissionCalculationHistoryDao.findAllByGeneratedCommissionFileIsFalse();
            if (agencyCommissionHistoryList != null && !agencyCommissionHistoryList.isEmpty()) {
                List<CommissionExcelVo> commissionExcelVoList = agencyCommissionHistoryList.stream().map(CommissionExcelVo::agencyCommissionCalculationHistoryToCommissionExcelVo).toList();
                String fileNameWithoutExt = "agency-commission-excel-" + monthStr + "-" + yearStr + "-" + System.currentTimeMillis();
                File agencyCommissionExcelFile = excelService.generateCommissionExcel(commissionExcelVoList, fileNameWithoutExt);

                String s3filePath = S3_COMMISSION_EXCEL_DOCUMENT_PATH + sdf2.format(new Date()) + "/" + agencyCommissionExcelFile.getName();
                AwsS3Util.uploadFile(agencyCommissionExcelFile, s3filePath, false);

                ProductCommissionHistory productCommissionHistory = new ProductCommissionHistory();
                productCommissionHistory.setAgencyType(AgencyType.OTHER);
                productCommissionHistory.setCommissionFileName(fileNameWithoutExt);
                productCommissionHistory.setCommissionCsvKey(s3filePath);
                productCommissionHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
                productCommissionHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
                productCommissionHistory.setGeneratedBankFile(Boolean.FALSE);
                productCommissionHistory.setCreatedAt(new Date());
                productCommissionHistory.setUpdatedAt(new Date());
                productCommissionHistory = productCommissionHistoryDao.save(productCommissionHistory);

                ProductCommissionHistory finalProductCommissionHistory = productCommissionHistory;
                agencyCommissionHistoryList.forEach(history -> {
                    history.setGeneratedCommissionFile(true);
                    history.setProductCommissionHistory(finalProductCommissionHistory);
                    history.setUpdatedAt(new Date());
                });
                agencyCommissionCalculationHistoryDao.saveAll(agencyCommissionHistoryList);
            }

            //Agent Commission Excel
            List<AgentCommissionCalculationHistory> agentCommissionHistoryList = agentCommissionCalculationHistoryDao.findAllByGeneratedCommissionFileIsFalse();
            if (agentCommissionHistoryList != null && !agentCommissionHistoryList.isEmpty()) {
                String agencyId = agencyDao.getCitadelAgencyId();
                List<CommissionExcelVo> commissionExcelVoList = agentCommissionHistoryList.stream()
                        .map(history -> CommissionExcelVo.agentCommissionCalculationHistoryToCommissionExcelVo(history, agencyId)).toList();
                String fileNameWithoutExt = "agent-commission-excel-" + monthStr + "-" + yearStr + "-" + System.currentTimeMillis();
                File agentCommissionExcelFile = excelService.generateCommissionExcel(commissionExcelVoList, fileNameWithoutExt);

                String s3filePath = S3_COMMISSION_EXCEL_DOCUMENT_PATH + sdf2.format(new Date()) + "/" + agentCommissionExcelFile.getName();
                AwsS3Util.uploadFile(agentCommissionExcelFile, s3filePath, false);

                ProductCommissionHistory productCommissionHistory = new ProductCommissionHistory();
                productCommissionHistory.setCommissionFileName(fileNameWithoutExt);
                productCommissionHistory.setAgencyType(AgencyType.CITADEL);
                productCommissionHistory.setCommissionCsvKey(s3filePath);
                productCommissionHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
                productCommissionHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
                productCommissionHistory.setGeneratedBankFile(Boolean.FALSE);
                productCommissionHistory.setCreatedAt(new Date());
                productCommissionHistory.setUpdatedAt(new Date());
                productCommissionHistory = productCommissionHistoryDao.save(productCommissionHistory);

                ProductCommissionHistory finalProductCommissionHistory = productCommissionHistory;
                agentCommissionHistoryList.forEach(history -> {
                    history.setGeneratedCommissionFile(true);
                    history.setProductCommissionHistory(finalProductCommissionHistory);
                    history.setUpdatedAt(new Date());
                });
                agentCommissionCalculationHistoryDao.saveAll(agentCommissionHistoryList);
            }
        } catch (Exception ex) {
            log.error("Error in : {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void generateCommissionBankFile(Long id) {
        if (id == null) {
            log.error("Error in {} : id is null", getFunctionName());
            return;
        }
        String redisKey = "commission_bank_file_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductCommissionHistory productCommissionHistory = productCommissionHistoryDao.findByIdAndStatusApproverAndStatusChecker(id, CmsAdmin.ApproverStatus.APPROVE_APPROVER, CmsAdmin.CheckerStatus.APPROVE_CHECKER);
            if (productCommissionHistory == null) {
                return;
            }

            String s3filePath = S3_COMMISSION_BANK_FILE_DOCUMENT_PATH + sdf2.format(new Date()) + "/";
            List<Attachment> attachments = new ArrayList<>();

            //Agency Commission
            List<AgencyCommissionCalculationHistory> agencyCommissionCalculationHistoryList = agencyCommissionCalculationHistoryDao.findAllByProductCommissionHistory(productCommissionHistory);
            if (agencyCommissionCalculationHistoryList != null && !agencyCommissionCalculationHistoryList.isEmpty()) {
                log.info("****************** Generate AFFIN Bank Agency Commission File id : {} Start ******************", id);
//                List<AffinBankVo> affinBankVoList = new ArrayList<>();
                List<CimbBankVo> cimbBankVoList = new ArrayList<>();
                for (AgencyCommissionCalculationHistory calculationHistory : agencyCommissionCalculationHistoryList) {
                    //AffinBankVo record = new AffinBankVo();
                    // Row 1 (Payment Record)
                    LocalDate calculatedDate = calculationHistory.getCalculatedDate();
                    LocalDate paymentDate = calculatedDate.withDayOfMonth(calculatedDate.lengthOfMonth());
                    //record.setColCRowOnePaymentDate(paymentDate.format(formatter));
                    String productCode = productDao.findProductCodeByProductId(calculationHistory.getProductId());
                    String agreementRunningNumber = calculationHistory.getOrderAgreementNumber().substring(calculationHistory.getOrderAgreementNumber().length() - 4);
                    String refNo = StringUtil.removeCharacters(calculationHistory.getOrderAgreementNumber(), List.of('-'));
                    //record.setColDRowOneCustomerRefNo(productCode + " " + agreementRunningNumber);
                    //record.setColERowOnePaymentAmount(calculationHistory.getCommissionAmount());
                    //BankDetails agencyBankDetails = bankDetailsDao.findBankDetailsByAgencyIdAndIsDeletedFalse(calculationHistory.getAgencyId());
                    //record.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(agencyBankDetails.getBankName()));
                    //record.setColBRowOnePaymentMode(StringUtil.isEmpty(record.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
                    //record.setColHRowOneBeneficiaryAccNo(agencyBankDetails.getAccountNumber());
                    //record.setColIRowOneBeneficiaryName(agencyBankDetails.getAccountHolderName());
                    //record.setColJRowOneIDCheckingRequired("N");
                    //record.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
                    // Row 2 (Payment Advice)
                    //record.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getCommissionAmount()));
                    //record.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
                    //String emailAddress = agencyDao.getAgencyEmailAddressById(calculationHistory.getAgencyId());
                    //record.setColDRowTwoEmailAddress1(emailAddress);
                    //affinBankVoList.add(record);

                    CimbBankVo record = new CimbBankVo();
                    BankDetails agencyBankDetails = bankDetailsDao.findBankDetailsByAgencyIdAndIsDeletedFalse(calculationHistory.getAgencyId());
                    record.setColABeneficiaryName(agencyBankDetails.getAccountHolderName());
                    record.setColBBeneficiaryId(agencyDao.getAgencyRegNumberByAgencyId(calculationHistory.getAgencyId()));
                    record.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(agencyBankDetails.getBankName()));
                    record.setColDAccountNumber(agencyBankDetails.getAccountNumber());
                    record.setColEPaymentAmount(calculationHistory.getCommissionAmount());
//                    LocalDate calculatedDate = calculationHistory.getCalculatedDate();
//                    LocalDate paymentDate = calculatedDate.withDayOfMonth(calculatedDate.lengthOfMonth());
//                    record.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                    record.setColFReferenceNumber(refNo);
                    record.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                    cimbBankVoList.add(record);
                }

//                File affinBankFileExcel = excelService.generateAFFINBankFileExcelV2(affinBankVoList);
                //Upload to S3
//                s3filePath += affinBankFileExcel.getName();
//                AwsS3Util.uploadFile(affinBankFileExcel, s3filePath, false);

                File cimbBankFileExcel = excelService.generateCIMBBankFileExcel(cimbBankVoList, CimbBankVo.TYPE.COMMISSION);
//              Upload to S3
                s3filePath += cimbBankFileExcel.getName();
                AwsS3Util.uploadFile(cimbBankFileExcel, s3filePath, false);

                //Attach Excel to email
                byte[] attachmentContentBytes = Files.readAllBytes(cimbBankFileExcel.toPath());
                String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", cimbBankFileExcel.getName()));

                productCommissionHistory.setGeneratedBankFile(Boolean.TRUE);
                productCommissionHistory.setUpdatedAt(new Date());
                productCommissionHistoryDao.save(productCommissionHistory);

                log.info("****************** Generate AFFIN Bank Agency Commission File id : {} End ******************", id);
            }

            //Agent Commission
            List<AgentCommissionCalculationHistory> agentCommissionCalculationHistoryList = agentCommissionCalculationHistoryDao.findAllByProductCommissionHistory(productCommissionHistory);
            if (agentCommissionCalculationHistoryList != null && !agentCommissionCalculationHistoryList.isEmpty()) {
                log.info("****************** Generate AFFIN Bank Agent Commission File id : {} Start ******************", id);
//                List<AffinBankVo> affinBankVoList = new ArrayList<>();
                List<CimbBankVo> cimbBankVoList = new ArrayList<>();
                for (AgentCommissionCalculationHistory calculationHistory : agentCommissionCalculationHistoryList) {
                    String productCode = productDao.findProductCodeByProductId(calculationHistory.getProductId());
                    String agreementRunningNumber = calculationHistory.getOrderAgreementNumber().substring(calculationHistory.getOrderAgreementNumber().length() - 4);
                    String refNo = StringUtil.removeCharacters(calculationHistory.getOrderAgreementNumber(), List.of('-'));

                    LocalDate calculatedDate = calculationHistory.getCalculatedDate();
                    LocalDate paymentDate = calculatedDate.withDayOfMonth(calculatedDate.lengthOfMonth());
//                    //Mgr Commission - Row 1
//                    AffinBankVo mgrRecord = new AffinBankVo();
//                    mgrRecord.setColCRowOnePaymentDate(paymentDate.format(formatter));
//                    mgrRecord.setColDRowOneCustomerRefNo(refNo);
//                    mgrRecord.setColERowOnePaymentAmount(calculationHistory.getMgrCommissionAmount());
//                    Agent mgr = agentDao.findByAgentId(calculationHistory.getMgrDigitalId());
//                    BankDetails mgrBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(mgr.getAppUser());
//                    mgrRecord.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(mgrBankDetails.getBankName()));
//                    mgrRecord.setColBRowOnePaymentMode(StringUtil.isEmpty(mgrRecord.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
//                    mgrRecord.setColHRowOneBeneficiaryAccNo(mgrBankDetails.getAccountNumber());
//                    mgrRecord.setColIRowOneBeneficiaryName(mgrBankDetails.getAccountHolderName());
//                    mgrRecord.setColJRowOneIDCheckingRequired("Y");
//                    mgrRecord.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(mgr.getUserDetail().getIdentityDocumentType()));
//                    mgrRecord.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(mgr.getUserDetail().getIdentityCardNumber()));
//                    mgrRecord.setColMRowOneResidentIndicator("Y");
//                    mgrRecord.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                    //Mgr Commission - Row 2
//                    mgrRecord.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getMgrCommissionAmount()));
//                    mgrRecord.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                    mgrRecord.setColDRowTwoEmailAddress1(mgr.getUserDetail().getEmail());
//                    affinBankVoList.add(mgrRecord);

                    //Mgr Commission
                    CimbBankVo record = new CimbBankVo();
                    Agent mgr = agentDao.findByAgentId(calculationHistory.getMgrDigitalId());
                    BankDetails agencyBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(mgr.getAppUser());
                    record.setColABeneficiaryName(agencyBankDetails.getAccountHolderName());
                    record.setColBBeneficiaryId(StringUtil.removeAllSpecialCharacters(mgr.getUserDetail().getIdentityCardNumber()));
                    record.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(agencyBankDetails.getBankName()));
                    record.setColDAccountNumber(agencyBankDetails.getAccountNumber());
                    record.setColEPaymentAmount(calculationHistory.getMgrCommissionAmount());
//                    record.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                    record.setColFReferenceNumber(refNo);
                    record.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                    cimbBankVoList.add(record);

                    //P2P Commission
                    if (calculationHistory.getP2pId() != null && calculationHistory.getP2pCommissionAmount() > 0) {
//                        //Row 1
//                        AffinBankVo p2pRecord = new AffinBankVo();
//                        p2pRecord.setColCRowOnePaymentDate(paymentDate.format(formatter));
//                        p2pRecord.setColDRowOneCustomerRefNo(refNo);
//                        p2pRecord.setColERowOnePaymentAmount(calculationHistory.getP2pCommissionAmount());
//                        Agent p2p = agentDao.findByAgentId(calculationHistory.getP2pDigitalId());
//                        BankDetails p2pBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(p2p.getAppUser());
//                        p2pRecord.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(p2pBankDetails.getBankName()));
//                        p2pRecord.setColBRowOnePaymentMode(StringUtil.isEmpty(p2pRecord.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
//                        p2pRecord.setColHRowOneBeneficiaryAccNo(p2pBankDetails.getAccountNumber());
//                        p2pRecord.setColIRowOneBeneficiaryName(p2pBankDetails.getAccountHolderName());
//                        p2pRecord.setColJRowOneIDCheckingRequired("Y");
//                        p2pRecord.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(p2p.getUserDetail().getIdentityDocumentType()));
//                        p2pRecord.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(p2p.getUserDetail().getIdentityCardNumber()));
//                        p2pRecord.setColMRowOneResidentIndicator("Y");
//                        p2pRecord.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        //Row 2
//                        p2pRecord.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getP2pCommissionAmount()));
//                        p2pRecord.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        p2pRecord.setColDRowTwoEmailAddress1(p2p.getUserDetail().getEmail());
//                        affinBankVoList.add(p2pRecord);

                        CimbBankVo p2pRecord = new CimbBankVo();
                        Agent p2p = agentDao.findByAgentId(calculationHistory.getP2pDigitalId());
                        BankDetails p2pBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(p2p.getAppUser());
                        p2pRecord.setColABeneficiaryName(p2pBankDetails.getAccountHolderName());
                        p2pRecord.setColBBeneficiaryId(StringUtil.removeAllSpecialCharacters(p2p.getUserDetail().getIdentityCardNumber()));
                        p2pRecord.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(p2pBankDetails.getBankName()));
                        p2pRecord.setColDAccountNumber(p2pBankDetails.getAccountNumber());
                        p2pRecord.setColEPaymentAmount(calculationHistory.getP2pCommissionAmount());
//                        p2pRecord.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                        p2pRecord.setColFReferenceNumber(refNo);
                        p2pRecord.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                        cimbBankVoList.add(p2pRecord);
                    }

                    //SM Commission
                    if (calculationHistory.getSmId() != null && calculationHistory.getSmCommissionAmount() > 0) {
//                        //Row 1
//                        AffinBankVo smRecord = new AffinBankVo();
//                        smRecord.setColCRowOnePaymentDate(paymentDate.format(formatter));
//                        smRecord.setColDRowOneCustomerRefNo(refNo);
//                        smRecord.setColERowOnePaymentAmount(calculationHistory.getSmCommissionAmount());
//                        Agent sm = agentDao.findByAgentId(calculationHistory.getSmDigitalId());
//                        BankDetails smBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(sm.getAppUser());
//                        smRecord.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(smBankDetails.getBankName()));
//                        smRecord.setColBRowOnePaymentMode(StringUtil.isEmpty(smRecord.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
//                        smRecord.setColHRowOneBeneficiaryAccNo(smBankDetails.getAccountNumber());
//                        smRecord.setColIRowOneBeneficiaryName(smBankDetails.getAccountHolderName());
//                        smRecord.setColJRowOneIDCheckingRequired("Y");
//                        smRecord.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(sm.getUserDetail().getIdentityDocumentType()));
//                        smRecord.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(sm.getUserDetail().getIdentityCardNumber()));
//                        smRecord.setColMRowOneResidentIndicator("Y");
//                        smRecord.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        //Row 2
//                        smRecord.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getSmCommissionAmount()));
//                        smRecord.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        smRecord.setColDRowTwoEmailAddress1(sm.getUserDetail().getEmail());
//                        affinBankVoList.add(smRecord);

                        CimbBankVo smRecord = new CimbBankVo();
                        Agent sm = agentDao.findByAgentId(calculationHistory.getSmDigitalId());
                        BankDetails smBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(sm.getAppUser());
                        smRecord.setColABeneficiaryName(smBankDetails.getAccountHolderName());
                        smRecord.setColBBeneficiaryId(StringUtil.removeAllSpecialCharacters(sm.getUserDetail().getIdentityCardNumber()));
                        smRecord.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(smBankDetails.getBankName()));
                        smRecord.setColDAccountNumber(smBankDetails.getAccountNumber());
                        smRecord.setColEPaymentAmount(calculationHistory.getSmCommissionAmount());
//                        smRecord.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                        smRecord.setColFReferenceNumber(refNo);
                        smRecord.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                        cimbBankVoList.add(smRecord);
                    }

                    //AVP Commission
                    if (calculationHistory.getAvpId() != null && calculationHistory.getAvpCommissionAmount() > 0) {
//                        //Row 1
//                        AffinBankVo avpRecord = new AffinBankVo();
//                        avpRecord.setColCRowOnePaymentDate(paymentDate.format(formatter));
//                        avpRecord.setColDRowOneCustomerRefNo(refNo);
//                        avpRecord.setColERowOnePaymentAmount(calculationHistory.getAvpCommissionAmount());
//                        Agent avp = agentDao.findByAgentId(calculationHistory.getAvpDigitalId());
//                        BankDetails avpBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(avp.getAppUser());
//                        avpRecord.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(avpBankDetails.getBankName()));
//                        avpRecord.setColBRowOnePaymentMode(StringUtil.isEmpty(avpRecord.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
//                        avpRecord.setColHRowOneBeneficiaryAccNo(avpBankDetails.getAccountNumber());
//                        avpRecord.setColIRowOneBeneficiaryName(avpBankDetails.getAccountHolderName());
//                        avpRecord.setColJRowOneIDCheckingRequired("Y");
//                        avpRecord.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(avp.getUserDetail().getIdentityDocumentType()));
//                        avpRecord.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(avp.getUserDetail().getIdentityCardNumber()));
//                        avpRecord.setColMRowOneResidentIndicator("Y");
//                        avpRecord.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        //Row 2
//                        avpRecord.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getAvpCommissionAmount()));
//                        avpRecord.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        avpRecord.setColDRowTwoEmailAddress1(avp.getUserDetail().getEmail());
//                        affinBankVoList.add(avpRecord);

                        CimbBankVo avpRecord = new CimbBankVo();
                        Agent avp = agentDao.findByAgentId(calculationHistory.getAvpDigitalId());
                        BankDetails avpBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(avp.getAppUser());
                        avpRecord.setColABeneficiaryName(avpBankDetails.getAccountHolderName());
                        avpRecord.setColBBeneficiaryId(StringUtil.removeAllSpecialCharacters(avp.getUserDetail().getIdentityCardNumber()));
                        avpRecord.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(avpBankDetails.getBankName()));
                        avpRecord.setColDAccountNumber(avpBankDetails.getAccountNumber());
                        avpRecord.setColEPaymentAmount(calculationHistory.getAvpCommissionAmount());
//                        avpRecord.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                        avpRecord.setColFReferenceNumber(refNo);
                        avpRecord.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                        cimbBankVoList.add(avpRecord);
                    }

                    //VP Commission
                    if (calculationHistory.getVpId() != null && calculationHistory.getVpCommissionAmount() > 0) {
//                        //Row 1
//                        AffinBankVo vpRecord = new AffinBankVo();
//                        vpRecord.setColCRowOnePaymentDate(paymentDate.format(formatter));
//                        vpRecord.setColDRowOneCustomerRefNo(refNo);
//                        vpRecord.setColERowOnePaymentAmount(calculationHistory.getVpCommissionAmount());
//                        Agent vp = agentDao.findByAgentId(calculationHistory.getVpDigitalId());
//                        BankDetails vpBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(vp.getAppUser());
//                        vpRecord.setColGRowOneBeneficiaryBankCode(AffinBankUtil.getAFFINBnmCode(vpBankDetails.getBankName()));
//                        vpRecord.setColBRowOnePaymentMode(StringUtil.isEmpty(vpRecord.getColGRowOneBeneficiaryBankCode()) ? AffinBankUtil.PaymentMode.AFF.name() : AffinBankUtil.PaymentMode.IBG.name());
//                        vpRecord.setColHRowOneBeneficiaryAccNo(vpBankDetails.getAccountNumber());
//                        vpRecord.setColIRowOneBeneficiaryName(vpBankDetails.getAccountHolderName());
//                        vpRecord.setColJRowOneIDCheckingRequired("Y");
//                        vpRecord.setColKRowOneBeneficiaryIdType(AffinBankUtil.getBeneficiaryIdType(vp.getUserDetail().getIdentityDocumentType()));
//                        vpRecord.setColLRowOneBeneficiaryIdNo(StringUtil.removeAllSpecialCharacters(vp.getUserDetail().getIdentityCardNumber()));
//                        vpRecord.setColMRowOneResidentIndicator("Y");
//                        vpRecord.setColSRowOneRecipientReference(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        //Row 2
//                        vpRecord.setColBRowTwoPaymentAdviceAmount(String.format("%.2f", calculationHistory.getVpCommissionAmount()));
//                        vpRecord.setColCRowTwoPaymentAdviceDetail(AffinBankUtil.getRecipientReference(AffinBankUtil.RecipientReferenceType.COMMISSION, null, null, null));
//                        vpRecord.setColDRowTwoEmailAddress1(vp.getUserDetail().getEmail());
//                        affinBankVoList.add(vpRecord);

                        CimbBankVo vpRecord = new CimbBankVo();
                        Agent vp = agentDao.findByAgentId(calculationHistory.getVpDigitalId());
                        BankDetails vpBankDetails = bankDetailsDao.findByAppUserAndIsDeletedIsFalse(vp.getAppUser());
                        vpRecord.setColABeneficiaryName(vpBankDetails.getAccountHolderName());
                        vpRecord.setColBBeneficiaryId(StringUtil.removeAllSpecialCharacters(vp.getUserDetail().getIdentityCardNumber()));
                        vpRecord.setColCBnmCode(CIMBBankUtil.getCIMBBnmCode(vpBankDetails.getBankName()));
                        vpRecord.setColDAccountNumber(vpBankDetails.getAccountNumber());
                        vpRecord.setColEPaymentAmount(calculationHistory.getVpCommissionAmount());
//                        vpRecord.setColFReferenceNumber("COMM " + paymentDate.format(formatter));
                        vpRecord.setColFReferenceNumber(refNo);
                        vpRecord.setColIPaymentDescription(calculationHistory.getReferenceNumber());
                        cimbBankVoList.add(vpRecord);
                    }
                }

//                File affinBankFileExcel = excelService.generateAFFINBankFileExcelV2(affinBankVoList);
//                //Upload to S3
//                s3filePath += affinBankFileExcel.getName();
//                AwsS3Util.uploadFile(affinBankFileExcel, s3filePath, false);
                File cimbBankFileExcel = excelService.generateCIMBBankFileExcel(cimbBankVoList, CimbBankVo.TYPE.COMMISSION);
                //Upload to S3
                s3filePath += cimbBankFileExcel.getName();
                AwsS3Util.uploadFile(cimbBankFileExcel, s3filePath, false);

                //Attach Excel to email
                byte[] attachmentContentBytes = Files.readAllBytes(cimbBankFileExcel.toPath());
                String attachmentContent = Base64.getEncoder().encodeToString(attachmentContentBytes);
                attachments.add(new Attachment(attachmentContent, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", cimbBankFileExcel.getName()));

                productCommissionHistory.setGeneratedBankFile(Boolean.TRUE);
                productCommissionHistory.setUpdatedAt(new Date());
                productCommissionHistoryDao.save(productCommissionHistory);

                log.info("****************** Generate AFFIN Bank Agent Commission File id : {} End ******************", id);
            }

            if (attachments.isEmpty()) {
                return;
            }

            emailService.sendCommissionPayoutBankFileGenerationEmail(attachments);
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateCommissionBankPaymentDetails(Long id) {
        if (id == null) {
            log.error("Error in {} : id is null", getFunctionName());
        }
        String redisKey = "update_commission_payment_details_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductCommissionHistory productCommissionHistory = productCommissionHistoryDao.findByIdAndStatusApproverAndStatusCheckerAndGeneratedBankFileIsTrue(id, CmsAdmin.ApproverStatus.APPROVE_APPROVER, CmsAdmin.CheckerStatus.APPROVE_CHECKER);
            if (productCommissionHistory == null || StringUtil.isEmpty(productCommissionHistory.getBankResultCsv())) {
                return;
            }

            String s3Key = StringUtil.extractDownloadLinkFromCmsContent(productCommissionHistory.getBankResultCsv());
            String fileNameWithoutExtension = id + "update_dividend_payout_" + System.currentTimeMillis();
            List<CommissionPaymentRecordVo> records = excelService.parseExcelFileFromS3ToVoClass(s3Key, fileNameWithoutExtension, CommissionPaymentRecordVo.class, ExcelService.ParseStrategy.COLUMN_NAME);

            if (AgencyType.OTHER.equals(productCommissionHistory.getAgencyType())) {
                for (CommissionPaymentRecordVo record : records) {
                    if (StringUtil.isNotEmpty(record.getReferenceNumber()) && StringUtil.isNotEmpty(record.getAgencyId())) {
                        String referenceNumber = record.getReferenceNumber().strip();
                        AgencyCommissionCalculationHistory agencyCommissionCalculationHistory = agencyCommissionCalculationHistoryDao.findByReferenceNumber(referenceNumber);
                        if (agencyCommissionCalculationHistory != null) {
                            agencyCommissionCalculationHistory.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                            agencyCommissionCalculationHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                            agencyCommissionCalculationHistory.setUpdatedAt(new Date());
                            agencyCommissionCalculationHistoryDao.save(agencyCommissionCalculationHistory);
                        }
                    }
                }
                productCommissionHistory.setUpdatedBankResult(Boolean.TRUE);
                productCommissionHistory.setUpdatedAt(new Date());
                productCommissionHistoryDao.save(productCommissionHistory);
            }
            if (AgencyType.CITADEL.equals(productCommissionHistory.getAgencyType())) {
                for (CommissionPaymentRecordVo record : records) {
                    if (StringUtil.isNotEmpty(record.getReferenceNumber()) && StringUtil.isNotEmpty(record.getAgentId())) {
                        String referenceNumber = record.getReferenceNumber().strip();
                        String agentId = record.getAgentId().strip();
                        agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentId, referenceNumber)
                                .ifPresent(agentCommissionHistory -> {
                                    agentCommissionHistory.setPaymentStatus(StringUtil.getEnumFromString(Status.class, record.getPaymentStatus()));
                                    agentCommissionHistory.setPaymentDate(DateUtil.convertStringToDate(record.getPaymentDate()));
                                    agentCommissionHistory.setUpdatedAt(new Date());
                                    agentCommissionHistoryDao.save(agentCommissionHistory);
                                });
                    }
                }
            }
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }

    public void updateCommissionExcelDetails(Long id) {
        if (id == null) {
            log.error("Error in {} : id is null", getFunctionName());
            return;
        }
        String redisKey = "update_commission_excel_" + id;
        if (RedisUtil.exists(redisKey)) {
            return;
        }
        RedisUtil.set(redisKey, "1", ONE_DAY);
        try {
            ProductCommissionHistory productCommissionHistory = productCommissionHistoryDao.getReferenceById(id);
            if (StringUtil.isEmpty(productCommissionHistory.getCommissionCsvKey()) || StringUtil.isEmpty(productCommissionHistory.getUpdatedCommissionCsvKey())) {
                return;
            }
            String fileNameWithoutExtension = id + "update_commission_excel_" + System.currentTimeMillis();
            List<CommissionExcelVo> records = excelService.parseExcelFileFromS3ToVoClass(productCommissionHistory.getUpdatedCommissionCsvKey(), fileNameWithoutExtension, CommissionExcelVo.class, ExcelService.ParseStrategy.COLUMN_ORDER);

            List<CommissionExcelVo> commissionVoList;
            List<AgencyCommissionCalculationHistory> agencyCommissionCalculationHistoryList = new ArrayList<>();
            List<AgentCommissionCalculationHistory> agentCommissionCalculationHistoryList = new ArrayList<>();
            if (AgencyType.CITADEL.equals(productCommissionHistory.getAgencyType())) {
                String agencyId = agencyDao.getCitadelAgencyId();
                for (CommissionExcelVo record : records) {
                    if (StringUtil.isEmpty(record.getReferenceNumber())) {
                        continue;
                    }
                    String referenceNumber = record.getReferenceNumber().strip();
                    AgentCommissionCalculationHistory agentCommissionCalculationHistory = agentCommissionCalculationHistoryDao.findByReferenceNumber(referenceNumber);
                    if (agentCommissionCalculationHistory != null) {
                        log.info("Updating commission excel details for Reference Number : {}", referenceNumber + "Start");

                        agentCommissionCalculationHistory.setMgrCommissionAmount(record.getAgentCommissionAmount());
                        agentCommissionCalculationHistory.setMgrCommissionPercentage(record.getAgentCommissionRate());
                        //Update Mgr Agent Commission History
                        agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentCommissionCalculationHistory.getMgrDigitalId(), referenceNumber)
                                .ifPresent(mgrCommissionHistory -> {
                                    mgrCommissionHistory.setCommissionPercentage(agentCommissionCalculationHistory.getMgrCommissionPercentage());
                                    mgrCommissionHistory.setCommissionAmount(agentCommissionCalculationHistory.getMgrCommissionAmount());
                                    mgrCommissionHistory.setUpdatedAt(new Date());
                                    agentCommissionHistoryDao.save(mgrCommissionHistory);
                                });
                        //Update P2P Agent Commission History
                        agentCommissionCalculationHistory.setP2pCommissionAmount(record.getP2pCommissionAmount());
                        agentCommissionCalculationHistory.setP2pCommissionPercentage(record.getP2pCommissionRate());
                        if (StringUtil.isNotEmpty(agentCommissionCalculationHistory.getP2pDigitalId())) {
                            agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentCommissionCalculationHistory.getP2pDigitalId(), referenceNumber)
                                    .ifPresent(p2pCommissionHistory -> {
                                        p2pCommissionHistory.setCommissionPercentage(agentCommissionCalculationHistory.getP2pCommissionPercentage());
                                        p2pCommissionHistory.setCommissionAmount(agentCommissionCalculationHistory.getP2pCommissionAmount());
                                        p2pCommissionHistory.setUpdatedAt(new Date());
                                        agentCommissionHistoryDao.save(p2pCommissionHistory);
                                    });
                        }
                        agentCommissionCalculationHistory.setSmCommissionAmount(record.getSmCommissionAmount());
                        agentCommissionCalculationHistory.setSmCommissionPercentage(record.getSmCommissionRate());
                        if (StringUtil.isNotEmpty(agentCommissionCalculationHistory.getSmDigitalId())) {
                            agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentCommissionCalculationHistory.getSmDigitalId(), referenceNumber)
                                    .ifPresent(smCommissionHistory -> {
                                        smCommissionHistory.setCommissionPercentage(agentCommissionCalculationHistory.getSmCommissionPercentage());
                                        smCommissionHistory.setCommissionAmount(agentCommissionCalculationHistory.getSmCommissionAmount());
                                        smCommissionHistory.setUpdatedAt(new Date());
                                        agentCommissionHistoryDao.save(smCommissionHistory);
                                    });
                        }
                        agentCommissionCalculationHistory.setAvpCommissionAmount(record.getAvpCommissionAmount());
                        agentCommissionCalculationHistory.setAvpCommissionPercentage(record.getAvpCommissionRate());
                        if (StringUtil.isNotEmpty(agentCommissionCalculationHistory.getAvpDigitalId())) {
                            agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentCommissionCalculationHistory.getAvpDigitalId(), referenceNumber)
                                    .ifPresent(avpCommissionHistory -> {
                                        avpCommissionHistory.setCommissionPercentage(agentCommissionCalculationHistory.getAvpCommissionPercentage());
                                        avpCommissionHistory.setCommissionAmount(agentCommissionCalculationHistory.getAvpCommissionAmount());
                                        avpCommissionHistory.setUpdatedAt(new Date());
                                        agentCommissionHistoryDao.save(avpCommissionHistory);
                                    });
                        }
                        agentCommissionCalculationHistory.setVpCommissionAmount(record.getVpCommissionAmount());
                        agentCommissionCalculationHistory.setVpCommissionPercentage(record.getVpCommissionRate());
                        if (StringUtil.isNotEmpty(agentCommissionCalculationHistory.getVpDigitalId())) {
                            agentCommissionHistoryDao.findByAgentIdAndCommissionCalculationHistoryReferenceNumber(agentCommissionCalculationHistory.getVpDigitalId(), referenceNumber)
                                    .ifPresent(vpCommissionHistory -> {
                                        vpCommissionHistory.setCommissionPercentage(agentCommissionCalculationHistory.getVpCommissionPercentage());
                                        vpCommissionHistory.setCommissionAmount(agentCommissionCalculationHistory.getVpCommissionAmount());
                                        vpCommissionHistory.setUpdatedAt(new Date());
                                        agentCommissionHistoryDao.save(vpCommissionHistory);
                                    });
                        }
                        if (StringUtils.isNotEmpty(record.getSvp1Name())) {
                            agentCommissionCalculationHistory.setSvpName(record.getSvp1Name());
                        }
                        if (record.getSvp1CommissionRate() != null && record.getSvp1CommissionRate() > 0) {
                            agentCommissionCalculationHistory.setSvpCommissionPercentage(record.getSvp1CommissionRate());
                        }
                        agentCommissionCalculationHistory.setRemark(record.getRemark());
                        agentCommissionCalculationHistory.setUpdatedAt(new Date());
                        agentCommissionCalculationHistoryDao.save(agentCommissionCalculationHistory);
                        agentCommissionCalculationHistoryList.add(agentCommissionCalculationHistory);

                        log.info("Updating commission excel details for Reference Number : {}", referenceNumber + "End");
                    }
                }
                commissionVoList = agentCommissionCalculationHistoryList.stream()
                        .map(history -> CommissionExcelVo.agentCommissionCalculationHistoryToCommissionExcelVo(history, agencyId)).toList();
            } else if (AgencyType.OTHER.equals(productCommissionHistory.getAgencyType())) {
                for (CommissionExcelVo record : records) {
                    String referenceNumber = record.getReferenceNumber().strip();
                    AgencyCommissionCalculationHistory agencyCommissionCalculationHistory = agencyCommissionCalculationHistoryDao.findByReferenceNumber(referenceNumber);
                    if (agencyCommissionCalculationHistory != null) {
                        agencyCommissionCalculationHistory.setCommissionAmount(record.getAgentCommissionAmount());
                        agencyCommissionCalculationHistory.setCommissionRate(record.getAgentCommissionRate());
                        agencyCommissionCalculationHistory.setRemark(record.getRemark());
                        agencyCommissionCalculationHistory.setUpdatedAt(new Date());
                        agencyCommissionCalculationHistoryDao.save(agencyCommissionCalculationHistory);
                        agencyCommissionCalculationHistoryList.add(agencyCommissionCalculationHistory);
                    }
                }
                commissionVoList = agencyCommissionCalculationHistoryList.stream().map(CommissionExcelVo::agencyCommissionCalculationHistoryToCommissionExcelVo).toList();
            } else {
                log.error("Error in {} : Agency Type is not supported", getFunctionName());
                return;
            }

            File commissionExcelFile = excelService.generateCommissionExcel(commissionVoList, productCommissionHistory.getCommissionFileName());
            String s3filePath = S3_COMMISSION_EXCEL_DOCUMENT_PATH + sdf2.format(new Date()) + "/" + commissionExcelFile.getName();

            AwsS3Util.uploadFile(commissionExcelFile, s3filePath, false);
            productCommissionHistory.setCommissionCsvKey(s3filePath);
            productCommissionHistory.setStatusChecker(CmsAdmin.CheckerStatus.PENDING_CHECKER);
            productCommissionHistory.setStatusApprover(CmsAdmin.ApproverStatus.PENDING_APPROVER);
            productCommissionHistory.setGeneratedBankFile(Boolean.FALSE);

            productCommissionHistory.setUpdatedAt(new Date());
            productCommissionHistoryDao.save(productCommissionHistory);
        } catch (Exception ex) {
            log.error("Error in {}", getFunctionName(), ex);
        } finally {
            RedisUtil.del(redisKey);
        }
    }


    public static void main(String[] args) {
        LocalDate currentDate = LocalDate.of(2025, 11, 1);
        LocalDate cutoffDate = currentDate.minusMonths(1);

        int yearToDeduct = 1 - 1;
        LocalDate comparingDate = cutoffDate.minusYears(yearToDeduct);

        System.out.println(cutoffDate);
        System.out.println(comparingDate);
    }
}