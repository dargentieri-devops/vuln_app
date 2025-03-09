package it.devops.vulnapp.model;

import jakarta.persistence.*;


@Entity
@Table(name = "accounts", schema = "public")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
}

