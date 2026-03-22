package com.capgemini.training.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capgemini.training.Repo.JobRepository;
import com.capgemini.training.entity.Employer;
import com.capgemini.training.entity.Job;

import jakarta.transaction.Transactional;

@Service
public class JobService {

    private final JobRepository jobRepository;
    private final EmployerService employerService;

    @Autowired
    public JobService(JobRepository jobRepository,
                      EmployerService employerService) {
        this.jobRepository = jobRepository;
        this.employerService = employerService;
    }

    // ─── CREATE ────────────────────────────────────────────────────────────────

    @Transactional
    public Job postJob(Long employerId, Job job) {
        Employer employer = employerService.getById(employerId);
        job.setEmployer(employer);
        job.setActive(true);
        return jobRepository.save(job);
    }

    // ─── READ ──────────────────────────────────────────────────────────────────

    public Job getById(Long id) {
        return jobRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Job not found with id: " + id));
    }

    public List<Job> getAllActiveJobs() {
        return jobRepository.findByActiveTrue();
    }

    public List<Job> getJobsByEmployer(Long employerId) {
        return jobRepository.findByEmployerIdAndActiveTrue(employerId);
    }

    public List<Job> searchJobs(String keyword, String location) {

        // Both keyword and location provided
        if (keyword != null && !keyword.isBlank() &&
                location != null && !location.isBlank()) {
            return jobRepository.searchByKeywordAndLocation(keyword, location);
        }

        // Only keyword provided
        if (keyword != null && !keyword.isBlank()) {
            return jobRepository.searchByKeyword(keyword);
        }

        // Only location provided
        if (location != null && !location.isBlank()) {
            return jobRepository.findByLocationContainingIgnoreCaseAndActiveTrue(location);
        }

        // Neither provided — return all active jobs
        return jobRepository.findByActiveTrue();
    }

    // ─── UPDATE ────────────────────────────────────────────────────────────────

    @Transactional
    public Job updateJob(Long jobId, Long employerId, Job updatedData) {
        Job existing = getById(jobId);

        // Security check: make sure this employer actually owns this job
        if (!existing.getEmployer().getId().equals(employerId)) {
            throw new RuntimeException("Unauthorized: You do not own this job");
        }

        existing.setTitle(updatedData.getTitle());
        existing.setDescription(updatedData.getDescription());
        existing.setLocation(updatedData.getLocation());
        existing.setSalaryRange(updatedData.getSalaryRange());
        existing.setJobType(updatedData.getJobType());

        return jobRepository.save(existing);
    }

    // ─── DELETE (Soft Delete) ──────────────────────────────────────────────────

    @Transactional
    public void softDeleteJob(Long jobId, Long employerId) {
        Job job = getById(jobId);

        // Security check: make sure this employer actually owns this job
        if (!job.getEmployer().getId().equals(employerId)) {
            throw new RuntimeException("Unauthorized: You do not own this job");
        }

        job.setActive(false);
        jobRepository.save(job);
    }
}