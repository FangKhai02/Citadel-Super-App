package com.citadel.backend.service;

import com.citadel.backend.vo.FaceID.FaceCompareReqVo;
import com.citadel.backend.vo.FaceID.FaceCompareRespVo;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.beans.factory.annotation.Value;

import java.util.HashMap;
import java.util.Map;

/**
 * Service for calling the FaceNet sidecar microservice for face comparison.
 * The sidecar service runs separately and exposes face comparison via HTTP.
 */
@Service
@Slf4j
public class FaceNetService {

    private final RestTemplate restTemplate;
    private final Gson gson;
    private final String sidecarUrl;

    public FaceNetService(@Value("${facenet.sidecar.url:http://localhost:3001}") String sidecarUrl) {
        this.restTemplate = new RestTemplate();
        this.gson = new Gson();
        this.sidecarUrl = sidecarUrl;
    }

    /**
     * Calls the FaceNet sidecar to compare a selfie against a document image.
     *
     * @param req The face comparison request containing both images and metadata
     * @return FaceCompareRespVo with verified status, score, and message
     */
    public FaceCompareRespVo compareFaces(FaceCompareReqVo req) {
        try {
            String endpoint = sidecarUrl + "/api/face/compare";

            // Build request body for sidecar
            Map<String, String> requestBody = new HashMap<>();
            requestBody.put("documentImage", req.getDocumentImage());
            requestBody.put("selfieImage", req.getSelfieImage());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String jsonBody = gson.toJson(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

            log.info("[FaceNet] Calling sidecar at: {}", endpoint);

            ResponseEntity<String> response = restTemplate.exchange(
                    endpoint,
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                // Parse the sidecar response
                // Expected format: { "success": true, "data": { "verified": bool, "score": number, ... }, "error": null }
                Map<String, Object> respMap = gson.fromJson(response.getBody(), Map.class);

                if (Boolean.TRUE.equals(respMap.get("success"))) {
                    Map<String, Object> dataMap = (Map<String, Object>) respMap.get("data");
                    FaceCompareRespVo respVo = new FaceCompareRespVo();
                    respVo.setVerified((Boolean) dataMap.get("verified"));
                    respVo.setScore((Double) dataMap.get("score"));
                    respVo.setDegraded((Boolean) dataMap.get("degraded"));
                    respVo.setMessage((String) dataMap.get("message"));
                    log.info("[FaceNet] Face comparison result: verified={}, score={}", respVo.getVerified(), respVo.getScore());
                    return respVo;
                } else {
                    log.error("[FaceNet] Sidecar returned error: {}", respMap.get("error"));
                    throw new RuntimeException("Face comparison failed: " + respMap.get("error"));
                }
            } else {
                log.error("[FaceNet] Sidecar returned non-2xx status: {}", response.getStatusCode());
                throw new RuntimeException("Face comparison service unavailable");
            }
        } catch (Exception e) {
            log.error("[FaceNet] Error calling sidecar service: {}", e.getMessage(), e);
            FaceCompareRespVo errorResp = new FaceCompareRespVo();
            errorResp.setVerified(false);
            errorResp.setScore(-1.0);
            errorResp.setDegraded(true);
            errorResp.setMessage("Face verification service unavailable. Please try again later.");
            return errorResp;
        }
    }
}
