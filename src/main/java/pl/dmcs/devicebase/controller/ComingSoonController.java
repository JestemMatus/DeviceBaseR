package pl.dmcs.devicebase.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ComingSoonController {

    @RequestMapping(value = "/ComingSoon")
    public String comingSoon() {
        return "ComingSoon";
    }
}