package com.citadel.backend.utils;

import com.citadel.backend.utils.Builder.RandomCodeBuilder;
import com.citadel.backend.utils.exception.GeneralException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

@Slf4j
public class RandomCodeUtil {
    /**
     * One utility class to generate random code based on the given pattern.
     *
     * To use this method uncomment the main method and run the RandomCodeUtil class.
     *
     * @return The generated random code
     * @throws NoSuchAlgorithmException If the algorithm is not found
     */
    private static final String DEFAULT_ALGORITHM = "SHA1PRNG";

    public static String generateRandomCode() throws Exception {
        return generateRandomCode(null);
    }

    public static String generateRandomCode(RandomCodeBuilder builder) throws Exception {
        try {
            if (builder == null) {
                return generateRandomString(RandomCodeBuilder.ALPHANUMERIC, RandomCodeBuilder.DEFAULT_LENGTH);
            }

            int length = builder.getLength();
            length = builder.getPattern() == null ? length : getPatternLength(builder);

            if (builder.getPrefix() == null) {
                builder.setPrefix(builder.getCharset());
                builder.setPrefixLength(length / 2);
            }

            if (builder.getPostfix() == null) {
                builder.setPostfix(builder.getCharset());
                builder.setPostfixLength(length / 2);
            }

            String code = getPrefix(builder) + getPostfix(builder);

            // Generate code based on pattern
            if (builder.getPattern() != null) {
                code = getCodeByPattern(builder, code);
            }
            return code;

        } catch (Exception e) {
            log.error("Exception", e);
            throw new GeneralException(e.getMessage());
        }
    }

    private static int getPatternLength(RandomCodeBuilder builder) throws Exception {
        int index = 0;
        if (builder.getPattern() == null) {
            return index;
        }
        for (char c : builder.getPattern().toCharArray()) {
            if (!RandomCodeBuilder.allowedChar.contains(c)) {
                throw new Exception("Pattern contains invalid characters. Only '#' and '-' are allowed.");
            }
            if (c == RandomCodeBuilder.PATTERN_PLACEHOLDER) {
                index++;
            }
        }
        return index;
    }

    private static String getCodeByPattern(RandomCodeBuilder builder, String combinedCode) {
        StringBuilder code = new StringBuilder();
        int codeIndex = 0;
        for (char c : builder.getPattern().toCharArray()) {
            if (c == RandomCodeBuilder.PATTERN_PLACEHOLDER && codeIndex < combinedCode.length()) {
                code.append(combinedCode.charAt(codeIndex++));
            } else {
                code.append(c);
            }
        }
        return code.toString();
    }

    private static String getPrefix(RandomCodeBuilder builder) throws NoSuchAlgorithmException {
        StringBuilder prefix = new StringBuilder();
        if (builder == null || builder.getPrefix() == null) {
            return null;
        }
        if (StringUtils.isNotEmpty(builder.getPrefix()) && builder.getPrefixLength() == null) {
            return builder.getPrefix();
        }

        prefix.append(generateRandomString(builder.getPrefix(), builder.getPrefixLength()));
        return prefix.toString();
    }

    private static String getPostfix(RandomCodeBuilder builder) throws NoSuchAlgorithmException {
        StringBuilder postfix = new StringBuilder();
        if (builder == null || builder.getPostfix() == null) {
            return null;
        }
        if (StringUtils.isNotEmpty(builder.getPostfix()) && builder.getPostfixLength() == null) {
            return builder.getPostfix();
        }

        postfix.append(generateRandomString(builder.getPostfix(), builder.getPostfixLength()));
        return postfix.toString();
    }

    private static String generateRandomString(String charset, int length) throws NoSuchAlgorithmException {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(generateRandomChar(charset));
        }
        return sb.toString();
    }

    private static char generateRandomChar(String charset) throws NoSuchAlgorithmException {
        SecureRandom random = SecureRandom.getInstance(DEFAULT_ALGORITHM);
        int index = random.nextInt(charset.length());
        return charset.charAt(index);
    }

    private static String addMinutesToDate(int minutes) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.add(java.util.Calendar.MINUTE, minutes);
        return cal.getTime().toString();
    }

//    public static void main(String[] args) throws Exception {
//        System.out.println("Order Reference Number: " +  generateRandomCode(new RandomCodeBuilder()
//                .prefix("ORD" + System.currentTimeMillis())
//                .postfix(RandomCodeBuilder.NUMBERS)
//                .postfixLength(3)));
//
//        System.out.println("Topup Reference Number: " +  generateRandomCode(new RandomCodeBuilder()
//                .prefix("TOP" + System.currentTimeMillis())
//                .postfix(RandomCodeBuilder.NUMBERS)
//                .postfixLength(3)));
//
//        System.out.println("OTP Code: " +  generateRandomCode(new RandomCodeBuilder()
//                .length(6)
//                .charSet(RandomCodeBuilder.NUMBERS)));
//
//        System.out.println("Referral Code: " +  generateRandomCode(new RandomCodeBuilder()
//                .prefix(RandomCodeBuilder.ALPHABETIC_UPPERCASE)
//                .prefixLength(3)
//                .postfix(RandomCodeBuilder.NUMBERS)
//                .postfixLength(3)));
//
//        System.out.println("Password: " +  generateRandomCode(new RandomCodeBuilder()
//                .length(8)
//                .charSet(RandomCodeBuilder.ALPHANUMERIC)));
//
//        System.out.println("Card Number: " + generateRandomCode(new RandomCodeBuilder()
//                .pattern("####-####-####-####")
//                .charSet(RandomCodeBuilder.NUMBERS)));
//
//        System.out.println("Random Number: " + generateRandomCode(new RandomCodeBuilder()
//                .charSet(RandomCodeBuilder.ALPHABETIC)
//                .length(32)));
//    }
}
