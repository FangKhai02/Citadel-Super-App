package com.citadel.backend.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@Table(name = "esms_history")
public class EsmsHistory {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "id")
        private Long id;

        @Column(name = "mobile_number")
        private String mobileNumber;

        @Column(name = "client_name")
        private String clientName;

        @Column(name = "otp")
        private String otp;

        @Column(name = "status")
        private String status;

        @Column(name = "expired_at")
        private Date expiredAt;

        @Column(name = "created_at")
        private Date createdAt;

        @Column(name = "remarks")
        private String remarks;

}
