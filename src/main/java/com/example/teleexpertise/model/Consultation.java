package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import com.example.teleexpertise.model.enums.StatutConsultation;

@Entity
@Table(name = "consultations")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "generaliste_id", nullable = false)
    private Generaliste generaliste;

    @Column(nullable = false)
    private LocalDateTime dateConsultation;

    @Column(nullable = false, length = 500)
    private String motif;

    @Column(length = 2000)
    private String observations;

    @Column(length = 1000)
    private String diagnostic;

    @Column(length = 2000)
    private String traitement;

    private Double coutBase = 150.0;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutConsultation statut;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<ActeTechnique> actesTechniques = new ArrayList<>();

    @OneToOne(mappedBy = "consultation", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private DemandeExpertise demandeExpertise;

    // Constructeurs
    public Consultation() {
    }

    public Consultation(Patient patient, Generaliste generaliste, String motif) {
        this.patient = patient;
        this.generaliste = generaliste;
        this.motif = motif;
        this.dateConsultation = LocalDateTime.now();
        this.statut = StatutConsultation.EN_COURS;
    }

    // Méthode pour calculer le coût total avec Lambda
    public Double calculerCoutTotal() {
        double coutActes = actesTechniques.stream()
            .mapToDouble(ActeTechnique::getPrix)
            .sum();

        double coutExpertise = (demandeExpertise != null && demandeExpertise.getSpecialiste() != null)
            ? demandeExpertise.getSpecialiste().getTarif()
            : 0.0;

        return coutBase + coutActes + coutExpertise;
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Generaliste getGeneraliste() {
        return generaliste;
    }

    public void setGeneraliste(Generaliste generaliste) {
        this.generaliste = generaliste;
    }

    public LocalDateTime getDateConsultation() {
        return dateConsultation;
    }

    public void setDateConsultation(LocalDateTime dateConsultation) {
        this.dateConsultation = dateConsultation;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getObservations() {
        return observations;
    }

    public void setObservations(String observations) {
        this.observations = observations;
    }

    public String getDiagnostic() {
        return diagnostic;
    }

    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }

    public String getTraitement() {
        return traitement;
    }

    public void setTraitement(String traitement) {
        this.traitement = traitement;
    }

    public Double getCoutBase() {
        return coutBase;
    }

    public void setCoutBase(Double coutBase) {
        this.coutBase = coutBase;
    }

    public StatutConsultation getStatut() {
        return statut;
    }

    public void setStatut(StatutConsultation statut) {
        this.statut = statut;
    }

    public List<ActeTechnique> getActesTechniques() {
        return actesTechniques;
    }

    public void setActesTechniques(List<ActeTechnique> actesTechniques) {
        this.actesTechniques = actesTechniques;
    }

    public DemandeExpertise getDemandeExpertise() {
        return demandeExpertise;
    }

    public void setDemandeExpertise(DemandeExpertise demandeExpertise) {
        this.demandeExpertise = demandeExpertise;
    }
}
