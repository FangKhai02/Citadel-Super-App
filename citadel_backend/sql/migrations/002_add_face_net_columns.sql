-- =====================================================
-- eKYC Migration: Add FaceNet fields to faceid_image_validate table
-- =====================================================
-- This migration adds the new columns needed for FaceNet-based face verification
-- to replace the old Microblink/NexID-based approach.

-- First create the table if it doesn't exist
CREATE TABLE IF NOT EXISTS `faceid_image_validate`
(
    `id`                   bigint(20) NOT NULL AUTO_INCREMENT,
    `selfie_filename`      varchar(200) DEFAULT NULL,
    `id_document_filename` varchar(200) DEFAULT NULL,
    `id_number`            varchar(50)  DEFAULT NULL,
    `confidence`           double       DEFAULT NULL,
    `liveness_score`       double       DEFAULT NULL,
    `valid`                tinyint(1)   DEFAULT NULL,
    `created_at`           datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Add new columns for FaceNet
ALTER TABLE faceid_image_validate
  ADD COLUMN document_type VARCHAR(20) COMMENT 'MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID',
  ADD COLUMN full_name VARCHAR(255) COMMENT 'Full name from identity document',
  ADD COLUMN date_of_birth DATE COMMENT 'Date of birth from identity document',
  ADD COLUMN gender VARCHAR(20) COMMENT 'MALE, FEMALE, OTHER',
  ADD COLUMN nationality VARCHAR(100) COMMENT 'Nationality from identity document',
  ADD COLUMN face_match_score DOUBLE COMMENT 'Euclidean distance score (lower = more similar)',
  ADD COLUMN face_verified BOOLEAN COMMENT 'true if face match passed (score <= 0.45)';

-- Optional: Add index for faster lookups
CREATE INDEX idx_faceid_image_validate_document_type ON faceid_image_validate(document_type);
CREATE INDEX idx_faceid_image_validate_face_verified ON faceid_image_validate(face_verified);

-- =====================================================
-- NOTE:
-- The old columns (confidence, liveness_score, valid) are kept for backward
-- compatibility with the old image-validate endpoint.
-- New data will use the new columns instead.
-- =====================================================
