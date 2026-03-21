package com.capgemini.training.Repo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.capgemini.training.entity.Job;

@Repository
public interface JobRepository extends JpaRepository<Job, Long> {

    // ─── DERIVED QUERY METHODS ───────────────────────────────────────────────
    // Spring Data JPA reads the method name and auto-generates the SQL

    // SELECT * FROM job WHERE employer_id = ? AND active = true
    List<Job> findByEmployerIdAndActiveTrue(Long employerId);

    // SELECT * FROM job WHERE active = true
    List<Job> findByActiveTrue();

    // SELECT * FROM job WHERE LOWER(location) LIKE LOWER('%?%') AND active = true
    List<Job> findByLocationContainingIgnoreCaseAndActiveTrue(String location);

    // SELECT * FROM job WHERE job_type = ? AND active = true
    List<Job> findByJobTypeAndActiveTrue(String jobType);

    // ─── CUSTOM JPQL QUERIES ─────────────────────────────────────────────────
    // Used when derived method names become too long or complex

    // Search by keyword in title OR description
    @Query("SELECT j FROM Job j WHERE j.active = true AND " +
           "(LOWER(j.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(j.description) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<Job> searchByKeyword(@Param("keyword") String keyword);

    // Search by keyword AND location together
    @Query("SELECT j FROM Job j WHERE j.active = true AND " +
           "(LOWER(j.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(j.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
           "LOWER(j.location) LIKE LOWER(CONCAT('%', :location, '%'))")
    List<Job> searchByKeywordAndLocation(
            @Param("keyword") String keyword,
            @Param("location") String location);
}