package pl.dmcs.devicebase.validator;

import org.apache.commons.validator.routines.EmailValidator;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import pl.dmcs.devicebase.domain.AppUser;

import java.util.regex.Pattern;

public class AppUserValidator implements Validator {

    private final EmailValidator emailValidator = EmailValidator.getInstance();

    private final String phonePattern = "\\+48 \\d{3} \\d{3} \\d{3}";
    private final String combinedPasswordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\\$%\\^&\\*])(?=.*\\d).{8,}$";

    @Override
    public boolean supports(Class<?> clazz) {
        return AppUser.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "firstName", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "lastName", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "telephoneNumber", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "email", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "login", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "department", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "workplace", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "password", "error.field.required");

        AppUser appUser = (AppUser) target;

        if (errors.getErrorCount() == 0) {
            if (StringUtils.hasText(appUser.getEmail()) && !emailValidator.isValid(appUser.getEmail())) {
                errors.rejectValue("email", "error.email.invalid");
            }

            if (StringUtils.hasText(appUser.getTelephoneNumber()) && !Pattern.matches(phonePattern, appUser.getTelephoneNumber())) {
                errors.rejectValue("telephoneNumber", "error.telephone.invalid");
            }

            if (StringUtils.hasText(appUser.getPassword()) && !Pattern.matches(combinedPasswordPattern, appUser.getPassword())) {
                errors.rejectValue("password", "error.password.invalid");
            }
        }
    }
}
