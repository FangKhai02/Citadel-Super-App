package com.citadel.backend.utils;

import com.github.kevinsawicki.http.HttpRequest;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EsmsUtil {
    protected static final Logger log = LoggerFactory.getLogger(EsmsUtil.class);
    public static final String ESMS_API_KEY = "a1926884fe4d492a80a9d9a45656e589";

    public static final String ESMS_API_SECRET = "dv07zqsuly350tdaiqn8b80fkr9m7qq7epfhmdkbb0j51crpz0ece6lfrfe6m552lapyiry78hdket6w2kgphuq0oy7kk4d5844f";

    public static String sendSmsToEsms(String toMobileNumber, String msg) {
        String responseBody = null;
        try {
            JSONObject json = new JSONObject();
            json.put("user", ESMS_API_KEY);
            json.put("pass", ESMS_API_SECRET);
            json.put("to", toMobileNumber); // eg. "60123456789"
            json.put("msg", "RM0.00 " + msg); // For SMS to Malaysia mobile phones, you're required to append RM0.00<space> at the front of the message

            HttpRequest httpRequest = HttpRequest.post("https://api.esms.com.my/sms/send")
                    .contentType("application/json")
                    .send(json.toString());

            responseBody = httpRequest.body();
            String method = new Object() {
            }.getClass().getEnclosingMethod().getName();
            log.info(method + " url: " + httpRequest.url());
            log.info(method + " request: " + json.toString());
            log.info(method + " response: " + responseBody);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return responseBody;
    }

    public static int checkBalance() {
        try {
            JSONObject json = new JSONObject();
            json.put("user", ESMS_API_KEY);
            json.put("pass", ESMS_API_SECRET);

            HttpRequest httpRequest = HttpRequest.post("https://api.esms.com.my/sms/balance")
                    .contentType("application/json")
                    .send(json.toString());

            String body = httpRequest.body();
            String method = new Object() {
            }.getClass().getEnclosingMethod().getName();
            log.info(method + " url: " + httpRequest.url());
            log.info(method + " request: " + json.toString());
            log.info(method + " response: " + body);

            JSONObject jsonResponse = new JSONObject(body);
            int status = jsonResponse.getInt("status");
            if (status == 0) {
                int balance = jsonResponse.getInt("balance");
                log.info("Balance: " + balance);
                return balance;
            } else {
                log.info("Error from API: " + jsonResponse.getString("message"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
