package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "generalistes")
public class Generaliste extends utilisateur {

    private String numeroOrdre;
    private String specialite = "Médecine générale";

    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Consultation> consultations = new ArrayList<>();

    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DemandeExpertise> demandesExpertise = new ArrayList<>();

    // Constructeurs
    public Generaliste() {
        super();
    }

    public Generaliste(int id, String nom, String prenom, String email, String motDePasse, String role) {
        super(id, nom, prenom, email, motDePasse, role);
    }

    // Getters et Setters
    public String getNumeroOrdre() {
        return numeroOrdre;
    }

    public void setNumeroOrdre(String numeroOrdre) {
        this.numeroOrdre = numeroOrdre;
    }

    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }

    public List<DemandeExpertise> getDemandesExpertise() {
        return demandesExpertise;
    }

    public void setDemandesExpertise(List<DemandeExpertise> demandesExpertise) {
        this.demandesExpertise = demandesExpertise;
    }
}
