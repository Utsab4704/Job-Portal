package com.capgemini.training.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capgemini.training.Repo.JobApplicationRepository;
import com.capgemini.training.entity.Job;
import com.capgemini.training.entity.JobApplication;
import com.capgemini.training.entity.JobApplication.ApplicationStatus;
import com.capgemini.training.entity.JobSeeker;

import jakarta.transaction.Transactional;

@Service
public class JobApplicationService {

    private final JobApplicationRepository applicationRepository;
    private final JobService jobService;
    private final JobSeekerService jobSeekerService;

    @Autowired
    public JobApplicationService(JobApplicationRepository applicationRepository,
                                 JobService jobService,
                                 JobSeekerService jobSeekerService) {
        this.applicationRepository = applicationRepository;
        this.jobService = jobService;
        this.jobSeekerService = jobSeekerService;
    }

    // ─── APPLY ─────────────────────────────────────────────────────────────────

    @Transactional
    public JobApplication apply(Long jobSeekerId, Long jobId, String coverLetter) {

        // Rule 1: Prevent duplicate applications
        if (applicationRepository.existsByJobSeekerIdAndJobId(jobSeekerId, jobId)) {
            throw new RuntimeException("You have already applied to this job");
        }

        Job job = jobService.getById(jobId);

        // Rule 2: Can't apply to an inactive/deleted job
        if (!job.isActive()) {
            throw new RuntimeException("This job is no longer accepting applications");
        }

        JobSeeker seeker = jobSeekerService.getById(jobSeekerId);

        JobApplication application = new JobApplication();
        application.setJobSeeker(seeker);
        application.setJob(job);
        application.setCoverLetter(coverLetter);
        application.setStatus(ApplicationStatus.PENDING);
        // appliedAt is set automatically by @PrePersist in JobApplication

        return applicationRepository.save(application);
    }

    // ─── READ ──────────────────────────────────────────────────────────────────

    public List<JobApplication> getApplicationsBySeeker(Long jobSeekerId) {
        return applicationRepository.findByJobSeekerId(jobSeekerId);
    }

    public List<JobApplication> getApplicationsForJob(Long jobId) {
        return applicationRepository.findByJobId(jobId);
    }

    public List<JobApplication> getApplicationsForJobByStatus(Long jobId,
                                                               ApplicationStatus status) {
        return applicationRepository.findByJobIdAndStatus(jobId, status);
    }

    // ─── UPDATE STATUS (Employer action) ───────────────────────────────────────

    @Transactional
    public JobApplication updateStatus(Long applicationId, ApplicationStatus newStatus) {
        JobApplication application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException(
                        "Application not found: " + applicationId));

        application.setStatus(newStatus);
        return applicationRepository.save(application);
    }

    // ─── WITHDRAW (Job Seeker action) ──────────────────────────────────────────

    @Transactional
    public void withdraw(Long jobSeekerId, Long jobId) {
        JobApplication application = applicationRepository
                .findByJobSeekerIdAndJobId(jobSeekerId, jobId)
                .orElseThrow(() -> new RuntimeException("Application not found"));

        // Only allow withdrawal if still PENDING
        if (application.getStatus() != ApplicationStatus.PENDING) {
            throw new RuntimeException("Cannot withdraw — application is already "
                    + application.getStatus());
        }

        applicationRepository.delete(application);
    }
}
