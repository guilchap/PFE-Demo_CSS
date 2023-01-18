package com.etudiant.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Controller
public class ApplicationController {

    private int http = 10000;
    private int ssh = 6000;
    private int cpt = 1;

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

    @PostMapping("/infra")
    public String startScript(Model model) {
        System.out.println("entrée post");
        String result;
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
//            pb.command("docker", "ps", "-n", "1");
//            System.out.println(pb.command());
//            p = pb.start();
//            try (var reader = new BufferedReader(
//                    new InputStreamReader(p.getInputStream()))) {
//
//                String line;
//
//                while ((line = reader.readLine()) != null) {
//                    System.out.println(line);
//                }
//
//            }

            result = "success";
            http++;
            ssh++;
            cpt++;
        }catch (Exception e){
            System.out.println("Le fichier spécifié est introuvable");
            result = "failure";
        }
        if(result.equals("success")) {
            //traitement de la string renvoyé à la console
            int phttp = http - 1;
            int pssh = ssh - 1;
            model.addAttribute("result", result);
            model.addAttribute("phttp", phttp);
            model.addAttribute("pssh", pssh);
            return "exoInfra";
        } else {
            model.addAttribute("result", result);
            return "exoInfra";
        }
    }
}
