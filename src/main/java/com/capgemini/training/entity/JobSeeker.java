package com.capgemini.training.entity;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "job_seeker")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class JobSeeker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Name cannot be empty")
    @Column(nullable = false)
    private String fullName;

    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Enter a valid email")
    @Column(nullable = false, unique = true)
    private String email;

    @NotBlank(message = "Password cannot be empty")
    @Column(nullable = false)
    private String password;

    @Column
    private String skills;

    @Column
    private String resumeLink;

    @Column
    private String location;

    @OneToMany(mappedBy = "jobSeeker", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<JobApplication> applications = new ArrayList<>();
}