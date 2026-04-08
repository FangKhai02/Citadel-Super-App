package com.citadel.backend.dao;

import com.citadel.backend.entity.ContactUsFormSubmission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ContactUsFormSubmissionDao extends JpaRepository<ContactUsFormSubmission, Long> {

}
