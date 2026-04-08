package com.citadel.backend.entity;

import com.citadel.backend.entity.Products.ProductOrder;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@NoArgsConstructor
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "client_two_signature")
public class ClientTwoSignature extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_order_id", referencedColumnName = "id")
    private ProductOrder productOrder;

    @Column(name = "unique_identifier", unique = true)
    private String uniqueIdentifier = UUID.randomUUID().toString();

    @Column(name = "expiry_at")
    private LocalDateTime expiryAt = LocalDateTime.now().plusHours(24);
}