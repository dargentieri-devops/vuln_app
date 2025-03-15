package it.devops.vulnapp.model;

import jakarta.persistence.*;


@Entity
@Table(name = "accounts", schema = "public")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    public void setName(String name) {
        this.name=name;
    }

    public String getName() {
        return this.name;
    }
}

