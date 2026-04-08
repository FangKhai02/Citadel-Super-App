package com.citadel.backend.utils;

import com.citadel.backend.utils.Builder.DigitalIDBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.vo.DigitalIDResultVo;
import com.citadel.backend.vo.Enum.UserType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.commands.JedisCommands;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

import static com.citadel.backend.utils.ApiErrorKey.CREATE_DIGITAL_ID_FAILED;

public class DigitalIDUtil extends StringUtil {
    public static final Logger log = LoggerFactory.getLogger(DigitalIDUtil.class);

    public static DigitalIDResultVo createDigitalID(DigitalIDBuilder builder) {
        try {
            DigitalIDResultVo result = new DigitalIDResultVo();
            if (builder == null) {
                throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
            }

            String formattedName = getFormattedName(builder.getName(), builder.getBuilderType());
            String runningNumber = getRunningNumber(builder.getBuilderType());
            String digitalID = null;

            if (DigitalIDBuilder.BuilderType.CLIENT.equals(builder.getBuilderType())) {
                String date = getFormattedDate(builder.getDate());
                digitalID = formattedName + date + runningNumber + "-I";
            } else if (DigitalIDBuilder.BuilderType.CORPORATE_CLIENT.equals(builder.getBuilderType())) {
                String date = getFormattedDate(builder.getDate());
                digitalID = formattedName + date + runningNumber + "-C";
            } else if (DigitalIDBuilder.BuilderType.AGENT.equals(builder.getBuilderType())) {
                String agencyCode = builder.getAgencyCode();
                digitalID = agencyCode + formattedName + runningNumber;
            } else if (DigitalIDBuilder.BuilderType.AGENCY.equals(builder.getBuilderType())) {
                String regNum = getFormattedRegNum(builder.getCompanyRegistrationNumber());
                digitalID = formattedName + regNum + runningNumber;
            }
            result.setDigitalID(digitalID);
            result.setRunningNumber(runningNumber);
            return result;
        } catch (Exception ex) {
            log.error("Error : ", ex);
            throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
        }
    }

    public static String createAgreementID(DigitalIDBuilder builder) {
        try {
            if (builder == null) {
                throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
            }
            String runningNumber = getRunningNumber(builder.getBuilderType());
            StringBuilder sb = new StringBuilder();
            sb.append(builder.getName());
            if (UserType.CLIENT.equals(builder.getUserType())) {
                sb.append("-").append("IND");
            } else {
                sb.append("-").append("CORP");
            }
            LocalDate localDate = DateUtil.convertDateToLocalDate(builder.getDate());
            sb.append(localDate.getYear())
                    .append("-")
                    .append(String.format("%02d", localDate.getMonthValue()))
                    .append("-")
                    .append(runningNumber);

            if (DigitalIDBuilder.BuilderType.PRODUCT_ROLLOVER.equals(builder.getBuilderType())) {
                sb.append("-ROLLOVER");
            } else if (DigitalIDBuilder.BuilderType.PRODUCT_REALLOCATE.equals(builder.getBuilderType())) {
                sb.append("-REALLOCATE-").append(builder.getProductName());
            }
            return sb.toString();
        } catch (Exception ex) {
            log.error("Error : ", ex);
            throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
        }
    }

    private static String getFormattedName(String name, DigitalIDBuilder.BuilderType builderType) {
        if (name == null || name.trim().isEmpty()) {
            throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
        }

        if (DigitalIDBuilder.BuilderType.CLIENT.equals(builderType) ||
                DigitalIDBuilder.BuilderType.CORPORATE_CLIENT.equals(builderType) ||
                DigitalIDBuilder.BuilderType.AGENT.equals(builderType)) {
            return name.substring(0, 3).toUpperCase();
        } else {
            String[] words = name.trim().split("\\s+"); // Split name by spaces
            StringBuilder initials = new StringBuilder();

            // Get the first character from the first three words or as many as available
            for (int i = 0; i < Math.min(words.length, 3); i++) {
                initials.append(words[i].charAt(0));
            }

            // If the result has less than 3 characters, pad with additional letters from the first word
            if (initials.length() < 3 && words.length > 0) {
                String firstWord = words[0];
                for (int i = 1; i < firstWord.length() && initials.length() < 3; i++) {
                    initials.append(firstWord.charAt(i));
                }
            }

            return initials.toString().toUpperCase();
        }
    }

    private static String getFormattedDate(Date date) {
        if (date == null) {
            throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
        }
        SimpleDateFormat formatter = new SimpleDateFormat("ddMMyy");
        // Format the date into the desired string
        return formatter.format(date);
    }

    private static String getFormattedRegNum(String companyRegistrationNumber) {
        if (StringUtil.isEmpty(companyRegistrationNumber)) {
            throw new GeneralException(CREATE_DIGITAL_ID_FAILED);
        }
        String result = StringUtil.removeAllSpecialCharacters(companyRegistrationNumber);
        result = StringUtil.removeAllAlphabets(result);

        if (result.length() < 6) {
            return String.format("%6s", result).replace(' ', '0');
        }
        return result.substring(result.length() - 6);
    }

    public static String getRunningNumber(DigitalIDBuilder.BuilderType builderType) {
        JedisCommands jedis = RedisUtil.getConnection();
        long runningNumber = 1;
        String key = DigitalIDBuilder.DIGITAL_ID_REDIS_KEY + "/" + builderType.name().toLowerCase();
        try {
            if (!RedisUtil.exists(key)) {
                RedisUtil.set(key, String.valueOf(DigitalIDBuilder.startingNumber));
            }
            runningNumber = jedis.incr(key);

            // If the number exceeds the endNumber, reset it back to startNumber
            if (runningNumber > DigitalIDBuilder.endingNumber) {
                RedisUtil.set(key, String.valueOf(DigitalIDBuilder.startingNumber));
                runningNumber = DigitalIDBuilder.startingNumber;
            }
            return String.format("%04d", runningNumber);
        } catch (Exception ex) {
            log.error("Error : ", ex);
        } finally {
            RedisUtil.closeConnection(jedis);
        }
        return String.format("%04d", runningNumber);
    }

    public static String extractRunningNumber(String digitalID) {
        if (StringUtil.isEmpty(digitalID) || digitalID.length() < 4) {
            return null;
        }

        // Find the position of the suffix (-I or -C)
        int suffixPosition = digitalID.lastIndexOf("-I");
        if (suffixPosition == -1) {
            suffixPosition = digitalID.lastIndexOf("-C");
        }

        // If a suffix is found, extract the running number before the suffix
        if (suffixPosition != -1) {
            if (suffixPosition < 4) {
                return null;
            }
            return digitalID.substring(suffixPosition - 4, suffixPosition);
        }

        // If no suffix is found, extract the last 4 characters
        return digitalID.substring(digitalID.length() - 4);
    }

    public static void main(String[] args) {

        //Client ID
        DigitalIDResultVo result = createDigitalID(new DigitalIDBuilder()
                .builderType(DigitalIDBuilder.BuilderType.CLIENT)
                .name("Tan KOk Yen")
                .date(new Date()));
        System.out.println(result.getDigitalID());// Output: TAN1612240001-I

        //Corporate Client ID
        DigitalIDResultVo result2 = createDigitalID(new DigitalIDBuilder()
                .builderType(DigitalIDBuilder.BuilderType.CORPORATE_CLIENT)
                .name("Nexstream Sdn Bhd")
                .date(new Date()));
        System.out.println(result2.getDigitalID());// Output: NEX1312240001-C

        //Agent ID
        DigitalIDResultVo result3 = createDigitalID(new DigitalIDBuilder()
                .builderType(DigitalIDBuilder.BuilderType.AGENT)
                .name("Tan KOk Yen")
                .agencyCode("NSB"));
        System.out.println(result3.getDigitalID());// Output: NSBTAN0001

        //Agency ID
        DigitalIDResultVo result4 = createDigitalID(new DigitalIDBuilder()
                .builderType(DigitalIDBuilder.BuilderType.AGENCY)
                .name("Nexstream Sdn Bhd")
                .companyRegistrationNumber("732962-U"));
        System.out.println(result4.getDigitalID());// Output: NEX000001
    }
}