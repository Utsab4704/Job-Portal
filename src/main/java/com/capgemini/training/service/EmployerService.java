package com.capgemini.training.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.capgemini.training.Repo.EmployerRepository;
import com.capgemini.training.entity.Employer;

@Service
public class EmployerService {

    private final EmployerRepository employerRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public EmployerService(EmployerRepository employerRepository,
                           PasswordEncoder passwordEncoder) {
        this.employerRepository = employerRepository;
        this.passwordEncoder = passwordEncoder;
    }

    // ─── CREATE ────────────────────────────────────────────────────────────────

    public Employer register(Employer employer) {
        if (employerRepository.existsByEmail(employer.getEmail())) {
            throw new RuntimeException("Email already registered: " + employer.getEmail());
        }
        employer.setPassword(passwordEncoder.encode(employer.getPassword()));
        return employerRepository.save(employer);
    }

    // ─── READ ──────────────────────────────────────────────────────────────────

    public List<Employer> getAllEmployers() {
        return employerRepository.findAll();
    }

    public Employer getById(Long id) {
        return employerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Employer not found with id: " + id));
    }

    public Employer getByEmail(String email) {
        return employerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Employer not found with email: " + email));
    }

    // ─── UPDATE ────────────────────────────────────────────────────────────────

    public Employer updateProfile(Long id, Employer updatedData) {
        Employer existing = getById(id);

        existing.setCompany(updatedData.getCompany());
        existing.setLocation(updatedData.getLocation());
        existing.setDescription(updatedData.getDescription());

        // Only update password if a new one was actually provided
        if (updatedData.getPassword() != null && !updatedData.getPassword().isBlank()) {
            existing.setPassword(passwordEncoder.encode(updatedData.getPassword()));
        }

        return employerRepository.save(existing);
    }

    // ─── DELETE ────────────────────────────────────────────────────────────────

    public void deleteEmployer(Long id) {
        Employer employer = getById(id);
        employerRepository.delete(employer);
    }

    // ─── AUTH HELPER ───────────────────────────────────────────────────────────

    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }
}