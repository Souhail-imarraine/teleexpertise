package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import com.example.teleexpertise.model.enums.TypeActeTechnique;

@Entity
@Table(name = "actes_techniques")
public class ActeTechnique {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false)
    private String nom;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TypeActeTechnique type;

    @Column(nullable = false)
    private Double prix;

    @Column(length = 1000)
    private String description;

    private LocalDateTime dateRealisation;

    @Column(length = 2000)
    private String resultats;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false)
    private Consultation consultation;

    // Constructeurs
    public ActeTechnique() {
    }

    public ActeTechnique(String nom, TypeActeTechnique type, Double prix) {
        this.nom = nom;
        this.type = type;
        this.prix = prix;
        this.dateRealisation = LocalDateTime.now();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public TypeActeTechnique getType() {
        return type;
    }

    public void setType(TypeActeTechnique type) {
        this.type = type;
    }

    public Double getPrix() {
        return prix;
    }

    public void setPrix(Double prix) {
        this.prix = prix;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDateRealisation() {
        return dateRealisation;
    }

    public void setDateRealisation(LocalDateTime dateRealisation) {
        this.dateRealisation = dateRealisation;
    }

    public String getResultats() {
        return resultats;
    }

    public void setResultats(String resultats) {
        this.resultats = resultats;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }
}
