package pl.dmcs.devicebase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.devicebase.domain.EndpointPermission;
import pl.dmcs.devicebase.service.PermissionService;

@RestController
@RequestMapping("/permissions")
public class PermissionController {

    private final PermissionService permissionService;

    @Autowired
    public PermissionController(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    @PostMapping
    public void addPermission(@RequestParam Long endpointId, @RequestParam Long roleId) {
        permissionService.addPermission(endpointId, roleId);
    }

    @DeleteMapping("/{id}")
    public void removePermission(@PathVariable Long id) {
        permissionService.removePermission(id);
    }
}
