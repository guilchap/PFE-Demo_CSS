package com.etudiant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
public class ApplicationController {

    int http = 10000;
    int ssh = 6000;
    int cpt = 1;

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

    @GetMapping("/infoDocker")
    public String startScript() throws IOException {
        ProcessBuilder pb = new ProcessBuilder();
        try{
            pb.command("docker", "run", "-d", "-p", http+":80", "-p", ssh+":22", "--name", "conteneur"+cpt, "infra");
            System.out.println(pb.command());
            pb.directory(new File(System.getProperty("user.home")));
            Process p = pb.start();
            try (var reader = new BufferedReader(
                    new InputStreamReader(p.getInputStream()))) {

                String line;

                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }

            }
            http++;
            ssh++;
            cpt++;
        }catch (Exception e){
            System.out.println("Le fichier spécifié est introuvable");
        }
        return "infosDocker";
    }
}
