package pl.dmcs.devicebase.service;

import pl.dmcs.devicebase.domain.AppUser;
import java.util.List;

public interface AppUserService {
    void addAppUser(AppUser appUser);
    void editAppUser(AppUser appUser);
    List<AppUser> listAppUser();
    void removeAppUser(long id);
    AppUser getAppUser(long id);

    // New methods for uniqueness check
    boolean isLoginUnique(String login);
    boolean isEmailUnique(String email);
    boolean isPhoneNumberUnique(String phoneNumber);

    AppUser findByLogin(String login);
}
