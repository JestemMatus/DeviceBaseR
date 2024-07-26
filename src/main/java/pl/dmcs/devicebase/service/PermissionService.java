package pl.dmcs.devicebase.service;

import pl.dmcs.devicebase.domain.EndpointPermission;
import pl.dmcs.devicebase.domain.Endpoint;

import java.util.List;

public interface PermissionService {
    List<EndpointPermission> getAllPermissions();
    void addPermission(Long endpointId, Long roleId);
    void removePermission(Long id);
    List<EndpointPermission> getPermissionsForRole(String role);
    void updatePermissions(Long roleId, List<Long> endpointIds);
    void removeAllPermissionsForRole(Long roleId);
    List<Endpoint> getAllEndpoints();
}
