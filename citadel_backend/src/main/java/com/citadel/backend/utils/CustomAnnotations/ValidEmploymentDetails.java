package com.citadel.backend.utils.CustomAnnotations;

import com.citadel.backend.utils.Validators.EmploymentDetailsValidator;
import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = EmploymentDetailsValidator.class)
@Target({ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidEmploymentDetails {
    String message() default "Invalid employment details";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}
