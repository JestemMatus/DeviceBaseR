package pl.dmcs.devicebase.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import pl.dmcs.devicebase.domain.AppUser;
import pl.dmcs.devicebase.service.AppUserService;
import pl.dmcs.devicebase.validator.AppUserValidator;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class AppUserController {

    private final AppUserValidator appUserValidator = new AppUserValidator();
    private final AppUserService appUserService;

    @Autowired
    public AppUserController(AppUserService appUserService) {
        this.appUserService = appUserService;
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
        System.out.println("Dodano usera " + appUser.getLogin());

        appUserValidator.validate(appUser, result);

        if (result.getErrorCount() == 0) {

            if (appUser.getId() == 0)
                appUserService.addAppUser(appUser);
            return "redirect:/welcome?firstName=" + appUser.getFirstName();
        }
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

    @RequestMapping(value = "/users", method = RequestMethod.GET)
    public String showAllUsers(Model model,
                               @RequestParam Map<String, String> allParams) {

        List<AppUser> users = appUserService.listAppUser();

        // Filtrowanie
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
                    }
                }
                return matches;
            }).collect(Collectors.toList());
        }

        // Sortowanie
        String sortField = allParams.get("sortField");
        String sortDir = allParams.get("sortDir");
        if (sortField != null && sortDir != null) {
            Comparator<AppUser> comparator;
            switch (sortField) {
                case "login": comparator = Comparator.comparing(AppUser::getLogin); break;
                case "firstName": comparator = Comparator.comparing(AppUser::getFirstName); break;
                case "lastName": comparator = Comparator.comparing(AppUser::getLastName); break;
                case "email": comparator = Comparator.comparing(AppUser::getEmail); break;
                case "telephoneNumber": comparator = Comparator.comparing(AppUser::getTelephoneNumber); break;
                case "department": comparator = Comparator.comparing(AppUser::getDepartment); break;
                case "workplace": comparator = Comparator.comparing(AppUser::getWorkplace); break;
                default: comparator = Comparator.comparing(AppUser::getId);
            }
            if ("desc".equalsIgnoreCase(sortDir)) {
                comparator = comparator.reversed();
            }
            users = users.stream().sorted(comparator).collect(Collectors.toList());
        }

        model.addAttribute("users", users);
        return "users";
    }

    @RequestMapping(value = "/edit/{appUserId}", method = RequestMethod.GET)
    public String editUser(@PathVariable("appUserId") Long appUserId) {
        // Przyszła logika edycji użytkownika
        return "redirect:/users";
    }

    @RequestMapping(value = "/approve/{appUserId}", method = RequestMethod.GET)
    public String approveUser(@PathVariable("appUserId") Long appUserId) {
        // Przyszła logika zatwierdzania użytkownika
        return "redirect:/users";
    }

    @RequestMapping(value = "/assignRole/{appUserId}", method = RequestMethod.GET)
    public String assignRoleToUser(@PathVariable("appUserId") Long appUserId) {
        // Przyszła logika przydzielania roli użytkownikowi
        return "redirect:/users";
    }
}
