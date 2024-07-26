package pl.dmcs.devicebase.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.domain.EndpointPermission;

import java.util.List;

public interface EndpointPermissionRepository extends JpaRepository<EndpointPermission, Long> {
    List<EndpointPermission> findByRole_Role(String role);
    void deleteByRole(AppUserRole role);
}
