package com.capgemini.training.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.capgemini.training.Repo.JobSeekerRepository;
import com.capgemini.training.entity.JobSeeker;

@Service
public class JobSeekerService   {

    private final JobSeekerRepository jobSeekerRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public JobSeekerService(JobSeekerRepository jobSeekerRepository, PasswordEncoder passwordEncoder){
        this.jobSeekerRepository = jobSeekerRepository;
        this.passwordEncoder = passwordEncoder;
    }

    //CRUD OPERATIONS

    //CREATE
    public JobSeeker register(JobSeeker jobSeeker) {
        if(jobSeekerRepository.existsByEmail(jobSeeker.getEmail())) {
            throw new RuntimeException("Email already registered: " + jobSeeker.getEmail());
        }
        jobSeeker.setPassword(passwordEncoder.encode(jobSeeker.getPassword()));

        return jobSeekerRepository.save(jobSeeker);
    }


    //READ
    public List<JobSeeker> getAllSeekers() {
        return jobSeekerRepository.findAll();
    }

    public JobSeeker getById(Long id) {
        return jobSeekerRepository.findById(id).orElseThrow(() -> new RuntimeException("Job Seeker not found with id " + id));

    }

    public JobSeeker getByEmail(String email) {
        return jobSeekerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Job seeker not found with email: " + email));
    }


    //DELETE
    public JobSeeker updateProfile(Long id, JobSeeker updatedData) {
        JobSeeker existing = getById(id);

        existing.setFullName(updatedData.getFullName());
        existing.setSkills(updatedData.getSkills());
        existing.setResumeLink(updatedData.getResumeLink());
        existing.setLocation(updatedData.getLocation());

        if (updatedData.getPassword() != null && !((String) updatedData.getPassword()).isBlank()) {
            existing.setPassword(passwordEncoder.encode(updatedData.getPassword()));
        }

        return jobSeekerRepository.save(existing);
    }

    //DELETE
    public void deleteSeeker(Long id) {
        JobSeeker seeker = getById(id);
        jobSeekerRepository.delete(seeker);
    }

    // Add this method to JobSeekerService
    public boolean checkPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }
}