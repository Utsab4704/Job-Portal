package com.capgemini.training.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.capgemini.training.entity.JobSeeker;
import com.capgemini.training.service.JobApplicationService;
import com.capgemini.training.service.JobSeekerService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/seekers")
public class JobSeekerController {

    private final JobSeekerService seekerService;
    private final JobApplicationService applicationService;

    @Autowired
    public JobSeekerController(JobSeekerService seekerService,
                               JobApplicationService applicationService) {
        this.seekerService = seekerService;
        this.applicationService = applicationService;
    }

    // ─── SHOW REGISTRATION FORM ─────────────────────────────────────────────────

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("jobSeeker", new JobSeeker());
        return "jobseeker/register";
    }

    // ─── HANDLE REGISTRATION ────────────────────────────────────────────────────

    @PostMapping("/register")
    public String register(
            @Valid @ModelAttribute("jobSeeker") JobSeeker jobSeeker,
            BindingResult result,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            return "jobseeker/register";
        }

        try {
            seekerService.register(jobSeeker);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Registration successful! Please log in.");
            return "redirect:/seekers/login";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/seekers/register";
        }
    }

    // ─── SHOW LOGIN FORM ────────────────────────────────────────────────────────

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("jobSeeker", new JobSeeker());
        return "jobseeker/login";
    }

    // ─── HANDLE LOGIN ───────────────────────────────────────────────────────────

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            JobSeeker seeker = seekerService.getByEmail(email);

            if (!seekerService.checkPassword(password, seeker.getPassword())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid credentials");
                return "redirect:/seekers/login";
            }

            session.setAttribute("loggedInSeeker", seeker);
            session.setAttribute("userType", "SEEKER");
            return "redirect:/seekers/dashboard";

        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Email not found");
            return "redirect:/seekers/login";
        }
    }

    // ─── DASHBOARD ──────────────────────────────────────────────────────────────

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model,
                            RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (seeker == null) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Please log in first");
            return "redirect:/seekers/login";
        }

        // Refresh from DB in case profile was updated
        seeker = seekerService.getById(seeker.getId());
        model.addAttribute("seeker", seeker);
        model.addAttribute("applications",
                applicationService.getApplicationsBySeeker(seeker.getId()));
        return "jobseeker/dashboard";
    }

    // ─── SHOW EDIT PROFILE FORM ─────────────────────────────────────────────────

    @GetMapping("/edit")
    public String showEditForm(HttpSession session, Model model,
                               RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (seeker == null) {
            return "redirect:/seekers/login";
        }

        model.addAttribute("jobSeeker", seekerService.getById(seeker.getId()));
        return "jobseeker/edit";
    }

    // ─── HANDLE PROFILE UPDATE ──────────────────────────────────────────────────

    @PostMapping("/edit")
    public String updateProfile(
            @Valid @ModelAttribute("jobSeeker") JobSeeker updatedData,
            BindingResult result,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        JobSeeker loggedIn = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (loggedIn == null) {
            return "redirect:/seekers/login";
        }

        if (result.hasErrors()) {
            return "jobseeker/edit";
        }

        try {
            JobSeeker updated = seekerService.updateProfile(loggedIn.getId(), updatedData);
            session.setAttribute("loggedInSeeker", updated);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Profile updated!");
            return "redirect:/seekers/dashboard";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/seekers/edit";
        }
    }

    // ─── APPLY TO JOB ────────────────────────────────────────────────────────────

    @PostMapping("/apply/{jobId}")
    public String applyToJob(
            @PathVariable Long jobId,
            @RequestParam(required = false) String coverLetter,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        JobSeeker seeker = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (seeker == null) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Please log in to apply");
            return "redirect:/seekers/login";
        }

        try {
            applicationService.apply(seeker.getId(), jobId, coverLetter);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Application submitted successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/jobs/" + jobId;
    }

    // ─── WITHDRAW APPLICATION ────────────────────────────────────────────────────

    @PostMapping("/withdraw/{jobId}")
    public String withdraw(@PathVariable Long jobId, HttpSession session,
                           RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (seeker == null) {
            return "redirect:/seekers/login";
        }

        try {
            applicationService.withdraw(seeker.getId(), jobId);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Application withdrawn");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/seekers/dashboard";
    }

    // ─── DELETE ACCOUNT ──────────────────────────────────────────────────────────

    @PostMapping("/delete")
    public String deleteAccount(HttpSession session,
                                RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("loggedInSeeker");

        if (seeker == null) {
            return "redirect:/seekers/login";
        }

        try {
            seekerService.deleteSeeker(seeker.getId());
            session.invalidate();
            redirectAttributes.addFlashAttribute("successMessage",
                    "Account deleted successfully");
            return "redirect:/";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/seekers/dashboard";
        }
    }

    // ─── LOGOUT ──────────────────────────────────────────────────────────────────

    @GetMapping("/logout")
    public String logout(HttpSession session,
                         RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("successMessage",
                "Logged out successfully");
        return "redirect:/";
    }
}