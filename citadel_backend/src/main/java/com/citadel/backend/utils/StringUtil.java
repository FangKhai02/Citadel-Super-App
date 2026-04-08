package com.citadel.backend.utils;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Entities;

import java.util.*;

public class StringUtil extends StringUtils {
    public static final String allSpecialChars = "[`~!@#$%^&*()_+=\\[\\]{};:\"'<>,.?/|\\\\\\-]";

    public static boolean isEmpty(String str) {
        if (StringUtils.isEmpty(str)) {
            return true;
        }

        // Normalize the string to handle various Unicode forms
        String normalized = java.text.Normalizer.normalize(str, java.text.Normalizer.Form.NFKC);

        // Java whitespace + NBSP variants + common zero-widths
        String cleaned = normalized.replaceAll(
                "[\\p{javaWhitespace}\\u00A0\\u2007\\u202F\\u200B\\u2060\\uFEFF]+",
                ""
        );

        return cleaned.isEmpty();
    }

    public static boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    public static String removeAllSpecialCharacters(String input) {
        return input.replaceAll(allSpecialChars, "");
    }

    public static String removeAllAlphabets(String input) {
        return input.replaceAll("[a-zA-Z]", "");
    }

    public static String removeCharacters(String input, List<Character> characters) {
        if (StringUtil.isEmpty(input) || characters == null || characters.isEmpty()) {
            return null;
        }
        return input.replaceAll("[" + characters + "]", "");
    }

    public static <E extends Enum<E>> E getEnumFromString(Class<E> enumClass, String value) {
        if (StringUtil.isEmpty(value)) {
            return null;
        }
        return Arrays.stream(enumClass.getEnumConstants())
                .filter(enumValue -> enumValue.name().equalsIgnoreCase(value))
                .findFirst()
                .orElse(null);
    }

    public static String addCountryCodePrefixToMobileNumber(String countryCode, String mobileNumber) {
        //returns mobile number with 60 or 65 as prefix
        if (StringUtils.isEmpty(mobileNumber)) {
            return null;
        }

        mobileNumber = mobileNumber.replace("+", "").replace("-", "").replace(" ", "");

        if (mobileNumber.startsWith("60") || mobileNumber.startsWith("65")) {
            return mobileNumber;
        }

        if (StringUtils.isNotEmpty(countryCode)) {
            mobileNumber = countryCode + mobileNumber;
        }

        if (mobileNumber.startsWith("+")) {
            mobileNumber = mobileNumber.substring(1);
        }
        return mobileNumber;
    }

    public static String removeCountryCodeFromMobileNumber(String mobileNumber) {
        if (StringUtils.isNotEmpty(mobileNumber)) {
            mobileNumber = mobileNumber.replace("+", "").replace("-", "").replace(" ", "");
            mobileNumber = mobileNumber.startsWith("60") || mobileNumber.startsWith("65") ? mobileNumber.substring(2) : mobileNumber;
        }
        return mobileNumber;
    }

    public static String encodeStringToBase64(String input) {
        return Base64.getEncoder().encodeToString(input.getBytes());
    }

    public static String getCountryCodeFromCountryName(String country) {
        return Arrays.stream(Locale.getISOCountries())
                .map((s) -> new Locale("", s))
                .filter((l) -> l.getDisplayCountry().equalsIgnoreCase(country))
                .findFirst()
                .map(Locale::getCountry)
                .orElse("UNKNOWN");
    }

    public static byte[] decodeBase64ToFile(String base64EncodedFile) {
        return Base64.getDecoder().decode(base64EncodedFile);
    }

    public static String extractFilenameFromS3Key(String s3Key) {
        if (StringUtils.isEmpty(s3Key)) {
            return null;
        }

        // Find the last slash to get the filename with extension
        int lastSlashIndex = s3Key.lastIndexOf('/');
        return lastSlashIndex != -1 ? s3Key.substring(lastSlashIndex + 1) : s3Key;
    }

    public static String removeFileExtensionFromFileName(String fileName) {
        if (StringUtils.isEmpty(fileName)) {
            return null;
        }

        // Find the last dot to get the filename without extension
        int lastDotIndex = fileName.lastIndexOf('.');
        return lastDotIndex != -1 ? fileName.substring(0, lastDotIndex) : fileName;

    }

    public static String sanitizeHtml(String html) {
        if (StringUtils.isEmpty(html)) {
            return null;
        }
        // Parse the raw HTML (as a body fragment to avoid adding extra tags)
        Document document = Jsoup.parseBodyFragment(html);
        // Configure the output settings to produce valid XML
        document.outputSettings()
                .syntax(Document.OutputSettings.Syntax.xml) // use XML syntax so that all entities are escaped properly
                .escapeMode(Entities.EscapeMode.xhtml)        // set escape mode to XHTML
                .prettyPrint(false);

        return document.body().html();
    }

    public static String sanitizeFullHtml(String html) {
        if (StringUtils.isEmpty(html)) {
            return null;
        }
        Document document = Jsoup.parse(html);
        document.outputSettings()
                .syntax(Document.OutputSettings.Syntax.xml) // use XML syntax so that all entities are escaped properly
                .escapeMode(Entities.EscapeMode.xhtml)      // set escape mode to XHTML
                .prettyPrint(false);

        // Return the complete document HTML
        return document.html();
    }

    public static String extractDownloadLinkFromCmsContent(String content) {
        if (StringUtils.isEmpty(content)) {
            return null;
        }
        if (!content.startsWith("[")) {
            return content;
        }
        JSONArray jsonArray = new JSONArray(content);
        JSONObject jsonObject = jsonArray.getJSONObject(0);
        // 3) Get the "download_link" field
        String downloadLink = jsonObject.getString("download_link");
        return downloadLink.replace("\\", "/");
    }

    public static String capitalizeEachWord(String str) {
        if (StringUtil.isEmpty(str)) {
            //TODO migrate to null
            return " ";
        }

        StringBuilder finalResult = new StringBuilder();
        boolean capitalizeNext = true; // Ensures the first character is always capitalized

        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (capitalizeNext && Character.isLetter(c)) {
                finalResult.append(Character.toUpperCase(c));
                capitalizeNext = false; // Reset flag after capitalizing
            } else {
                finalResult.append(Character.toLowerCase(c)); // Set remaining characters to lower case
            }
            if (c == ' ' || c == ',') {
                capitalizeNext = true;
            }
        }
        String result = finalResult.toString().replaceAll("\\s+", " ").trim(); // Ensures proper spacing
        if (result.contains("Wp Kuala Lumpur")) {
            result = result.replace("Wp Kuala Lumpur", "WP Kuala Lumpur");
        }
        return result;
    }

    public static String formatMalaysianMobileNumber(String mobileCountryCode, String mobileNumber) {
        if ((StringUtils.isEmpty(mobileCountryCode) && StringUtils.isEmpty(mobileNumber)) || StringUtil.isEmpty(mobileNumber)) {
            return "";
        }

        if (mobileCountryCode == null) {
            mobileCountryCode = "0";
        } else {
            mobileCountryCode = mobileCountryCode.substring(2);
        }
        String firstTwo = mobileNumber.substring(0, 2);
        String remaining = mobileNumber.substring(2);

        return mobileCountryCode + firstTwo + "-" + remaining;
    }
}
