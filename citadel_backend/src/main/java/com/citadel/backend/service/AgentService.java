package com.citadel.backend.service;

import com.citadel.backend.dao.*;
import com.citadel.backend.dao.Agent.AgentDao;
import com.citadel.backend.dao.Client.ClientDao;
import com.citadel.backend.dao.Commission.AgentCommissionCalculationHistoryDao;
import com.citadel.backend.dao.Commission.AgentCommissionHistoryDao;
import com.citadel.backend.dao.Corporate.CorporateClientDao;
import com.citadel.backend.dao.Products.ProductDao;
import com.citadel.backend.dao.Products.ProductEarlyRedemptionHistoryDao;
import com.citadel.backend.dao.Products.ProductOrderDao;
import com.citadel.backend.entity.*;
import com.citadel.backend.entity.Commission.AgentCommissionHistory;
import com.citadel.backend.entity.Corporate.CorporateClient;
import com.citadel.backend.entity.Products.Product;
import com.citadel.backend.entity.Products.ProductEarlyRedemptionHistory;
import com.citadel.backend.entity.Products.ProductOrder;
import com.citadel.backend.utils.*;
import com.citadel.backend.utils.Builder.UploadBase64FileBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.Agency.AgencyAgentsRespVo;
import com.citadel.backend.vo.Agency.AgencyAgentVo;
import com.citadel.backend.vo.Agent.*;
import com.citadel.backend.vo.BaseResp;
import com.citadel.backend.vo.Client.ClientPortfolioVo;
import com.citadel.backend.vo.Commission.AgentEarningCommissionVo;
import com.citadel.backend.vo.Commission.AgentEarningVo;
import com.citadel.backend.vo.Commission.CitadelAgentVo;
import com.citadel.backend.vo.Enum.*;
import com.citadel.backend.vo.Product.PortfolioProductOrderOptionsVo;
import com.citadel.backend.vo.QuarterVo;
import jakarta.annotation.Resource;
import org.json.JSONArray;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import static com.citadel.backend.utils.ApiErrorKey.*;

@Service
public class AgentService extends BaseService {

    @Resource
    private AgentDao agentDao;
    @Resource
    private AgencyDao agencyDao;
    @Resource
    private UserDetailDao userDetailDao;
    @Resource
    private ClientDao clientDao;
    @Resource
    private SecureTagDao secureTagDao;
    @Resource
    private PushNotificationService pushNotificationService;
    @Resource
    private ClientService clientService;
    @Resource
    private ProductOrderDao productOrderDao;
    @Resource
    private AgentCommissionCalculationHistoryDao agentCommissionCalculationHistoryDao;
    @Resource
    private BankDetailsDao bankDetailsDao;
    @Resource
    private ProductDao productDao;
    @Resource
    private CorporateClientDao corporateClientDao;
    @Resource
    private AgentCommissionHistoryDao agentCommissionHistoryDao;
    @Resource
    private ProductService productService;
    @Resource
    private PdfService pdfService;
    @Resource
    private ProductEarlyRedemptionHistoryDao productEarlyRedemptionHistoryDao;

    public Object getAgentsByAgencyId(String agencyId) {
        try {
            // Fetch the agency by its ID
            Agency agency = agencyDao.findByAgencyId(agencyId)
                    .orElseThrow(() -> new GeneralException(INVALID_AGENCY_ID));

            // Fetch only agents who are ACTIVE
            List<Agent> agentsList = agentDao.findAllByAgencyAndStatus(agency, Agent.AgentStatus.ACTIVE);

            // Convert the Agent entities to AgencyAgentVo DTOs
            List<AgencyAgentVo> agentsVoList = agentsList.stream()
                    .map(agent -> agent.agentToAgentVo(agent))
                    .collect(Collectors.toList());

            // Prepare the response object
            AgencyAgentsRespVo resp = new AgencyAgentsRespVo();
            resp.setAgentsList(agentsVoList);

            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Agent Profile-----------------------------
    public Object getAgentProfile(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));

            AgentProfileRespVo resp = new AgentProfileRespVo();
            resp.setPersonalDetails(agent.getUserDetail().getAgentPersonalDetails());
            resp.setAgentDetails(agent.getAgentDetails());
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object agentProfileEdit(String apiKey, AgentProfileEditReqVo agentPersonalDetailsReq) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            JSONArray validationErrors = new JSONArray();
            if (StringUtil.isNotEmpty(agentPersonalDetailsReq.getMobileCountryCode()) && StringUtil.isNotEmpty(agentPersonalDetailsReq.getMobileNumber())) {
                agentPersonalDetailsReq.setMobileNumber(agentPersonalDetailsReq.getMobileNumber().strip());
                String mobileNumber = agentPersonalDetailsReq.getMobileCountryCode() + agentPersonalDetailsReq.getMobileNumber();
                if (!ValidatorUtil.validMobileNumber(mobileNumber)) {
                    validationErrors.put(agentPersonalDetailsReq.getClass().getSimpleName() + "." + "mobileNumber");
                }
            }

            if (StringUtil.isNotEmpty(agentPersonalDetailsReq.getEmail())) {
                agentPersonalDetailsReq.setEmail(agentPersonalDetailsReq.getEmail().strip());
                if (!ValidatorUtil.validEmail(agentPersonalDetailsReq.getEmail())) {
                    validationErrors.put(agentPersonalDetailsReq.getClass().getSimpleName() + "." + "email");
                }
            }

            if (!validationErrors.isEmpty()) {
                return getInvalidArgumentError(validationErrors);
            }

            UserDetail userDetail = agent.getUserDetail();
            Optional.ofNullable(StringUtil.capitalizeEachWord(agentPersonalDetailsReq.getAddress())).ifPresent(userDetail::setAddress);
            Optional.ofNullable(agentPersonalDetailsReq.getPostcode()).ifPresent(userDetail::setPostcode);
            Optional.ofNullable(StringUtil.capitalizeEachWord(agentPersonalDetailsReq.getCity())).ifPresent(userDetail::setCity);
            Optional.ofNullable(StringUtil.capitalizeEachWord(agentPersonalDetailsReq.getState())).ifPresent(userDetail::setState);
            Optional.ofNullable(StringUtil.capitalizeEachWord(agentPersonalDetailsReq.getCountry())).ifPresent(userDetail::setCountry);
            Optional.ofNullable(agentPersonalDetailsReq.getMobileCountryCode()).ifPresent(userDetail::setMobileCountryCode);
            Optional.ofNullable(agentPersonalDetailsReq.getMobileNumber()).ifPresent(userDetail::setMobileNumber);
            Optional.ofNullable(agentPersonalDetailsReq.getEmail()).ifPresent(userDetail::setEmail);

            userDetailDao.save(userDetail);

            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object agentProfileImageUpdate(String apiKey, AgentProfileImageAddEditReqVo agentProfileImageAddEditReqVo) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            UserDetail userDetail = agent.getUserDetail();
            // Update Profile Image if not null
            String profilePictureImageBase64 = agentProfileImageAddEditReqVo.getProfilePicture();
            if ((StringUtil.isNotEmpty(profilePictureImageBase64))) {
                if (!profilePictureImageBase64.startsWith("http")) {
                    String profilePictureImageKey = AwsS3Util.convertAndUploadBase64File(new UploadBase64FileBuilder()
                            .base64String(profilePictureImageBase64)
                            .fileName("profilePictureImage")
                            .filePath(S3_AGENT_PATH + agent.getUserDetail().getIdentityCardNumber()));
                    userDetail.setProfilePictureImageKey(profilePictureImageKey);
                }
            } else {
                AwsS3Util.deleteFile(userDetail.getProfilePictureImageKey());
                userDetail.setProfilePictureImageKey(null);
            }

            userDetail.setUpdatedAt(new Date());
            userDetailDao.save(userDetail);
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Agent Personal Dashboard-----------------------------
    public Object getAgentTotalSales(String apiKey, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent agent = getAgent(appUser, agentId);

            QuarterVo currentQuarter = DateUtil.getQuarter(LocalDate.now());
            //Find current currentQuarter total revenue
            double currentQuarterTotalSalesAmount = productOrderDao.findTotalSalesByAgentAndByPeriod(agent.getId(), currentQuarter.getStartDate(), currentQuarter.getEndDate(), ProductOrder.ProductOrderStatus.ACTIVE).orElse(0.0);

            //Find previous currentQuarter total revenue
            QuarterVo previousQuarter = DateUtil.getQuarter(currentQuarter.getStartDate().minusDays(1));
            double previousQuarterTotalSalesAmount = productOrderDao.findTotalSalesByAgentAndByPeriod(agent.getId(), previousQuarter.getStartDate(), previousQuarter.getEndDate(), ProductOrder.ProductOrderStatus.ACTIVE).orElse(0.0);

            //Find percentage of sales volume between previous and current quarter
            double percentageDifference = (previousQuarterTotalSalesAmount == 0) ? (Math.signum(currentQuarterTotalSalesAmount) * 100) : ((currentQuarterTotalSalesAmount - previousQuarterTotalSalesAmount) / previousQuarterTotalSalesAmount) * 100;
            percentageDifference = BigDecimal.valueOf(percentageDifference).setScale(2, RoundingMode.HALF_UP).doubleValue();

            int totalProductSold = Math.toIntExact(productOrderDao.findTotalProductsSoldByAgentByDateRange(agent.getId(), currentQuarter.getStartDate(), currentQuarter.getEndDate(), ProductOrder.ProductOrderStatus.ACTIVE).orElse(0L));

            AgentTotalSalesRespVo agentRevenueVo = new AgentTotalSalesRespVo();
            agentRevenueVo.setTotalSalesAmount(String.format("%.2f", currentQuarterTotalSalesAmount));
            agentRevenueVo.setPercentageDifference(String.format("%.2f", percentageDifference));
            agentRevenueVo.setCurrentQuarterStartDate(currentQuarter.getStartDate());
            agentRevenueVo.setCurrentQuarterEndDate(currentQuarter.getEndDate());
            agentRevenueVo.setPaymentMethod(bankDetailsDao.findBankNameByAppUserAndIsDeletedFalse(agent.getAppUser()));
            agentRevenueVo.setTotalProductsSold(totalProductSold);
            return agentRevenueVo;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getAgentPersonalSales(String apiKey, String agentId, Integer month, Integer year) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent loggedInAgent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE)
                    .orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));

            Agent agent = getAgent(appUser, agentId);

            if (month == null || year == null) {
                LocalDate currentDate = LocalDate.now();
                month = currentDate.getMonthValue();
                year = currentDate.getYear();
            }

            LocalDate startDate = LocalDate.of(year, month, 1);
            LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());

            List<AgentPersonalSalesDetailsVo> agentProductSalesVoList = getAgentPersonalSalesDetails(agent, startDate, endDate, loggedInAgent);
            AgentPersonalSalesDetailsRespVo resp = new AgentPersonalSalesDetailsRespVo();
            resp.setSalesDetails(agentProductSalesVoList);
            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public List<AgentPersonalSalesDetailsVo> getAgentPersonalSalesDetails(Agent agent, LocalDate startDate, LocalDate endDate, Agent loggedInAgent) {
        List<String> statusList = List.of(ProductOrder.ProductOrderStatus.ACTIVE.name(), ProductOrder.ProductOrderStatus.MATURED.name(), ProductOrder.ProductOrderStatus.FLOAT.name(), ProductOrder.ProductOrderStatus.WITHDRAWN.name(), ProductOrder.ProductOrderStatus.COMPLETED.name());

        boolean isP2P = AgentRole.MGR.equals(agent.getAgentRole().getRoleCode()) && AgentRole.MGR.equals(loggedInAgent.getAgentRole().getRoleCode());
        boolean getOverridingCommission = true;
        if (loggedInAgent.getAgentId().equals(agent.getAgentId())) {
            isP2P = false;
            getOverridingCommission = false;
        }

        // If the agent whom the apiKey belongs is querying his own sales, set the personal commission details
        // If the agent whom the apiKey belongs is querying his down-line agent's sales, set the overriding commission details
        List<AgentPersonalSalesDetailsVo> salesList = productOrderDao.findProductOrdersSoldByAgentAndByDateRange(agent.getId(), startDate, endDate, statusList);
        for (AgentPersonalSalesDetailsVo salesVo : salesList) {
            if (isP2P) {
                salesVo.setClientId(null);
                salesVo.setClientName(null);
            }
            salesVo.setCommissionPercentage(0.0);
            salesVo.setCommissionAmount(0.0);
            salesVo.setCalculatedDate(salesVo.getAgreementDate());

            //Only show commission details if its in-house citadel agents except SVP
            if (AgencyType.CITADEL.equals(agent.getAgency().getAgencyType())) {
                List<AgentEarningCommissionVo> agentEarningCommissionVoList;
                // Get down-line sales -> get overriding commission
                if (getOverridingCommission) {
                    agentEarningCommissionVoList = agentCommissionHistoryDao.findByAgentIdAndCommissionTypeAndProductOrderId(loggedInAgent.getAgentId(), AgentCommissionHistory.CommissionType.OVERRIDING, Status.SUCCESS, salesVo.getProductOrderId());
                } else {
                    agentEarningCommissionVoList = agentCommissionHistoryDao.findByAgentIdAndCommissionTypeAndProductOrderId(agent.getAgentId(), AgentCommissionHistory.CommissionType.PERSONAL, Status.SUCCESS, salesVo.getProductOrderId());
                }
                AgentEarningCommissionVo agentEarningCommissionVo = agentEarningCommissionVoList.stream().findFirst().orElse(null);
                if (agentEarningCommissionVo != null) {
                    salesVo.setCommissionPercentage(agentEarningCommissionVo.getCommissionPercentage());
                    salesVo.setCommissionAmount(agentEarningCommissionVo.getCommissionAmount());
                    salesVo.setCalculatedDate(DateUtil.convertDateToLocalDate(agentEarningCommissionVo.getPaymentDate()));
                }
            }
            // Set arbitrage product status
            salesVo.setProductStatus(salesVo.getProductOrderType().getValue());
        }
        return salesList;
    }

    public Object getAgentEarnings(String apiKey, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgentEarningRespVo resp = new AgentEarningRespVo();
            Agent agent = getAgent(appUser, agentId);

            if (!AgencyType.CITADEL.equals(agent.getAgency().getAgencyType())) {
                return resp;
            }

            String redisKey = "agentEarningDetails_" + agent.getAgentId();
            //TODO implement redis cache before production
//            if (RedisUtil.exists(redisKey)) {
//                String cache =  RedisUtil.get(redisKey);
//                return gson.fromJson(cache, AgentEarningRespVo.class);
//            }
            List<AgentCommissionHistory> agentCommissionList = agentCommissionHistoryDao.findByAgentIdAndPaymentStatus(agent.getAgentId(), Status.SUCCESS);
            String bankName = bankDetailsDao.findBankNameByAppUserAndIsDeletedFalse(agent.getAppUser());

            List<AgentEarningVo> agentEarningsList = new ArrayList<>();
            for (AgentCommissionHistory agentCommission : agentCommissionList) {
                AgentEarningVo agentEarningVo = new AgentEarningVo();
                agentEarningVo.setCommissionAmount(agentCommission.getCommissionAmount());
                agentEarningVo.setProductCode(productDao.findProductCodeByProductId(agentCommission.getAgentCommissionCalculationHistory().getProductId()));
                agentEarningVo.setAgreementNumber(agentCommission.getAgentCommissionCalculationHistory().getOrderAgreementNumber());
                agentEarningVo.setTransactionDate(agentCommission.getPaymentDate());
                agentEarningVo.setBankName(bankName);
                agentEarningVo.setTransactionId(agentCommission.getAgentCommissionCalculationHistory().getReferenceNumber());
                agentEarningVo.setStatus(Status.SUCCESS);
                agentEarningsList.add(agentEarningVo);
            }

            resp.setEarningDetails(agentEarningsList);
            //Cache response
            String cache = gson.toJson(resp);
            RedisUtil.set(redisKey, cache, ONE_DAY);

            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Agent DownLine Details-----------------------------
    public AgentDownLineVo buildAgentDownLine(Long id, Set<Long> allSubordinateIds, Set<Long> newRecruitIds) {
        try {
            CitadelAgentVo citadelAgentVo = agentDao.findCitadelAgentVoByAgentId(id);
            if (citadelAgentVo == null) {
                return null;
            }
            // Create the root node the (agent details)
            AgentDownLineVo agentDownLineVo = new AgentDownLineVo();
            agentDownLineVo.setMgrId(citadelAgentVo.getAgentId());
            agentDownLineVo.setMgrDigitalId(citadelAgentVo.getAgentDigitalId());
            agentDownLineVo.setMgrName(citadelAgentVo.getAgentName());
            agentDownLineVo.setMgrRole(citadelAgentVo.getAgentRole());

            // Recursively find all subordinates
            List<CitadelAgentVo> subordinates = agentDao.findSubordinatesByRecruitManagerId(id);
            for (CitadelAgentVo subordinate : subordinates) {
                allSubordinateIds.add(subordinate.getAgentId());
                if (DateUtil.isCurrentMonthAndYear(subordinate.getAgentJoinDate())) {
                    newRecruitIds.add(subordinate.getAgentId());
                }
                AgentDownLineVo subordinateDownLine = buildAgentDownLine(subordinate.getAgentId(), allSubordinateIds, newRecruitIds);
                if (subordinateDownLine != null) {
                    agentDownLineVo.addSubordinate(subordinateDownLine);
                }
            }
            return agentDownLineVo;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return null;
        }
    }

    public Object getDownLineDetails(String apiKey, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent agent = getAgent(appUser, agentId);
            Set<Long> allSubordinateIds = new HashSet<>();
            Set<Long> newRecruitIds = new HashSet<>();

            buildAgentDownLine(agent.getId(), allSubordinateIds, newRecruitIds);

            AgentDownLineRespVo resp = new AgentDownLineRespVo();
            resp.setTotalDownLine(allSubordinateIds.size());
            resp.setNewRecruitThisMonth(newRecruitIds.size());
            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public List<AgentDownLineProductOrderCommissionDetailsVo> getDownLineCommissionDetailsVo(Long agentId, QuarterVo currentQuarter) {
        CitadelAgentVo agentVo = agentDao.findCitadelAgentVoByAgentId(agentId);

        List<AgentProductOrderCommissionDetailsVo> mgrCommissionDetailsList = agentCommissionCalculationHistoryDao.getMgrCommissionDetailsByAgentIdAndByDateRange(agentId, currentQuarter.getStartDate(), currentQuarter.getEndDate());
        List<AgentProductOrderCommissionDetailsVo> p2pCommissionDetailsList = agentCommissionCalculationHistoryDao.getP2pCommissionDetailsByAgentIdAndByDateRange(agentId, currentQuarter.getStartDate(), currentQuarter.getEndDate());
        if (p2pCommissionDetailsList != null && !p2pCommissionDetailsList.isEmpty()) {
            mgrCommissionDetailsList.addAll(p2pCommissionDetailsList);
        }
        //Commission from down line
        if (!AgentRole.MGR.equals(agentVo.getAgentRole())) {
            List<AgentProductOrderCommissionDetailsVo> smCommissionDetailsList = agentCommissionCalculationHistoryDao.getSmCommissionDetailsByAgentIdAndByDateRange(agentId, currentQuarter.getStartDate(), currentQuarter.getEndDate());
            if (smCommissionDetailsList != null && !smCommissionDetailsList.isEmpty()) {
                mgrCommissionDetailsList.addAll(smCommissionDetailsList);
            }
            List<AgentProductOrderCommissionDetailsVo> avpCommissionDetailsList = agentCommissionCalculationHistoryDao.getAvpCommissionDetailsByAgentIdAndByDateRange(agentId, currentQuarter.getStartDate(), currentQuarter.getEndDate());
            if (avpCommissionDetailsList != null && !avpCommissionDetailsList.isEmpty()) {
                mgrCommissionDetailsList.addAll(avpCommissionDetailsList);
            }
            List<AgentProductOrderCommissionDetailsVo> vpCommissionDetailsList = agentCommissionCalculationHistoryDao.getVpCommissionDetailsByAgentIdAndByDateRange(agentId, currentQuarter.getStartDate(), currentQuarter.getEndDate());
            if (vpCommissionDetailsList != null && !vpCommissionDetailsList.isEmpty()) {
                mgrCommissionDetailsList.addAll(vpCommissionDetailsList);
            }
        }
        mgrCommissionDetailsList.sort(Comparator.comparing(AgentProductOrderCommissionDetailsVo::getCalculatedDate).reversed());

        return mgrCommissionDetailsList.stream().map(commissionDetailsVo -> {
            AgentDownLineProductOrderCommissionDetailsVo downLineCommissionDetailsVo = new AgentDownLineProductOrderCommissionDetailsVo();
            downLineCommissionDetailsVo.setAgentName(agentVo.getAgentName());
            downLineCommissionDetailsVo.setAgentRole(agentVo.getAgentRole().getValue());
            downLineCommissionDetailsVo.setCommissionPercentage(commissionDetailsVo.getCommissionPercentage());
            downLineCommissionDetailsVo.setCommissionAmount(commissionDetailsVo.getCommissionAmount());
            downLineCommissionDetailsVo.setCalculatedDate(commissionDetailsVo.getCalculatedDate());
            downLineCommissionDetailsVo.setProductId(commissionDetailsVo.getProductId());
            downLineCommissionDetailsVo.setProductOrderId(commissionDetailsVo.getProductOrderId());
            return downLineCommissionDetailsVo;
        }).toList();
    }

    //-----------------------------Agent DownLine Commission-----------------------------
    // Helper method to recursively collect subordinate IDs
    private void collectSubordinateIds(Long agentId, Set<Long> accumulator) {
        List<CitadelAgentVo> subordinates = agentDao.findSubordinatesByRecruitManagerId(agentId);
        if (subordinates != null) {
            for (CitadelAgentVo subordinate : subordinates) {
                // Add the subordinate's ID regardless of further subordinates
                accumulator.add(subordinate.getAgentId());
                // Recurse into the subordinate’s hierarchy
                collectSubordinateIds(subordinate.getAgentId(), accumulator);
            }
        }
    }

    public Object getAgentOverridingCommission(String apiKey, Integer month, Integer year) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgentDownLineCommissionRespVo resp = new AgentDownLineCommissionRespVo();

            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));

            if (!AgencyType.CITADEL.equals(agent.getAgency().getAgencyType())) {
                return resp;
            }

            LocalDate queryDate = LocalDate.now();
            if (month != null && year != null) {
                queryDate = queryDate.withMonth(month).withYear(year);
            }
            final LocalDate startDate = queryDate.withDayOfMonth(1);
            final LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());
            QuarterVo currentQuarter = QuarterVo.addQuarter(startDate, endDate);

            String redisKey = "agentOverridingCommission_" + agent.getAgentId() + "_" + currentQuarter.getStartDate() + "_" + currentQuarter.getEndDate();
            //TODO implement redis cache before production
//            if (RedisUtil.exists(redisKey)) {
//                String cache =  RedisUtil.get(redisKey);
//                return gson.fromJson(cache, AgentDownLineCommissionRespVo.class);
//            }

            List<AgentCommissionHistory> overridingCommissionHistories = agentCommissionHistoryDao.findAllByCommissionTypeAndPaymentStatusAndByDateRange(agent.getAgentId(), AgentCommissionHistory.CommissionType.OVERRIDING, startDate, endDate, Status.SUCCESS);

            List<AgentDownLineProductOrderCommissionDetailsVo> downlineCommissionList = new ArrayList<>();
            for (AgentCommissionHistory commissionHistory : overridingCommissionHistories) {
                AgentDownLineProductOrderCommissionDetailsVo commissionDetailsVo = AgentDownLineProductOrderCommissionDetailsVo.fromAgentCommissionHistory(commissionHistory);
                downlineCommissionList.add(commissionDetailsVo);
            }

            Map<Long, List<AgentDownLineProductOrderCommissionDetailsVo>> groupedByProductId = downlineCommissionList.stream()
                    .collect(Collectors.groupingBy(AgentDownLineProductOrderCommissionDetailsVo::getProductId));

            // Convert the map into a list of AgentDownLineCommissionRespVo objects
            List<AgentDownLineCommissionVo> downLineCommissionList = groupedByProductId.entrySet().stream()
                    .map(entry -> {
                        String productCode = productDao.findProductCodeByProductId(entry.getKey());
                        AgentDownLineCommissionVo agentDownLineCommissionVo = new AgentDownLineCommissionVo();
                        agentDownLineCommissionVo.setProductCode(productCode);
                        agentDownLineCommissionVo.setCommissionList(entry.getValue());
                        return agentDownLineCommissionVo;
                    }).toList();

            resp.setDownLineCommissionList(downLineCommissionList);

            String cache = gson.toJson(resp);
            RedisUtil.set(redisKey, cache, ONE_DAY);
            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Agent Client Details-----------------------------
    private Agent getAgent(AppUser appUser, String agentId) {
        Agent agent;
        if (StringUtil.isNotEmpty(agentId)) {
            agent = agentDao.findByAgentIdAndStatus(agentId, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));
        } else {
            agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(AGENT_PROFILE_TERMINATED));
        }
        return agent;
    }

    public Object getAgentClients(String apiKey, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgentClientRespVo resp = new AgentClientRespVo();
            Agent agent = getAgent(appUser, null);

            //If agent is MGR he can only view his own clients
            if (AgentRole.MGR.equals(agent.getAgentRole().getRoleCode()) && StringUtil.isNotEmpty(agentId)) {
                return resp;
            }
            if (StringUtil.isNotEmpty(agentId)) {
                agent = getAgent(appUser, agentId);
            }

            List<Client> agentClients = clientDao.findAllByAgent(agent);

            List<CorporateClient> corporateClients = agentClients.stream()
                    .map(client -> corporateClientDao.findByClientAndIsDeletedFalse(client))
                    .filter(Objects::nonNull)
                    .toList();

            int newClientThisMonth = 0;
            List<AgentClientVo> clients = new ArrayList<>();
            for (Client client : agentClients) {
                AgentClientVo agentClientVo = AgentClientVo.clientToAgentClientVo(client);
                if (DateUtil.isCurrentMonthAndYear(client.getCreatedAt())) {
                    newClientThisMonth = newClientThisMonth + 1;
                }
                clients.add(agentClientVo);
            }

            for (CorporateClient corporateClient : corporateClients) {
                AgentClientVo agentClientVo = AgentClientVo.corporateClientToAgentClientVo(corporateClient);
                if (DateUtil.isCurrentMonthAndYear(corporateClient.getCreatedAt())) {
                    newClientThisMonth = newClientThisMonth + 1;
                }
                clients.add(agentClientVo);
            }
            resp.setTotalNewClients(newClientThisMonth);
            resp.setTotalClients(clients.size());
            resp.setClients(clients);
            return resp;
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getAgentClientPortfolio(String apiKey, String clientId, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent agent = getAgent(appUser, agentId);
            Client client = clientDao.findByAgentAndClientId(agent, clientId).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
            return clientService.getClientPortfolioByClient(client);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getAgentClientTransactions(String apiKey, String clientId, String agentId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent agent = getAgent(appUser, agentId);
            Client client = clientDao.findByAgentAndClientId(agent, clientId).orElseThrow(() -> new GeneralException(CLIENT_NOT_FOUND));
            return productService.getProductTransaction(client, null);
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    //-----------------------------Secure Tag-----------------------------
    private Client getClientForSecureTag(String clientId, Agent agent) {
        Client client;
        if (clientId.endsWith("I")) {
            client = clientDao.findByAgentAndClientId(agent, clientId).orElseThrow(() -> new GeneralException(INVALID_CLIENT_ID));
        } else if (clientId.endsWith("C")) {
            client = corporateClientDao.findByCorporateClientIdAndAgentAndIsDeletedIsFalse(clientId, agent)
                    .orElseThrow(() -> new GeneralException(CORPORATE_CLIENT_NOT_FOUND))
                    .getClient();
        } else {
            throw new GeneralException(INVALID_CLIENT_ID);
        }
        return client;
    }

    public Object getClientSecureTagStatusUpdate(String apiKey, String clientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            AgentSecureTagRespVo resp = new AgentSecureTagRespVo();
            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            Client client = getClientForSecureTag(clientId, agent);

            AgentSecureTagVo secureTag = null;
            SecureTag clientSecureTag = secureTagDao.getLatestSecureTagByAgentAndClientAndHasReadIsFalse(agent, client);
            if (clientSecureTag != null) {
                if (clientSecureTag.getExpiredAt().before(new Date())) {
                    clientSecureTag.setStatus(SecureTagStatus.EXPIRED);
                    clientSecureTag.setHasRead(true);
                }
                secureTag = new AgentSecureTagVo();
                secureTag.setClientName(client.getUserDetail().getName());
                secureTag.setClientId(client.getClientId());
                secureTag.setStatus(clientSecureTag.getStatus());
                if (SecureTagStatus.APPROVED.equals(clientSecureTag.getStatus())) {
                    secureTag.setToken(clientSecureTag.getToken());
                    clientSecureTag.setHasRead(true);
                }
                if (SecureTagStatus.CANCELLED.equals(clientSecureTag.getStatus()) ||
                        SecureTagStatus.REJECTED.equals(clientSecureTag.getStatus()) ||
                        SecureTagStatus.EXPIRED.equals(clientSecureTag.getStatus())) {
                    clientSecureTag.setHasRead(true);
                }
                secureTagDao.save(clientSecureTag);
            }
            resp.setSecureTag(secureTag);
            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object createClientSecureTag(String apiKey, String clientId) {
        AppUser appUser = validateApiKey(apiKey).getAppUser();
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUser, Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
            Client client = getClientForSecureTag(clientId, agent);

            SecureTag clientSecureTag = secureTagDao.getLatestSecureTagByAgentAndClientAndHasReadIsFalse(agent, client);
            if (clientSecureTag != null) {
                if (clientSecureTag.getExpiredAt().before(new Date())) {
                    clientSecureTag.setStatus(SecureTagStatus.EXPIRED);
                    clientSecureTag.setHasRead(true);
                    secureTagDao.save(clientSecureTag);
                }
                if (!SecureTagStatus.PENDING_APPROVAL.equals(clientSecureTag.getStatus())) {
                    createSecureTagAndSendPush(agent, client);
                } else {
                    return getErrorObjectWithMsg(SECURE_TAG_ALREADY_CREATED);
                }
            } else {
                createSecureTagAndSendPush(agent, client);
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void createSecureTagAndSendPush(Agent agent, Client client) {
        SecureTag secureTag = new SecureTag();
        secureTag.setAgent(agent);
        secureTag.setClient(client);
        secureTag.setStatus(SecureTagStatus.PENDING_APPROVAL);
        secureTag.setToken(UUID.randomUUID().toString());
        secureTag.setCreatedAt(new Date());
        secureTag.setExpiredAt(DateUtil.addMinutes(new Date(), 30));
        secureTag.setHasRead(false);
        secureTagDao.save(secureTag);

        String title = "Secure Tag Request";
        String message = "Agent " + agent.getUserDetail().getName() + " (" + agent.getReferralCode() + ") is requesting your approval to purchase a trust product on your behalf. Please click 'Approve' to confirm or 'Reject' to decline the request.";
        pushNotificationService.notifyAppUser(client.getAppUser(), title, message, new Date(), null, null);
    }

    public Object cancelClientSecureTag(String apiKey, String clientId) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));
        Client client = getClientForSecureTag(clientId, agent);

        SecureTag clientSecureTag = secureTagDao.getLatestSecureTagByAgentAndClientAndHasReadIsFalse(agent, client);
        if (clientSecureTag != null) {
            if (SecureTagStatus.PENDING_APPROVAL.equals(clientSecureTag.getStatus())) {
                clientSecureTag.setStatus(SecureTagStatus.CANCELLED);
                clientSecureTag.setHasRead(true);
                secureTagDao.save(clientSecureTag);
            } else {
                return getErrorObjectWithMsg(INVALID_REQUEST);
            }
        }
        return new BaseResp();
    }

    //-----------------------------Agent Pin-----------------------------
    public Object saveOrUpdateAgentPin(String apiKey, AgentPinReqVo pinReq) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            if (StringUtil.isEmpty(pinReq.getOldPin()) && StringUtil.isEmpty(pinReq.getNewPin())) {
                return getErrorObjectWithMsg(INVALID_REQUEST);
            }
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE).orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            if (StringUtil.isNotEmpty(pinReq.getNewPin()) && StringUtil.isEmpty(pinReq.getOldPin())) {
                // Register new PIN
                if (StringUtil.isNotEmpty(agent.getPin())) {
                    return getErrorObjectWithMsg(INVALID_REQUEST);
                }
                validateAndRegisterNewPin(pinReq, agent);
            } else if (StringUtil.isNotEmpty(pinReq.getOldPin()) && StringUtil.isEmpty(pinReq.getNewPin())) {
                // Validate old PIN
                validateOldPin(pinReq, agent);
            } else {
                // Update old PIN to new PIN
                validateOldPin(pinReq, agent);
                if (StringUtil.isNotEmpty(pinReq.getOldPin()) && StringUtil.isNotEmpty(pinReq.getNewPin())) {
                    validateAndRegisterNewPin(pinReq, agent);
                }
            }
            return new BaseResp();
        } catch (Exception ex) {
            log.error("Error", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    private void validateAndRegisterNewPin(AgentPinReqVo pinReq, Agent agent) {
        if (!validPinFormat(pinReq.getNewPin())) {
            throw new GeneralException(INVALID_NEW_PIN);
        }
        agent.setPin(pinReq.getNewPin().strip());
        agent.setUpdatedAt(new Date());
        agentDao.save(agent);
    }

    private void validateOldPin(AgentPinReqVo pinReq, Agent agent) {
        if (StringUtil.isNotEmpty(agent.getPin())) {
            pinReq.setOldPin(pinReq.getOldPin().strip());
            if (!validPinFormat(pinReq.getOldPin()) || !agent.getPin().equals(pinReq.getOldPin())) {
                throw new GeneralException(INVALID_OLD_PIN);
            }
        }
    }

    public Object getPendingAgreementSignature(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE)
                    .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            // fetch only the product order that related to the agent where pending agent signature and client signature completed.
            List<ClientPortfolioVo> clientPortfolios = productOrderDao.findProductOrdersByAgentAndClientAgreementStatusAndWitnessAgreementStatus(agent, Status.SUCCESS, Status.PENDING).stream()
                    .map(productOrder -> productService.getClientPortfolioVoWithOptions(productOrder))
                    .sorted(Comparator.comparing(ClientPortfolioVo::getClientSignatureDate, Comparator.nullsLast(Comparator.reverseOrder())))
                    .toList();

            List<ClientPortfolioVo> earlyRedemptionPortfolios = new ArrayList<>();
            List<ProductEarlyRedemptionHistory> earlyRedemptionHistoryList = productEarlyRedemptionHistoryDao.findByAgentAndClientSignatureStatusAndWitnessSignatureStatusOrderByClientSignatureDateAsc(agent, Status.SUCCESS, Status.PENDING);
            for (ProductEarlyRedemptionHistory earlyRedemptionHistory : earlyRedemptionHistoryList) {
                ClientPortfolioVo clientPortfolioVo = ClientPortfolioVo.productOrderToClientPortfolioVo(earlyRedemptionHistory.getProductOrder());
                PortfolioProductOrderOptionsVo optionsVo = PortfolioProductOrderOptionsVo.getMostRecentOption(List.of(earlyRedemptionHistory));
                clientPortfolioVo.setOptionsVo(optionsVo);
                clientPortfolioVo.setStatus(ProductOrder.ProductOrderStatus.AGREEMENT);
                clientPortfolioVo.setRemark("Pending Witness Agreement signature");
                earlyRedemptionPortfolios.add(clientPortfolioVo);
            }

            AgentPendingSignatureRespVo resp = new AgentPendingSignatureRespVo();
            resp.setProductOrders(clientPortfolios);
            resp.setEarlyRedemptions(earlyRedemptionPortfolios);
            return resp;
        } catch (Exception ex) {
            log.error("Error fetching pending agreement signatures", ex);
            return getErrorObjectWithMsg(ex.getMessage());
        }
    }

    public Object getDownLineList(String apiKey) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        try {
            Agent agent = agentDao.findByAppUserAndStatus(appUserSession.getAppUser(), Agent.AgentStatus.ACTIVE)
                    .orElseThrow(() -> new GeneralException(USER_NOT_FOUND));

            Set<Long> allSubordinateIds = new HashSet<>();
            Queue<Long> queue = new LinkedList<>();
            queue.add(agent.getId());

            while (!queue.isEmpty()) {
                Long currentId = queue.poll();
                List<CitadelAgentVo> subordinates = agentDao.findSubordinatesByRecruitManagerId(currentId);

                for (CitadelAgentVo subordinate : subordinates) {
                    allSubordinateIds.add(subordinate.getAgentId());
                    queue.add(subordinate.getAgentId());
                }
            }

            List<Agent> agentList = agentDao.findAllById(new ArrayList<>(allSubordinateIds));
            List<AgentVo> agentDownLineList = agentList.stream()
                    .map(Agent::getAgentDetails)
                    .collect(Collectors.toList());

            AgentDownLineListRespVo resp = new AgentDownLineListRespVo();
            resp.setAgentDownLineList(agentDownLineList);
            return resp;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            return new AgentDownLineListRespVo();
        }
    }

    //-----------------------------Agent Commission Monthly Report-----------------------------
    public AgentCommissionMonthlyReportRespVo getAgentCommissionMonthlyReport(String apiKey, String agentId, Integer month, Integer year) {
        AppUserSession appUserSession = validateApiKey(apiKey);
        AgentCommissionMonthlyReportRespVo respVo = new AgentCommissionMonthlyReportRespVo();
        try {
            DecimalFormat decimalFormatter = new DecimalFormat("#,##0.00");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d/M/yyyy");
            Agent agent = getAgent(appUserSession.getAppUser(), agentId);

            // Determine the date range based on month and year parameters
            LocalDate queryDate = LocalDate.now();
            if (month != null && year != null) {
                queryDate = queryDate.withMonth(month).withYear(year);
            }

            // Set start and end dates for the month
            final LocalDate startDate = queryDate.withDayOfMonth(1);
            final LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());

            List<AgentCommissionHistory> personalCommissionHistories = agentCommissionHistoryDao.findAllByCommissionTypeAndByDateRange(agent.getAgentId(), AgentCommissionHistory.CommissionType.PERSONAL, startDate, endDate);
            List<AgentCommissionHistory> overridingCommissionHistories = agentCommissionHistoryDao.findAllByCommissionTypeAndByDateRange(agent.getAgentId(), AgentCommissionHistory.CommissionType.OVERRIDING, startDate, endDate);

            Map<Long, List<AgentCommissionHistory>> personalCommissionHistoriesByProductIdMap = personalCommissionHistories.stream()
                    .collect(Collectors.groupingBy(history -> history.getAgentCommissionCalculationHistory().getProductId()));

            Map<Long, List<AgentCommissionHistory>> overridingCommissionHistoriesByProductIdMap = overridingCommissionHistories.stream()
                    .collect(Collectors.groupingBy(history -> history.getAgentCommissionCalculationHistory().getProductId()));

            List<Product> productList = productDao.findAllByIsPublishedIsTrueAndStatusIsTrue();

            double grandTotal = 0;
            List<Map<String, Object>> productDataList = new ArrayList<>();

            for (Product product : productList) {
                double productTotalCommission = 0;
                Map<String, Object> productData = new HashMap<>();
                productData.put("productCode", product.getCode());

                //Product personal commission record
                List<Map<String, String>> personalSalesRecords = new ArrayList<>();
                List<AgentCommissionHistory> personalCommissionListByProduct = personalCommissionHistoriesByProductIdMap.get(product.getId());
                if (personalCommissionListByProduct != null && !personalCommissionListByProduct.isEmpty()) {
                    int personalRecordCount = 1;
                    for (AgentCommissionHistory history : personalCommissionListByProduct) {
                        Map<String, String> pRecord = new HashMap<>();
                        pRecord.put("no", String.valueOf(personalRecordCount));
                        pRecord.put("date", history.getAgentCommissionCalculationHistory().getCalculatedDate().format(formatter));
                        pRecord.put("clientName", history.getAgentCommissionCalculationHistory().getClientName() != null ? history.getAgentCommissionCalculationHistory().getClientName() : "");
                        pRecord.put("agreementNumber", history.getAgentCommissionCalculationHistory().getOrderAgreementNumber());
                        pRecord.put("consultantName", agent.getUserDetail().getName());
                        pRecord.put("amount", decimalFormatter.format(history.getAgentCommissionCalculationHistory().getPurchasedAmount()));
                        pRecord.put("commPercent", String.format("%.2f", history.getCommissionPercentage()));
                        pRecord.put("commAmount", decimalFormatter.format(history.getCommissionAmount()));
                        personalSalesRecords.add(pRecord);

                        personalRecordCount++;
                        productTotalCommission = productTotalCommission + history.getCommissionAmount();
                        grandTotal = grandTotal + history.getCommissionAmount();
                    }
                } else {
                    //Artificially generate 1 empty rows
                    for (int i = 1; i < 2; i++) {
                        Map<String, String> pRecord = new HashMap<>();
                        pRecord.put("no", String.valueOf(i));
                        pRecord.put("date", "");
                        pRecord.put("clientName", "");
                        pRecord.put("agreementNumber", "");
                        pRecord.put("consultantName", "");
                        pRecord.put("amount", "");
                        pRecord.put("commPercent", "");
                        pRecord.put("commAmount", "-");
                        personalSalesRecords.add(pRecord);
                    }
                }
                //Product overriding commission record
                List<Map<String, String>> productOverrideSales = new ArrayList<>();
                List<AgentCommissionHistory> overridingCommissionListByProduct = overridingCommissionHistoriesByProductIdMap.get(product.getId());
                if (overridingCommissionListByProduct != null && !overridingCommissionListByProduct.isEmpty()) {
                    int overrideRecordCount = 1;
                    for (AgentCommissionHistory history : overridingCommissionListByProduct) {
                        Map<String, String> oRecord = new HashMap<>();
                        oRecord.put("no", String.valueOf(overrideRecordCount));
                        oRecord.put("date", history.getAgentCommissionCalculationHistory().getCalculatedDate().format(formatter));
                        oRecord.put("clientName", history.getAgentCommissionCalculationHistory().getClientName() != null ? history.getAgentCommissionCalculationHistory().getClientName() : "");
                        oRecord.put("agreementNumber", history.getAgentCommissionCalculationHistory().getOrderAgreementNumber());
                        oRecord.put("consultantName", history.getAgentCommissionCalculationHistory().getMgrName());
                        oRecord.put("amount", decimalFormatter.format(history.getAgentCommissionCalculationHistory().getPurchasedAmount()));
                        oRecord.put("commPercent", String.format("%.2f", history.getCommissionPercentage()));
                        oRecord.put("commAmount", decimalFormatter.format(history.getCommissionAmount()));
                        productOverrideSales.add(oRecord);

                        overrideRecordCount++;
                        productTotalCommission = productTotalCommission + history.getCommissionAmount();
                        grandTotal = grandTotal + history.getCommissionAmount();
                    }
                } else {
                    for (int i = 1; i < 2; i++) {
                        Map<String, String> oRecord = new HashMap<>();
                        oRecord.put("no", String.valueOf(i));
                        oRecord.put("date", "");
                        oRecord.put("clientName", "");
                        oRecord.put("agreementNumber", "");
                        oRecord.put("consultantName", "");
                        oRecord.put("amount", "");
                        oRecord.put("commPercent", "");
                        oRecord.put("commAmount", "-");
                        productOverrideSales.add(oRecord);
                    }
                }

                productData.put("personalSalesRecords", personalSalesRecords);
                productData.put("overrideSalesRecords", productOverrideSales);
                productData.put("productTotalCommission", decimalFormatter.format(productTotalCommission));
                productDataList.add(productData);
            }

            // Prepare model for template
            HashMap<String, Object> model = new HashMap<>();

            // Agent information
            model.put("agentName", agent.getUserDetail().getName());
            model.put("agentDesignation", agent.getAgentRole().getRoleCode().name());
            model.put("statementDate", queryDate.toString());
            model.put("payDate", endDate);
            model.put("productList", productDataList);
            model.put("grandTotal", decimalFormatter.format(grandTotal));

            String template = "agent_commission_report.ftl";
            String htmlContent = pdfService.renderTemplate(template, model);
            byte[] pdfBytes = pdfService.generatePdf(htmlContent);

            String fileName = "commission_report_V2_" + agent.getAgentId() + "_" + queryDate.getMonthValue() + "_" + queryDate.getYear() + ".pdf";
            String filePath = S3_AGENT_PATH + agent.getAgentId() + "/reports";
            String s3Key = filePath + "/" + fileName;

            AwsS3Util.uploadByteArray(pdfBytes, s3Key, true);
            String link = AwsS3Util.getS3DownloadUrl(s3Key);
            respVo.setAgentCommissionMonthlyReport(link);
            return respVo;
        } catch (Exception ex) {
            log.error("Error in {} : ", getFunctionName(), ex);
            respVo.setAgentCommissionMonthlyReport(null);
            return respVo;
        }
    }
}