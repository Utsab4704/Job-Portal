package com.capgemini.training.Repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.capgemini.training.entity.JobSeeker;

@Repository
public interface JobSeekerRepository extends JpaRepository<JobSeeker, Long> {

    // Used during login — find seeker by email
    // SELECT * FROM job_seeker WHERE email = ?
    Optional<JobSeeker> findByEmail(String email);

    // Used during registration — check if email already exists
    // SELECT COUNT(*) > 0 FROM job_seeker WHERE email = ?
    boolean existsByEmail(String email);
}