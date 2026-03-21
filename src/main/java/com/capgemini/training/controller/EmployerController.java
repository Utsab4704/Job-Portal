package com.capgemini.training.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.capgemini.training.entity.Employer;
import com.capgemini.training.service.EmployerService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
//@Controller means: this class handles HTTP requests and returns VIEW NAMES (JSP pages)
//(contrast with @RestController which returns raw JSON)
@RequestMapping("/employers")
//All URLs in this class start with /employers
public class EmployerController {

 private final EmployerService employerService;

 @Autowired
 public EmployerController(EmployerService employerService) {
     this.employerService = employerService;
 }

 // ─── SHOW REGISTRATION FORM ────────────────────────────────────────────────
 @GetMapping("/register")
 // GET /employers/register → shows the registration form page
 public String showRegisterForm(Model model) {
     // We add an empty Employer object to the model so the JSP form
     // can bind input fields directly to it using Spring's form tags
     model.addAttribute("employer", new Employer());
     return "employer/register";
     // Spring looks for: /WEB-INF/views/employer/register.jsp
 }

 // ─── HANDLE REGISTRATION FORM SUBMIT ───────────────────────────────────────
 @PostMapping("/register")
 // POST /employers/register → processes the submitted form
 public String register(
         @Valid @ModelAttribute("employer") Employer employer,
         // @Valid triggers the @NotBlank, @Email checks we put on the model
         // @ModelAttribute binds form fields to the Employer object automatically
         BindingResult result,
         // BindingResult holds any validation errors — MUST come right after @Valid
         RedirectAttributes redirectAttributes) {
     // RedirectAttributes lets us pass flash messages across redirects

     // If validation failed (e.g. blank email), go back to form with errors shown
     if (result.hasErrors()) {
         return "employer/register";
     }

     try {
         employerService.register(employer);
         // Flash attributes survive exactly one redirect, then disappear
         redirectAttributes.addFlashAttribute("successMessage",
                 "Registration successful! Please log in.");
         return "redirect:/employers/login";
     } catch (RuntimeException e) {
         // e.g. "Email already registered"
         redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
         return "redirect:/employers/register";
     }
 }

 // ─── SHOW LOGIN FORM ────────────────────────────────────────────────────────
 @GetMapping("/login")
 public String showLoginForm(Model model) {
     model.addAttribute("employer", new Employer());
     return "employer/login";
 }

 // ─── HANDLE LOGIN ───────────────────────────────────────────────────────────
 @PostMapping("/login")
 public String login(
         @RequestParam String email,
         // @RequestParam pulls a single field from the form by name
         @RequestParam String password,
         HttpSession session,
         // HttpSession lets us store data about the logged-in user
         RedirectAttributes redirectAttributes) {

     try {
         Employer employer = employerService.getByEmail(email);

         if (!employerService.checkPassword(password, employer.getPassword())) {
             redirectAttributes.addFlashAttribute("errorMessage", "Invalid credentials");
             return "redirect:/employers/login";
         }

         // Store employer info in session — acts as "who is logged in"
         session.setAttribute("loggedInEmployer", employer);
         session.setAttribute("userType", "EMPLOYER");
         return "redirect:/employers/dashboard";

     } catch (RuntimeException e) {
         redirectAttributes.addFlashAttribute("errorMessage", "Email not found");
         return "redirect:/employers/login";
     }
 }

 // ─── DASHBOARD ──────────────────────────────────────────────────────────────
 @GetMapping("/dashboard")
 public String dashboard(HttpSession session, Model model,
                         RedirectAttributes redirectAttributes) {
     Employer employer = (Employer) session.getAttribute("loggedInEmployer");

     // Guard: if not logged in, send them to login page
     if (employer == null) {
         redirectAttributes.addFlashAttribute("errorMessage",
                 "Please log in first");
         return "redirect:/employers/login";
     }

     // Refresh employer data from DB in case it was updated
     employer = employerService.getById(employer.getId());
     model.addAttribute("employer", employer);
     model.addAttribute("jobs", employer.getJobs());
     return "employer/dashboard";
 }

 // ─── SHOW EDIT PROFILE FORM ─────────────────────────────────────────────────
 @GetMapping("/edit")
 public String showEditForm(HttpSession session, Model model,
                            RedirectAttributes redirectAttributes) {
     Employer employer = (Employer) session.getAttribute("loggedInEmployer");

     if (employer == null) {
         redirectAttributes.addFlashAttribute("errorMessage", "Please log in first");
         return "redirect:/employers/login";
     }

     model.addAttribute("employer", employerService.getById(employer.getId()));
     return "employer/edit";
 }

 // ─── HANDLE PROFILE UPDATE ──────────────────────────────────────────────────
 @PostMapping("/edit")
 public String updateProfile(
         @Valid @ModelAttribute("employer") Employer updatedData,
         BindingResult result,
         HttpSession session,
         RedirectAttributes redirectAttributes) {

     Employer loggedIn = (Employer) session.getAttribute("loggedInEmployer");

     if (loggedIn == null) {
         return "redirect:/employers/login";
     }

     if (result.hasErrors()) {
         return "employer/edit";
     }

     try {
         Employer updated = employerService.updateProfile(loggedIn.getId(), updatedData);
         // Update the session with fresh data so dashboard reflects changes
         session.setAttribute("loggedInEmployer", updated);
         redirectAttributes.addFlashAttribute("successMessage", "Profile updated!");
         return "redirect:/employers/dashboard";
     } catch (RuntimeException e) {
         redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
         return "redirect:/employers/edit";
     }
 }

 // ─── DELETE ACCOUNT ─────────────────────────────────────────────────────────
 @PostMapping("/delete")
 // We use POST for delete (not HTTP DELETE) because HTML forms only support GET/POST
 public String deleteAccount(HttpSession session,
                             RedirectAttributes redirectAttributes) {
     Employer employer = (Employer) session.getAttribute("loggedInEmployer");

     if (employer == null) {
         return "redirect:/employers/login";
     }

     try {
         employerService.deleteEmployer(employer.getId());
         session.invalidate(); // Wipe the entire session on account deletion
         redirectAttributes.addFlashAttribute("successMessage",
                 "Account deleted successfully");
         return "redirect:/";
     } catch (RuntimeException e) {
         redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
         return "redirect:/employers/dashboard";
     }
 }

 // ─── LOGOUT ─────────────────────────────────────────────────────────────────
 @GetMapping("/logout")
 public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
     session.invalidate();
     redirectAttributes.addFlashAttribute("successMessage", "Logged out successfully");
     return "redirect:/";
 }
}