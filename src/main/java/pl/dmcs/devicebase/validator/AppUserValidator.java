package pl.dmcs.devicebase.validator;

import org.apache.commons.validator.routines.EmailValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.service.AppUserService;

import java.util.regex.Pattern;

@Component
public class AppUserValidator implements Validator {

    private final AppUserService appUserService;

    @Autowired
    public AppUserValidator(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    private final EmailValidator emailValidator = EmailValidator.getInstance();
    private final String phonePattern = "\\d{3} \\d{3} \\d{3}";
    private final String combinedPasswordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\\$%\\^&\\*])(?=.*\\d).{8,}$";

    @Override
    public boolean supports(Class<?> clazz) {
        return AppUser.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "firstName", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "lastName", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "email", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "login", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "department", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "workplace", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "password", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "phoneNumber", "error.field.required");

        AppUser appUser = (AppUser) target;

        // Walidacja email
        if (StringUtils.hasText(appUser.getEmail()) && !emailValidator.isValid(appUser.getEmail())) {
            errors.rejectValue("email", "error.email.invalid");
        } else if (!appUserService.isEmailUnique(appUser.getEmail())) {
            errors.rejectValue("email", "error.email.exists");
        }

        // Walidacja loginu
        if (!appUserService.isLoginUnique(appUser.getLogin())) {
            errors.rejectValue("login", "error.login.exists");
        }

        // Walidacja numeru telefonu
        if (StringUtils.hasText(appUser.getPhoneNumber()) && !Pattern.matches(phonePattern, appUser.getPhoneNumber())) {
            errors.rejectValue("phoneNumber", "error.telephone.invalid");
        } else if (!appUserService.isPhoneNumberUnique(appUser.getPhoneNumber())) {
            errors.rejectValue("phoneNumber", "error.telephone.exists");
        }

        if (StringUtils.hasText(appUser.getPassword()) && !Pattern.matches(combinedPasswordPattern, appUser.getPassword())) {
            errors.rejectValue("password", "error.password.invalid");
        }
    }

}
