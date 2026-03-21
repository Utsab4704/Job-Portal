package com.capgemini.training.Repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.capgemini.training.entity.JobApplication;
import com.capgemini.training.entity.JobApplication.ApplicationStatus;

@Repository
public interface JobApplicationRepository extends JpaRepository<JobApplication, Long> {

    // All applications submitted by a specific job seeker
    // SELECT * FROM job_applications WHERE job_seeker_id = ?
    List<JobApplication> findByJobSeekerId(Long jobSeekerId);

    // All applications received for a specific job
    // SELECT * FROM job_applications WHERE job_id = ?
    List<JobApplication> findByJobId(Long jobId);

    // All applications for a job filtered by status
    // SELECT * FROM job_applications WHERE job_id = ? AND status = ?
    List<JobApplication> findByJobIdAndStatus(Long jobId, ApplicationStatus status);

    // Used to prevent duplicate applications
    // SELECT COUNT(*) > 0 FROM job_applications WHERE job_seeker_id = ? AND job_id = ?
    boolean existsByJobSeekerIdAndJobId(Long jobSeekerId, Long jobId);

    // Used when withdrawing an application
    // SELECT * FROM job_applications WHERE job_seeker_id = ? AND job_id = ?
    Optional<JobApplication> findByJobSeekerIdAndJobId(Long jobSeekerId, Long jobId);
}