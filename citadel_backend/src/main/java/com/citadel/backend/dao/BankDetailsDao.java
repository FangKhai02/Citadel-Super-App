package com.citadel.backend.dao;

import com.citadel.backend.entity.AppUser;
import com.citadel.backend.entity.BankDetails;
import com.citadel.backend.entity.Corporate.CorporateClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BankDetailsDao extends JpaRepository<BankDetails, Long> {
    BankDetails findByAccountNumberAndIsDeletedFalse(String accountNumber);

    BankDetails findByAccountNumberAndAppUserAndIsDeletedFalse(String accountNumber, AppUser appUser);

    List<BankDetails> findAllByAppUserAndIsDeletedIsFalse(AppUser appUser);

    Optional<BankDetails> findByIdAndAppUserAndIsDeletedFalse(Long id, AppUser appUser);

    List<BankDetails> findAllByCorporateClientAndIsDeletedIsFalse(CorporateClient corporateClient);

    Optional<BankDetails> findByIdAndCorporateClientAndIsDeletedFalse(Long id, CorporateClient corporateClient);

    BankDetails findBankDetailsByAgencyIdAndIsDeletedFalse(Long agencyId);

    @Query("SELECT bd.bankName FROM BankDetails bd WHERE bd.appUser = :appUser AND bd.isDeleted = false")
    String findBankNameByAppUserAndIsDeletedFalse(AppUser appUser);

    BankDetails findByAppUserAndIsDeletedIsFalse(AppUser appUser);

    boolean existsByAccountNumberAndAppUserAndIsDeletedIsFalse(String accountNumber, AppUser appUser);

    boolean existsByAccountNumberAndCorporateClientAndIsDeletedIsFalse(String accountNumber, CorporateClient corporateClient);
}
