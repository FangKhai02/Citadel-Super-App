package com.citadel.backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "faceid_image_validate")
public class FaceIdImageValidate {

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "selfie_filename")
    private String selfieFilename;

    @Column(name = "id_document_filename")
    private String idDocumentFilename;

    @Column(name = "id_number")
    private String idNumber;

    @Column(name = "confidence")
    private Double confidence;

    @Column(name = "liveness_score")
    private Double livenessScore;

    @Column(name = "valid")
    private Boolean valid;

    @Column(name = "created_at")
    private Date createdAt;

    // New fields for FaceNet-based verification
    @Column(name = "document_type")
    private String documentType;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "date_of_birth")
    private Date dateOfBirth;

    @Column(name = "gender")
    private String gender;

    @Column(name = "nationality")
    private String nationality;

    @Column(name = "face_match_score")
    private Double faceMatchScore;

    @Column(name = "face_verified")
    private Boolean faceVerified;
}
