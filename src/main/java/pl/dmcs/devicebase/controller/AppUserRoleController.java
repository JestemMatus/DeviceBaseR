package pl.dmcs.devicebase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.service.AppUserRoleService;

import java.util.List;

@Controller
public class AppUserRoleController {

    private final AppUserRoleService appUserRoleService;

    @Autowired
    public AppUserRoleController(AppUserRoleService appUserRoleService) {
        this.appUserRoleService = appUserRoleService;
    }

    @RequestMapping(value = "/appUserRole", method = RequestMethod.GET)
    public String showUserRole(Model model) {
        List<AppUserRole> roles = appUserRoleService.listAppUserRole();
        model.addAttribute("appUserRole", new AppUserRole());
        model.addAttribute("roles", roles);
        return "appUserRole";
    }

    @RequestMapping(value = "/addAppUserRole", method = RequestMethod.POST)
    public String addUserRole(@ModelAttribute("appUserRole") AppUserRole appUserRole) {
        appUserRoleService.addAppUserRole(appUserRole);
        return "redirect:/appUserRole";
    }

    @RequestMapping(value = "/deleteRole/{roleId}", method = RequestMethod.GET)
    public String deleteUserRole(@PathVariable("roleId") long roleId, Model model) {
        try {
            appUserRoleService.deleteUserRole(roleId);
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/appUserRole";
    }

    @RequestMapping(value = "/updateRole", method = RequestMethod.POST)
    public String updateUserRole(@RequestParam("role") String role, @RequestParam("newRole") String newRole, Model model) {
        try {
            AppUserRole appUserRole = appUserRoleService.findByRole(role);
            if (appUserRole != null) {
                appUserRole.setRole(newRole);
                appUserRoleService.updateAppUserRole(appUserRole);
            }
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }
        return "redirect:/appUserRole";
    }
}

