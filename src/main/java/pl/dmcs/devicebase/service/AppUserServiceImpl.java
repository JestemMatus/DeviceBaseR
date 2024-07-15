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
    public AppUserServiceImpl(AppUserRepository appUserRepository){this.appUserRepository = appUserRepository;}

    @Transactional
    public void addAppUser(AppUser appUser){appUserRepository.save(appUser);}

    @Transactional
    public void editAppUser(AppUser appUser){appUserRepository.save(appUser);}

    @Transactional
    public List<AppUser> listAppUser(){return appUserRepository.findAll();}

    @Transactional
    public void removeAppUser(long id){appUserRepository.deleteById(id);}

    @Transactional
    public AppUser getAppUser(long id){ return appUserRepository.findById(id);}
}
