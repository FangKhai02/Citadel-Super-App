package com.citadel.backend.utils.Validators;

import com.citadel.backend.utils.CustomAnnotations.ValidEmploymentDetails;
import com.citadel.backend.utils.ValidatorUtil;
import com.citadel.backend.vo.SignUp.Client.EmploymentDetailsVo;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import org.json.JSONArray;

public class EmploymentDetailsValidator implements ConstraintValidator<ValidEmploymentDetails, EmploymentDetailsVo> {

    @Override
    public void initialize(ValidEmploymentDetails constraintAnnotation) {
    }

    @Override
    public boolean isValid(EmploymentDetailsVo signUpEmploymentDetails, ConstraintValidatorContext constraintValidatorContext) {
        JSONArray jsonArray = ValidatorUtil.employmentDetailsValidator(signUpEmploymentDetails);
        if (jsonArray.isEmpty()) {
            return true;
        } else {
            // Disable default constraint violations
            constraintValidatorContext.disableDefaultConstraintViolation();
            for (int i = 0; i < jsonArray.length(); i++) {
                String violation = jsonArray.getString(i);
                constraintValidatorContext.buildConstraintViolationWithTemplate(violation)
                        .addPropertyNode(getFieldNameFromViolation(violation)) // Add specific field name for the violation
                        .addConstraintViolation();
            }
            return false;
        }
    }
    // Helper method to extract the field name from the violation string
    private String getFieldNameFromViolation(String violation) {
        // Assuming the violation follows format: ClassName.fieldName
        String[] parts = violation.split("\\.");
        return parts.length > 1 ? parts[1] : parts[0];
    }
}
