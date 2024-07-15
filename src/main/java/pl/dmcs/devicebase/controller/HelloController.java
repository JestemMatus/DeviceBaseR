package pl.dmcs.devicebase.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Locale;

@Controller
public class HelloController {

    @RequestMapping(value = "/")
    public String helloWorld() {
        return "hello";
    }
}
