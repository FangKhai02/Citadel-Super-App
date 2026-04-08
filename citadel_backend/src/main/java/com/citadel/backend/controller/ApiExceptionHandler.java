package com.citadel.backend.controller;

import com.citadel.backend.utils.Constant;
import com.citadel.backend.utils.exception.ErrorResp;
import com.citadel.backend.utils.exception.GeneralException;
import com.citadel.backend.utils.exception.MaintenanceException;
import com.citadel.backend.vo.GetMaintenanceRespVo;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.orm.hibernate5.HibernateSystemException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.transaction.CannotCreateTransactionException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import javax.security.auth.login.AccountExpiredException;
import java.sql.SQLException;

@ControllerAdvice
public class ApiExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler({Exception.class})
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public ResponseEntity<Object> handleAll(final Exception ex) {
        logger.error("Error", ex);
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getLocalizedMessage());
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler({GeneralException.class})
    @ResponseStatus(value = HttpStatus.FORBIDDEN)
    public ResponseEntity<Object> handleGeneralException(final Exception ex) {
        logger.error("Error", ex);
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getLocalizedMessage());
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler({SQLException.class,
            DataAccessException.class,
            HibernateSystemException.class,
            CannotCreateTransactionException.class,
            DataIntegrityViolationException.class})
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public ResponseEntity handleSQLException(final Exception ex) {
        logger.error("Error", ex);
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage("Data integrity violation");
        return new ResponseEntity<Object>(errorResp, new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler({BadCredentialsException.class,
            AccessDeniedException.class,
            AccountExpiredException.class,
            BadCredentialsException.class,
            DisabledException.class})
    @ResponseStatus(value = HttpStatus.UNAUTHORIZED)
    public ResponseEntity<Object> handleUnAuthenticationException(final Exception ex) {
        logger.error("Error", ex);
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getLocalizedMessage());
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.FORBIDDEN);
    }

    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex) {
        logger.error("Error", ex);
        ErrorResp errorResp = new ErrorResp();
        errorResp.setMessage(ex.getLocalizedMessage().replaceAll("\n", "").replaceAll("com.*", "***"));
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
//        logger.error("Validation Error", ex);

        JSONArray jsonArray = new JSONArray();
        ex.getBindingResult().getFieldErrors().forEach(error -> jsonArray.put(error.getObjectName() + "." + error.getField()));

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("error", "validation");
        jsonObject.put("fields", jsonArray);

        // Create response body with error details
        ErrorResp errorResp = new ErrorResp();
        errorResp.setCode(String.valueOf(HttpStatus.BAD_REQUEST.value()));
        errorResp.setMessage(jsonObject.toString());

        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler({MaintenanceException.class})
//    @ResponseStatus(value = HttpStatus.OK)
    public ResponseEntity<Object> handleMaintenance(final MaintenanceException ex) {
        logger.error("Error", ex);
        GetMaintenanceRespVo errorResp = new GetMaintenanceRespVo();
        errorResp.setCode(Constant.HttpCode.ERROR_EXCEPTION.getCode());
        errorResp.setMessage(ex.getMessage());
        errorResp.setStartDatetime(ex.getStartDatetime());
        errorResp.setEndDatetime(ex.getEndDatetime());
        return new ResponseEntity<>(errorResp, new HttpHeaders(), HttpStatus.OK);
    }
}