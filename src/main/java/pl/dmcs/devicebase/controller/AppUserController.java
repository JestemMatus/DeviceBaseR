package pl.dmcs.devicebase.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.domain.AppUserRole;
import pl.dmcs.devicebase.domain.Department;
import pl.dmcs.devicebase.service.AppUserRoleService;
import pl.dmcs.devicebase.service.AppUserService;
import pl.dmcs.devicebase.service.DepartmentService;
import pl.dmcs.devicebase.validator.AppUserValidator;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
public class AppUserController {

    private final AppUserValidator appUserValidator;
    private final AppUserService appUserService;
    private final AppUserRoleService appUserRoleService;
    private final PasswordEncoder passwordEncoder;
    private final DepartmentService departmentService;

    @Autowired
    public AppUserController(AppUserService appUserService, AppUserValidator appUserValidator, AppUserRoleService appUserRoleService, PasswordEncoder passwordEncoder, DepartmentService departmentService) {
        this.appUserService = appUserService;
        this.appUserValidator = appUserValidator;
        this.appUserRoleService = appUserRoleService;
        this.passwordEncoder = passwordEncoder;
        this.departmentService = departmentService;
    }

    @RequestMapping(value = "/register")
    public String showAppUsers(Model model, HttpServletRequest request) {
        int appUserId = ServletRequestUtils.getIntParameter(request, "appUserId", -1);

        if (appUserId > 0) {
            model.addAttribute("register", appUserService.getAppUser(appUserId));
        } else {
            model.addAttribute("register", new AppUser());
        }
        model.addAttribute("appUserList", appUserService.listAppUser());
        return "register";
    }

    @RequestMapping(value = "/addAppUser", method = RequestMethod.POST)
    public String addAppUser(@Valid @ModelAttribute("register") AppUser appUser, BindingResult result, Model model) {
        appUserValidator.validate(appUser, result);

        if (result.getErrorCount() == 0) {
            if (appUser.getId() == 0) {
                appUserService.addAppUser(appUser);
            }
            return "redirect:/welcome?firstName=" + appUser.getFirstName();
        }

        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments); // Dodanie listy działów do modelu
        model.addAttribute("appUserList", appUserService.listAppUser());
        return "register";
    }

    @RequestMapping("/delete/{appUserId}")
    public String deleteUser(@PathVariable("appUserId") Long appUserId) {
        appUserService.removeAppUser(appUserId);
        return "redirect:/users";
    }

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String welcomePage(Model model, @RequestParam("firstName") String firstName) {
        System.out.println("First Name: " + firstName);
        model.addAttribute("firstName", firstName);
        return "welcome";
    }

    @GetMapping("/users")
    public String showAllUsers(Model model, @RequestParam Map<String, String> allParams) {
        List<AppUser> users = appUserService.listAppUser();
        List<Department> departments = departmentService.findAll();

        if (!allParams.isEmpty()) {
            users = users.stream().filter(user -> {
                boolean matches = true;
                for (Map.Entry<String, String> entry : allParams.entrySet()) {
                    String key = entry.getKey();
                    String value = entry.getValue().toLowerCase();
                    switch (key) {
                        case "login": matches &= user.getLogin() != null && user.getLogin().toLowerCase().contains(value); break;
                        case "firstName": matches &= user.getFirstName() != null && user.getFirstName().toLowerCase().contains(value); break;
                        case "lastName": matches &= user.getLastName() != null && user.getLastName().toLowerCase().contains(value); break;
                        case "email": matches &= user.getEmail() != null && user.getEmail().toLowerCase().contains(value); break;
                        case "telephoneNumber": matches &= user.getTelephoneNumber() != null && user.getTelephoneNumber().toLowerCase().contains(value); break;
                        case "department": matches &= user.getDepartment() != null && user.getDepartment().toLowerCase().contains(value); break;
                        case "workplace": matches &= user.getWorkplace() != null && user.getWorkplace().toLowerCase().contains(value); break;
                        case "isEnabled":
                            boolean isEnabled = Boolean.parseBoolean(value);
                            matches &= user.isEnabled() == isEnabled;
                            break;
                    }
                }
                return matches;
            }).collect(Collectors.toList());
        }

        model.addAttribute("users", users);
        model.addAttribute("departments", departments);
        return "users";
    }

    @GetMapping("/editUser/{userId}")
    public String showEditUserForm(@PathVariable("userId") long userId, Model model) {
        AppUser user = appUserService.getAppUser(userId);
        List<Department> departments = departmentService.findAll();
        model.addAttribute("userForm", user);
        model.addAttribute("departments", departments);
        model.addAttribute("saveUrl", "/editUser/" + userId); // Dodanie poprawnego URL do przesyłania formularza
        return "editUser";
    }

    @PostMapping("/editUser/{id}")
    public String updateUser(@PathVariable("id") long id, @ModelAttribute("userForm") AppUser userForm, BindingResult result, Model model) {

        AppUser existingUser = appUserService.getAppUser(id);
        if (existingUser == null) {
            result.rejectValue("id", "error.user", "User not found");
            List<Department> departments = departmentService.findAll();
            model.addAttribute("departments", departments);
            return "editUser";
        }

        if (!existingUser.getLogin().equals(userForm.getLogin()) && !appUserService.isLoginUnique(userForm.getLogin())) {
            result.rejectValue("login", "error.user", "Login is already in use");
        }

        if (!existingUser.getEmail().equals(userForm.getEmail()) && !appUserService.isEmailUnique(userForm.getEmail())) {
            result.rejectValue("email", "error.user", "Email is already in use");
        }

        String newPhoneNumber = userForm.getPhonePrefix() + " " + userForm.getPhoneNumber();
        if (!existingUser.getTelephoneNumber().equals(newPhoneNumber) && !appUserService.isPhoneNumberUnique(newPhoneNumber)) {
            result.rejectValue("telephoneNumber", "error.user", "Phone number is already in use");
        }

        if (result.hasErrors()) {
            List<Department> departments = departmentService.findAll();
            model.addAttribute("departments", departments);
            return "editUser";
        }
        userForm.setPassword(existingUser.getPassword());

        existingUser.setPhonePrefix(userForm.getPhonePrefix());
        existingUser.setPhoneNumber(userForm.getPhoneNumber());

        existingUser.setFirstName(userForm.getFirstName());
        existingUser.setLastName(userForm.getLastName());
        existingUser.setEmail(userForm.getEmail());
        existingUser.setLogin(userForm.getLogin());
        existingUser.setDepartment(userForm.getDepartment());
        existingUser.setWorkplace(userForm.getWorkplace());

        appUserService.editAppUser(existingUser);
        return "redirect:/users";
    }



    @RequestMapping(value = "/approve/{appUserId}", method = RequestMethod.GET)
    public String approveUser(@PathVariable("appUserId") Long appUserId) {
        AppUser appUser = appUserService.getAppUser(appUserId);
        if (appUser != null) {
            appUser.setIsEnabled(true);
            appUserService.editAppUser(appUser);
        }
        return "redirect:/users";
    }

    @RequestMapping(value = "/deactivate/{appUserId}", method = RequestMethod.GET)
    public String deactivateUser(@PathVariable("appUserId") Long appUserId) {
        AppUser appUser = appUserService.getAppUser(appUserId);
        if (appUser != null) {
            appUser.setIsEnabled(false);
            appUserService.editAppUser(appUser);
        }
        return "redirect:/users";
    }

    @RequestMapping(value = "/usersRoles", method = RequestMethod.GET)
    public String showUsersRoles(Model model) {
        List<AppUser> users = appUserService.listAppUser();
        List<AppUserRole> allRoles = appUserRoleService.listAppUserRole();
        model.addAttribute("users", users);
        model.addAttribute("allRoles", allRoles);
        return "usersRoles";
    }

    @RequestMapping(value = "/assignRole/{appUserId}", method = RequestMethod.GET)
    public String showAssignRolePage(@PathVariable("appUserId") Long appUserId, Model model) {
        AppUser appUser = appUserService.getAppUser(appUserId);
        List<AppUserRole> allRoles = appUserRoleService.listAppUserRole();
        model.addAttribute("user", appUser);
        model.addAttribute("allRoles", allRoles);
        return "assignRole";
    }

    @RequestMapping(value = "/updateUserRoles", method = RequestMethod.POST)
    public String updateUserRoles(@RequestParam("userId") Long userId, @RequestParam("roles") List<Long> roleIds) {
        AppUser appUser = appUserService.getAppUser(userId);
        Set<AppUserRole> roles = roleIds.stream()
                .map(appUserRoleService::getAppUserRole)
                .collect(Collectors.toSet());
        appUser.setAppUserRole(roles);
        appUserService.editAppUser(appUser);
        return "redirect:/usersRoles";
    }

    @GetMapping("/profile")
    public String userProfile(Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);
        Set<AppUserRole> userRoles = currentUser.getAppUserRole();
        List<Department> departments = departmentService.findAll();

        model.addAttribute("user", currentUser);
        model.addAttribute("userRoles", userRoles);
        model.addAttribute("emailForm", new AppUser());
        model.addAttribute("loginForm", new AppUser());
        model.addAttribute("phoneForm", new AppUser());
        model.addAttribute("departmentForm", new AppUser());
        model.addAttribute("workplaceForm", new AppUser());
        model.addAttribute("departments", departments);

        return "profile";
    }

    @PostMapping("/editDepartment")
    public String editDepartment(@RequestParam("department") String department, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        currentUser.setDepartment(department);
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }

    @PostMapping("/editWorkplace")
    public String editWorkplace(@RequestParam("workplace") String workplace, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        currentUser.setWorkplace(workplace);
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }

    @GetMapping("/changeUserPassword/{userId}")
    public String showChangeUserPasswordPage(@PathVariable("userId") Long userId, Model model) {
        AppUser user = appUserService.getAppUser(userId);
        model.addAttribute("user", user);
        return "changeUserPassword";
    }

    @PostMapping("/changeUserPassword/{userId}")
    public String changeUserPassword(@PathVariable("userId") Long userId,
                                     @RequestParam("newPassword") String newPassword,
                                     Model model) {
        AppUser user = appUserService.getAppUser(userId);

        String passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\\$%\\^&\\*])(?=.*\\d).{8,}$";
        if (!newPassword.matches(passwordPattern)) {
            model.addAttribute("error", "Hasło musi mieć co najmniej 8 znaków, zawierać jedną wielką literę, jedną małą literę, jedną cyfrę i jeden znak specjalny.");
            model.addAttribute("user", user);
            return "changeUserPassword";
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        appUserService.editAppUser(user);
        return "redirect:/users";
    }


    @GetMapping("/changePassword")
    public String showChangePasswordPage() {
        return "changePassword";
    }

    @PostMapping("/changePassword")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        if (!passwordEncoder.matches(oldPassword, currentUser.getPassword())) {
            model.addAttribute("error", "Stare hasło jest nieprawidłowe.");
            return "changePassword";
        }

        String passwordPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\\$%\\^&\\*])(?=.*\\d).{8,}$";
        if (!newPassword.matches(passwordPattern)) {
            model.addAttribute("error", "Hasło musi mieć co najmniej 8 znaków, zawierać jedną wielką literę, jedną małą literę, jedną cyfrę i jeden znak specjalny.");
            return "changePassword";
        }

        currentUser.setPassword(passwordEncoder.encode(newPassword));
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments);
        model.addAttribute("register", new AppUser());
        return "register";
    }

    @PostMapping("/editLogin")
    public String editLogin(@RequestParam("login") String login, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        if (appUserService.findByLogin(login) != null) {
            model.addAttribute("error", "Login już istnieje.");
            return "profile";
        }

        currentUser.setLogin(login);
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }

    @PostMapping("/editEmail")
    public String editEmail(@RequestParam("email") String email, Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        if (appUserService.findByEmail(email) != null) {
            model.addAttribute("error", "Email już istnieje.");
            return "profile";
        }

        currentUser.setEmail(email);
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }

    @PostMapping("/editPhoneNumber")
    public String editPhoneNumber(@RequestParam("phonePrefix") String phonePrefix,
                                  @RequestParam("phoneNumber") String phoneNumber,
                                  Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String currentUserName = authentication.getName();
        AppUser currentUser = appUserService.findByLogin(currentUserName);

        if (appUserService.findByTelephoneNumber(phonePrefix + " " + phoneNumber) != null) {
            model.addAttribute("error", "Numer telefonu już istnieje.");
            return "profile";
        }

        currentUser.setPhonePrefix(phonePrefix);
        currentUser.setPhoneNumber(phoneNumber);
        appUserService.editAppUser(currentUser);
        return "redirect:/profile";
    }
}
