package pl.dmcs.devicebase.service;

import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.repository.AppUserRepository;

import java.util.List;

public interface AppUserService {
    public void addAppUser(AppUser user);
    public void editAppUser(AppUser user);
    public List<AppUser> listAppUser();
    public void removeAppUser(long id);
    public AppUser getAppUser(long id);
}
