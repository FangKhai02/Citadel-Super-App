package com.citadel.backend.utils.Validators;

import com.citadel.backend.utils.CustomAnnotations.ValidEmail;
import com.citadel.backend.utils.ValidatorUtil;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class EmailValidator implements ConstraintValidator<ValidEmail, String> {
    @Override
    public void initialize(ValidEmail constraintAnnotation) {
    }

    @Override
    public boolean isValid(String email, ConstraintValidatorContext context) {
        return ValidatorUtil.validEmail(email);
    }
}
