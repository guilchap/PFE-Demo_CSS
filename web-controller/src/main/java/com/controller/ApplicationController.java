package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
public class ApplicationController {
    @GetMapping("/")
    public String home(){
        return "home";
    }

    @GetMapping("/produit")
    public String product() { return "product"; }

    @GetMapping("/etudiants")
    public String etudiants(){
        return "etudiants";
    }

    @GetMapping("/demo")
    public String demo(){
        return "homeDemo";
    }

    @GetMapping("/startRasp")
    public String startRasp(){
        return "startRasp";
    }

    @PostMapping("/startRasp")
    public void startScript() throws IOException {
        System.out.println("test");
        ProcessBuilder pb = new ProcessBuilder();
        pb.command("sh", "/vagrant/data/some.sh");
        pb.directory(new File(System.getProperty("user.home")));
        Process p = pb.start();
        try (var reader = new BufferedReader(
                new InputStreamReader(p.getInputStream()))) {

            String line;

            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

        }
    }

    @GetMapping("/grafana")
    public String grafana(){
        return "grafana";
    }

    @GetMapping("/infra")
    public String infra(){return "homeInfra";}

    @GetMapping("/infraweb")
    public String infraWeb(){return "webClients";}
}
