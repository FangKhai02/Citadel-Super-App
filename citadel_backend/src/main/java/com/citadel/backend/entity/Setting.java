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
@Table(name = "settings")
public class Setting {

    @Id
    @JsonIgnore
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "key")
    private String key;

    @JsonIgnore
    @Column(name = "display_name")
    private String displayName;

    @Column(name = "value")
    private String value;

    @JsonIgnore
    @Column(name = "details")
    private String details;

    @JsonIgnore
    @Column(name = "type")
    private String type;

    @JsonIgnore
    @Column(name = "order")
    private Integer order;

    @JsonIgnore
    @Column(name = "group")
    private String group;

    @Column(name = "updated_at")
    private Date updatedAt;
}
