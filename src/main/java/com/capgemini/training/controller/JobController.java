package com.capgemini.training.controller;

import java.util.List;

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

import com.capgemini.training.entity.Employer;
import com.capgemini.training.entity.Job;
import com.capgemini.training.entity.JobApplication;
import com.capgemini.training.service.JobApplicationService;
import com.capgemini.training.service.JobService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/jobs")
public class JobController {

    private final JobService jobService;
    private final JobApplicationService applicationService;

    @Autowired
    public JobController(JobService jobService,
                         JobApplicationService applicationService) {
        this.jobService = jobService;
        this.applicationService = applicationService;
    }

    // ─── PUBLIC JOB LISTINGS ────────────────────────────────────────────────────

    @GetMapping
    public String listJobs(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String location,
            Model model) {

        List<Job> jobs = jobService.searchJobs(keyword, location);
        model.addAttribute("jobs", jobs);
        model.addAttribute("keyword", keyword);
        model.addAttribute("location", location);
        return "job/list";
    }

    // ─── VIEW SINGLE JOB DETAIL ─────────────────────────────────────────────────

    @GetMapping("/{id}")
    public String viewJob(@PathVariable Long id, Model model,
                          HttpSession session) {
        Job job = jobService.getById(id);
        model.addAttribute("job", job);

        // Pass seeker info so JSP can show Apply or Already Applied
        Object seeker = session.getAttribute("loggedInSeeker");
        model.addAttribute("loggedInSeeker", seeker);
        return "job/detail";
    }

    // ─── SHOW POST JOB FORM ─────────────────────────────────────────────────────

    @GetMapping("/post")
    public String showPostForm(HttpSession session, Model model,
                               RedirectAttributes redirectAttributes) {
        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Please log in as an employer first");
            return "redirect:/employers/login";
        }

        model.addAttribute("job", new Job());
        return "job/post";
    }

    // ─── HANDLE POST JOB SUBMIT ─────────────────────────────────────────────────

    @PostMapping("/post")
    public String postJob(
            @Valid @ModelAttribute("job") Job job,
            BindingResult result,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        if (result.hasErrors()) {
            return "job/post";
        }

        try {
            jobService.postJob(employer.getId(), job);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Job posted successfully!");
            return "redirect:/employers/dashboard";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/jobs/post";
        }
    }

    // ─── SHOW EDIT JOB FORM ─────────────────────────────────────────────────────

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, HttpSession session,
                               Model model, RedirectAttributes redirectAttributes) {
        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        Job job = jobService.getById(id);

        // Make sure this employer owns this job
        if (!job.getEmployer().getId().equals(employer.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "You are not authorized to edit this job");
            return "redirect:/employers/dashboard";
        }

        model.addAttribute("job", job);
        return "job/edit";
    }

    // ─── HANDLE EDIT JOB SUBMIT ─────────────────────────────────────────────────

    @PostMapping("/{id}/edit")
    public String updateJob(
            @PathVariable Long id,
            @Valid @ModelAttribute("job") Job updatedJob,
            BindingResult result,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        if (result.hasErrors()) {
            return "job/edit";
        }

        try {
            jobService.updateJob(id, employer.getId(), updatedJob);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Job updated successfully!");
            return "redirect:/employers/dashboard";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/jobs/" + id + "/edit";
        }
    }

    // ─── SOFT DELETE JOB ────────────────────────────────────────────────────────

    @PostMapping("/{id}/delete")
    public String deleteJob(@PathVariable Long id, HttpSession session,
                            RedirectAttributes redirectAttributes) {
        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        try {
            jobService.softDeleteJob(id, employer.getId());
            redirectAttributes.addFlashAttribute("successMessage",
                    "Job removed from listings");
            return "redirect:/employers/dashboard";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/employers/dashboard";
        }
    }

    // ─── VIEW APPLICATIONS FOR A JOB ────────────────────────────────────────────

    @GetMapping("/{id}/applications")
    public String viewApplications(@PathVariable Long id, HttpSession session,
                                   Model model,
                                   RedirectAttributes redirectAttributes) {
        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        Job job = jobService.getById(id);

        if (!job.getEmployer().getId().equals(employer.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized");
            return "redirect:/employers/dashboard";
        }

        List<JobApplication> applications = applicationService.getApplicationsForJob(id);
        model.addAttribute("job", job);
        model.addAttribute("applications", applications);
        return "job/applications";
    }

    // ─── UPDATE APPLICATION STATUS ──────────────────────────────────────────────

    @PostMapping("/applications/{applicationId}/status")
    public String updateApplicationStatus(
            @PathVariable Long applicationId,
            @RequestParam String status,
            @RequestParam Long jobId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Employer employer = (Employer) session.getAttribute("loggedInEmployer");

        if (employer == null) {
            return "redirect:/employers/login";
        }

        try {
            applicationService.updateStatus(applicationId,
                    JobApplication.ApplicationStatus.valueOf(status));
            redirectAttributes.addFlashAttribute("successMessage",
                    "Application status updated!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/jobs/" + jobId + "/applications";
    }
}