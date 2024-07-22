package pl.dmcs.devicebase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.repository.AppUserRepository;
import pl.dmcs.devicebase.repository.AppUserRoleRepository;

import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService{

    private final AppUserRepository appUserRepository;
    private final AppUserRoleRepository appUserRoleRepository;
    private PasswordEncoder passwordEncoder;

    @Autowired
    public AppUserServiceImpl(AppUserRepository appUserRepository, AppUserRoleRepository appUserRoleRepository, PasswordEncoder passwordEncoder) {

        this.appUserRepository = appUserRepository;
        this.appUserRoleRepository = appUserRoleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public void addAppUser(AppUser appUser) {
        appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUser.setIsEnabled(false);
        appUserRepository.save(appUser);

        AppUserRole userRole = appUserRoleRepository.findByRole("ROLE_USER");
        if (userRole != null && !appUser.getAppUserRole().contains(userRole)) {
            appUser.getAppUserRole().add(userRole);
            appUserRepository.save(appUser);
        }
    }

    @Transactional
    @Override
    public void editAppUser(AppUser appUser) {
        appUser.getAppUserRole().add(appUserRoleRepository.findByRole("ROLE_USER"));
        appUser.setPassword(passwordEncoder.encode(appUser.getPassword()));
        appUserRepository.save(appUser);
    }

    @Transactional
    @Override
    public List<AppUser> listAppUser() {
        return appUserRepository.findAll();
    }

    @Transactional
    @Override
    public void removeAppUser(long id) {
        appUserRepository.deleteById(id);
    }

    @Transactional
    @Override
    public AppUser getAppUser(long id) {
        return appUserRepository.findById(id); // No need for .orElse(null) since it's not an Optional
    }

    @Transactional
    @Override
    public boolean isLoginUnique(String login) {
        return appUserRepository.findByLogin(login) == null;
    }

    @Transactional
    @Override
    public boolean isEmailUnique(String email) {
        return appUserRepository.findByEmail(email) == null;
    }

    @Transactional
    @Override
    public boolean isPhoneNumberUnique(String phoneNumber) {
        return appUserRepository.findByPhoneNumber(phoneNumber) == null;
    }

    @Transactional
    public AppUser findByLogin(String login) {
        return appUserRepository.findByLogin(login);
    }

}
