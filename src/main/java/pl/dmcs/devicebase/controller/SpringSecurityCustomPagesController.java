package pl.dmcs.devicebase.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SpringSecurityCustomPagesController {

    @RequestMapping(value = "/login")
    public String customLogin(@RequestParam(value="error", required=false) String error,
                              @RequestParam(value = "logout", required = false) String logout,
                              Model model){
        if (error != null){
            model.addAttribute("error", "Niepoprawne dane uwierzytelniające");
        }
        if (logout != null){
            model.addAttribute("msg", "Zalogowano poprawnie")   ;
        }
        return "login";
    }

    @RequestMapping(value = "/accessDenied")
    public String accessDenied(){
        return "accessDenied";
    }
}
