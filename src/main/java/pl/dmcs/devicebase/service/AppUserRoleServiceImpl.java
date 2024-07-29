package pl.dmcs.devicebase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.repository.AppUserRepository;
import pl.dmcs.devicebase.repository.AppUserRoleRepository;

import java.util.List;

@Service
public class AppUserRoleServiceImpl implements AppUserRoleService {

    private final AppUserRoleRepository appUserRoleRepository;
    private final AppUserRepository appUserRepository;

    @Autowired
    public AppUserRoleServiceImpl(AppUserRoleRepository appUserRoleRepository, AppUserRepository appUserRepository) {
        this.appUserRoleRepository = appUserRoleRepository;
        this.appUserRepository = appUserRepository;
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
        AppUserRole role = appUserRoleRepository.findById(id).orElse(null);
        if (role != null) {
            List<AppUser> usersWithRole = appUserRepository.findAll().stream()
                    .filter(user -> user.getAppUserRole().contains(role))
                    .toList();
            if (!usersWithRole.isEmpty()) {
                throw new IllegalArgumentException("Nie można usunąć roli, ponieważ jest przypisana do jednego lub więcej użytkowników.");
            }
            appUserRoleRepository.delete(role);
        }
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
