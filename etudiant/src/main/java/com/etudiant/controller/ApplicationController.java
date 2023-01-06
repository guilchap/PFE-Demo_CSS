package com.etudiant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ApplicationController {
    @GetMapping("/")
    public String home(){
        return "accueil";
    }

    @GetMapping("/infra")
    public String infra(){
        return "exoInfra";
    }

    @GetMapping("/doc")
    public String doc(){
        return "instructions";
    }
}
