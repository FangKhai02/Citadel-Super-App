package com.citadel.backend.entity.Products;

import com.citadel.backend.entity.DocumentType;
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
@Table(name = "product_agreement")
public class ProductAgreement {
    public enum ClientType {
        INDIVIDUAL,CORPORATE
    }

    @JsonIgnore
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "document_type_id")
    private DocumentType documentType;

    @Enumerated(EnumType.STRING)
    @Column(name = "client_type")
    private ProductAgreement.ClientType clientType;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "upload_document")
    private String uploadDocument;

    @Column(name = "document_editor")
    private String documentEditor;

    @Column(name = "status", nullable = false, columnDefinition = "tinyint(1) default 1")
    private Boolean status;

    @JsonIgnore
    @Column(name = "created_at")
    private Date createdAt;

    @JsonIgnore
    @Column(name = "updated_at")
    private Date updatedAt;

    @Column(name = "use_document_editor", columnDefinition = "tinyint(1) default 0")
    private Boolean useDocumentEditor;

    @Column(name = "overwrite_agreement_key")
    private String overwriteAgreementKey;
}
