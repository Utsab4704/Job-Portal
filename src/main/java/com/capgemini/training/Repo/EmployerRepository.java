package com.capgemini.training.Repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.capgemini.training.entity.Employer;

@Repository
public interface EmployerRepository extends JpaRepository<Employer, Long> {

    // Spring Data JPA auto-generates the query from the method name
    Optional<Employer> findByEmail(String email);

    // Custom JPQL query — useful when method name alone gets too long
    @Query("SELECT e FROM Employer e WHERE e.company = :name")
    Optional<Employer> findByCompanyName(@Param("name") String companyName);

    // Returns true/false — used to check duplicates before saving
    boolean existsByEmail(String email);
}