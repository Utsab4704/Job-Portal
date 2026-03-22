package com.capgemini.training.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.capgemini.training.service.JobService;

@Controller
public class HomeController {

    private final JobService jobService;

    @Autowired
    public HomeController(JobService jobService) {
        this.jobService = jobService;
    }

    @GetMapping("/")
    public String home(Model model) {
        // Show latest 6 active jobs on the landing page
        model.addAttribute("recentJobs", jobService.getAllActiveJobs()
                .stream()
                .limit(6)
                .toList());
        return "home";
    }
}