package com.example.teleexpertise.model;

import jakarta.persistence.*;

@Entity
@Table(name = "infirmiers")
public class Infirmier extends utilisateur {

    public Infirmier() {

    }

    public Infirmier(int id, String nom, String prenom, String email, String motDePasse, String role) {
        super(id, nom, prenom, email, motDePasse, role);
    }
}
