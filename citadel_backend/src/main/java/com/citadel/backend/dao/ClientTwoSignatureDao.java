package com.citadel.backend.dao;

import com.citadel.backend.entity.ClientTwoSignature;
import com.citadel.backend.entity.Products.ProductOrder;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClientTwoSignatureDao extends JpaRepository<ClientTwoSignature, Long> {

    Optional<ClientTwoSignature> findByUniqueIdentifier(String uniqueIdentifier);

    Optional<ClientTwoSignature> findByProductOrder(ProductOrder productOrder);

    void deleteByUniqueIdentifier(String uniqueIdentifier);
}