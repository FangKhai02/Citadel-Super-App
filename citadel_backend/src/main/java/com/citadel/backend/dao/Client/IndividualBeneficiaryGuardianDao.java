package com.citadel.backend.dao.Client;

import com.citadel.backend.entity.IndividualBeneficiary;
import com.citadel.backend.entity.IndividualBeneficiaryGuardian;
import com.citadel.backend.entity.IndividualGuardian;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IndividualBeneficiaryGuardianDao extends JpaRepository<IndividualBeneficiaryGuardian, Long> {
    IndividualBeneficiaryGuardian findByIndividualBeneficiaryAndIsDeletedIsFalse(IndividualBeneficiary individualBeneficiary);

    List<IndividualBeneficiaryGuardian> findByIndividualBeneficiaryInAndIsDeletedIsFalse(List<IndividualBeneficiary> beneficiaryList);

    List<IndividualBeneficiaryGuardian> findByIndividualGuardianAndIsDeletedIsFalse(IndividualGuardian guardian);

    IndividualBeneficiaryGuardian findByIndividualBeneficiaryAndIndividualGuardianAndIsDeletedIsFalse(IndividualBeneficiary individualBeneficiary, IndividualGuardian individualGuardian);
}
