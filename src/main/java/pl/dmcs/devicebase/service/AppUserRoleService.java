package pl.dmcs.devicebase.service;

import pl.dmcs.devicebase.domain.AppUserRole;

import java.util.List;

public interface AppUserRoleService {
    void addAppUserRole(AppUserRole appUserRole);
    List<AppUserRole> listAppUserRole();
    AppUserRole getAppUserRole(long id);
    void deleteUserRole(long id);
    void updateAppUserRole(AppUserRole appUserRole);
    AppUserRole findByRole(String role);

}
