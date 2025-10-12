package com.example.teleexpertise.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

import com.example.teleexpertise.model.enums.TypeSpecialite;

@Entity
@Table(name = "specialistes")
public class Specialiste extends utilisateur {

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TypeSpecialite specialite;

    @Column(nullable = false)
    private Double tarif;

    private Integer dureeMoyenneConsultation = 30; // fixe à 30 minutes

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DemandeExpertise> demandesExpertise = new ArrayList<>();

    @OneToMany(mappedBy = "specialiste", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CreneauHoraire> creneauxHoraires = new ArrayList<>();

    // Constructeurs
    public Specialiste() {
        super();
    }

    public Specialiste(int id, String nom, String prenom, String email, String motDePasse, String role) {
        super(id, nom, prenom, email, motDePasse, role);
    }

    // Getters et Setters
    public TypeSpecialite getSpecialite() {
        return specialite;
    }

    public void setSpecialite(TypeSpecialite specialite) {
        this.specialite = specialite;
    }

    public Double getTarif() {
        return tarif;
    }

    public void setTarif(Double tarif) {
        this.tarif = tarif;
    }

    public Integer getDureeMoyenneConsultation() {
        return dureeMoyenneConsultation;
    }

    public void setDureeMoyenneConsultation(Integer dureeMoyenneConsultation) {
        this.dureeMoyenneConsultation = dureeMoyenneConsultation;
    }

    public List<DemandeExpertise> getDemandesExpertise() {
        return demandesExpertise;
    }

    public void setDemandesExpertise(List<DemandeExpertise> demandesExpertise) {
        this.demandesExpertise = demandesExpertise;
    }

    public List<CreneauHoraire> getCreneauxHoraires() {
        return creneauxHoraires;
    }

    public void setCreneauxHoraires(List<CreneauHoraire> creneauxHoraires) {
        this.creneauxHoraires = creneauxHoraires;
    }
}
