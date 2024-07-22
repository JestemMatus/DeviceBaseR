package pl.dmcs.devicebase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.repository.AppUserRoleRepository;

import java.util.List;

@Service
public class AppUserRoleServiceImpl implements AppUserRoleService {

    private final AppUserRoleRepository appUserRoleRepository;

    @Autowired
    public AppUserRoleServiceImpl(AppUserRoleRepository appUserRoleRepository) {
        this.appUserRoleRepository = appUserRoleRepository;
    }

    @Transactional
    @Override
    public void addAppUserRole(AppUserRole appUserRole) {
        appUserRoleRepository.save(appUserRole);
    }

    @Transactional
    @Override
    public List<AppUserRole> listAppUserRole() {
        return appUserRoleRepository.findAll();
    }

    @Transactional
    @Override
    public AppUserRole getAppUserRole(long id) {
        return appUserRoleRepository.findById(id).orElse(null);
    }

    @Transactional
    @Override
    public void deleteUserRole(long id) {
        appUserRoleRepository.deleteById(id);
    }

    @Transactional
    @Override
    public void updateAppUserRole(AppUserRole appUserRole) {
        appUserRoleRepository.save(appUserRole);
    }

    @Transactional
    @Override
    public AppUserRole findByRole(String role) {
        return appUserRoleRepository.findByRole(role);
    }
}
