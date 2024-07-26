package pl.dmcs.devicebase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pl.dmcs.devicebase.domain.EndpointPermission;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.domain.Endpoint;
import pl.dmcs.devicebase.repository.EndpointPermissionRepository;
import pl.dmcs.devicebase.repository.AppUserRoleRepository;
import pl.dmcs.devicebase.repository.EndpointRepository;
import pl.dmcs.devicebase.service.PermissionService;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class PermissionServiceImpl implements PermissionService {

    private final EndpointPermissionRepository endpointPermissionRepository;
    private final AppUserRoleRepository appUserRoleRepository;
    private final EndpointRepository endpointRepository;

    @Autowired
    public PermissionServiceImpl(EndpointPermissionRepository endpointPermissionRepository, AppUserRoleRepository appUserRoleRepository, EndpointRepository endpointRepository) {
        this.endpointPermissionRepository = endpointPermissionRepository;
        this.appUserRoleRepository = appUserRoleRepository;
        this.endpointRepository = endpointRepository;
    }

    @Override
    public List<EndpointPermission> getAllPermissions() {
        return endpointPermissionRepository.findAll();
    }

    @Override
    @Transactional
    public void addPermission(Long endpointId, Long roleId) {
        AppUserRole appUserRole = appUserRoleRepository.findById(roleId).orElse(null);
        Endpoint endpoint = endpointRepository.findById(endpointId).orElse(null);
        if (appUserRole != null && endpoint != null) {
            EndpointPermission permission = new EndpointPermission();
            permission.setEndpoint(endpoint);
            permission.setRole(appUserRole);
            endpointPermissionRepository.save(permission);
        }
    }

    @Override
    @Transactional
    public void removePermission(Long id) {
        endpointPermissionRepository.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<EndpointPermission> getPermissionsForRole(String role) {
        return endpointPermissionRepository.findByRole_Role(role);
    }

    @Override
    @Transactional
    public void updatePermissions(Long roleId, List<Long> endpointIds) {
        AppUserRole appUserRole = appUserRoleRepository.findById(roleId).orElse(null);
        if (appUserRole != null) {
            List<EndpointPermission> currentPermissions = endpointPermissionRepository.findByRole_Role(appUserRole.getRole());
            List<Long> currentEndpointIds = currentPermissions.stream()
                    .map(permission -> permission.getEndpoint().getId())
                    .collect(Collectors.toList());

            // Remove permissions not in the new endpointIds list
            for (EndpointPermission permission : currentPermissions) {
                if (!endpointIds.contains(permission.getEndpoint().getId())) {
                    endpointPermissionRepository.delete(permission);
                }
            }

            // Add new permissions
            for (Long endpointId : endpointIds) {
                if (!currentEndpointIds.contains(endpointId)) {
                    Endpoint endpoint = endpointRepository.findById(endpointId).orElse(null);
                    if (endpoint != null) {
                        EndpointPermission permission = new EndpointPermission();
                        permission.setEndpoint(endpoint);
                        permission.setRole(appUserRole);
                        endpointPermissionRepository.save(permission);
                    }
                }
            }
        }
    }

    @Override
    @Transactional
    public void removeAllPermissionsForRole(Long roleId) {
        AppUserRole appUserRole = appUserRoleRepository.findById(roleId).orElse(null);
        if (appUserRole != null) {
            endpointPermissionRepository.deleteByRole(appUserRole);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Endpoint> getAllEndpoints() {
        return endpointRepository.findAll();
    }
}
