package pl.dmcs.devicebase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.domain.EndpointPermission;
import pl.dmcs.devicebase.domain.Endpoint;
import pl.dmcs.devicebase.service.AppUserRoleService;
import pl.dmcs.devicebase.service.PermissionService;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/permission-management")
public class PermissionManagementController {

    private final AppUserRoleService appUserRoleService;
    private final PermissionService permissionService;

    @Autowired
    public PermissionManagementController(AppUserRoleService appUserRoleService, PermissionService permissionService) {
        this.appUserRoleService = appUserRoleService;
        this.permissionService = permissionService;
    }

    @GetMapping
    public String showPermissionManagement(Model model, @RequestParam(required = false) Long roleId) {
        List<AppUserRole> roles = appUserRoleService.listAppUserRole();
        model.addAttribute("roles", roles);

        if (roleId != null) {
            AppUserRole role = appUserRoleService.getAppUserRole(roleId);
            List<EndpointPermission> permissions = permissionService.getPermissionsForRole(role.getRole());
            List<Endpoint> endpoints = permissionService.getAllEndpoints();
            List<Long> assignedEndpoints = permissions.stream()
                    .map(permission -> permission.getEndpoint().getId())
                    .collect(Collectors.toList());

            model.addAttribute("selectedRoleId", roleId);
            model.addAttribute("permissions", permissions);
            model.addAttribute("endpoints", endpoints);
            model.addAttribute("assignedEndpoints", assignedEndpoints);
        }

        model.addAttribute("endpointPermission", new EndpointPermission());
        return "permissionManagement";
    }

    @PostMapping("/update")
    public String updatePermissions(@RequestParam("roleId") Long roleId, @RequestParam(value = "endpointIds", required = false) List<Long> endpointIds) {
        if (endpointIds != null) {
            permissionService.updatePermissions(roleId, endpointIds);
        } else {
            permissionService.removeAllPermissionsForRole(roleId);
        }
        return "redirect:/permission-management?roleId=" + roleId;
    }
}
