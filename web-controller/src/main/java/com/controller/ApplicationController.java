package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
    public String startScript(Model model) throws IOException {
        String result = "";
        ProcessBuilder pb = new ProcessBuilder();
        try{
            pb.command("sh", "/vagrant/data/checkRasp.sh");
            pb.directory(new File(System.getProperty("user.home")));
            Process p = pb.start();
            try (var reader = new BufferedReader(
                    new InputStreamReader(p.getInputStream()))) {

                String line;

                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }

            }
            result = "success";
        }catch (Exception e){
            System.out.println("Le fichier spécifié est introuvable");
            result = "failure";
        }
        model.addAttribute("result", result);
        return "startRasp";
    }

    @GetMapping("/grafana")
    public String grafana(){
        return "grafana";
    }

    @GetMapping("/infra")
    public String infra(){return "homeInfra";}

    @PostMapping("/infra")
    public String stopInfra(Model model){
        String result = "";
        ProcessBuilder pb = new ProcessBuilder();
        try{
            pb.command("sh", "/vagrant/data/stopDocker.sh");
            pb.directory(new File(Paths.get("/vagrant/data").toString()));
            Process p = pb.start();
            try (var reader = new BufferedReader(
                    new InputStreamReader(p.getInputStream()))) {

                String line;

                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }

            }
            result = "success";
        }catch (Exception e){
            System.out.println("Le fichier spécifié est introuvable");
            result = "failure";
        }
        model.addAttribute("result", result);
        return "homeInfra";
    }

    @GetMapping("/infraweb")
    public String infraWeb(Model model){
        String result = "";
        List<List<String>> outputList = new ArrayList<>();
        ProcessBuilder pb = new ProcessBuilder();
        try{
            pb.command("docker", "ps");
            pb.directory(new File(Paths.get("/vagrant/data").toString()));
            Process p = pb.start();
            try (var reader = new BufferedReader(
                    new InputStreamReader(p.getInputStream()))) {

                String line;

                while ((line = reader.readLine()) != null) {
                    String[] lineSplit = line.split("( {2,})");
                    List<String> list = Arrays.asList(lineSplit);
                    list = list.stream().filter(s -> !s.isEmpty()).collect(Collectors.toList());
                    System.out.println(line);
                    System.out.println(list.get(5));
                    if(!list.get(0).equals("CONTAINER ID")){
                        outputList.add(list);
                    }
                }

            }
            result = "success";
        }catch (Exception e){
            System.out.println("Le fichier spécifié est introuvable");
            result = "failure";
        }
        model.addAttribute("outputList", outputList);
        model.addAttribute("result", result);
        return "webClients";
    }
}
