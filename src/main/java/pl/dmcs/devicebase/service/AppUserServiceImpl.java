package pl.dmcs.devicebase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.repository.AppUserRepository;

import java.util.List;

@Service
public class AppUserServiceImpl implements AppUserService{

    private final AppUserRepository appUserRepository;

    @Autowired
    public AppUserServiceImpl(AppUserRepository appUserRepository) {
        this.appUserRepository = appUserRepository;
    }

    @Transactional
    @Override
    public void addAppUser(AppUser appUser) {
        appUserRepository.save(appUser);
    }

    @Transactional
    @Override
    public void editAppUser(AppUser appUser) {
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
}
