package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import com.example.teleexpertise.model.enums.PrioriteExpertise;
import com.example.teleexpertise.model.enums.StatutExpertise;
import com.example.teleexpertise.model.enums.ModeExpertise;

@Entity
@Table(name = "demandes_expertise")
public class DemandeExpertise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "consultation_id", nullable = false, unique = true)
    private Consultation consultation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "generaliste_id", nullable = false)
    private Generaliste generaliste;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialiste_id", nullable = false)
    private Specialiste specialiste;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "creneau_id")
    private CreneauHoraire creneauHoraire;

    @Column(nullable = false, length = 2000)
    private String questionPosee;

    @Column(length = 2000)
    private String donneesAnalyses;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PrioriteExpertise priorite;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutExpertise statut;

    @Column(nullable = false)
    private LocalDateTime dateCreation;

    @Column(length = 3000)
    private String avisMedical;

    @Column(length = 3000)
    private String recommandations;

    private LocalDateTime dateReponse;

    @Enumerated(EnumType.STRING)
    private ModeExpertise modeExpertise;

    // Constructeurs
    public DemandeExpertise() {
    }

    public DemandeExpertise(Consultation consultation, Generaliste generaliste, Specialiste specialiste,
                           String questionPosee, PrioriteExpertise priorite) {
        this.consultation = consultation;
        this.generaliste = generaliste;
        this.specialiste = specialiste;
        this.questionPosee = questionPosee;
        this.priorite = priorite;
        this.statut = StatutExpertise.EN_ATTENTE;
        this.dateCreation = LocalDateTime.now();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Consultation getConsultation() {
        return consultation;
    }

    public void setConsultation(Consultation consultation) {
        this.consultation = consultation;
    }

    public Generaliste getGeneraliste() {
        return generaliste;
    }

    public void setGeneraliste(Generaliste generaliste) {
        this.generaliste = generaliste;
    }

    public Specialiste getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(Specialiste specialiste) {
        this.specialiste = specialiste;
    }

    public CreneauHoraire getCreneauHoraire() {
        return creneauHoraire;
    }

    public void setCreneauHoraire(CreneauHoraire creneauHoraire) {
        this.creneauHoraire = creneauHoraire;
    }

    public String getQuestionPosee() {
        return questionPosee;
    }

    public void setQuestionPosee(String questionPosee) {
        this.questionPosee = questionPosee;
    }

    public String getDonneesAnalyses() {
        return donneesAnalyses;
    }

    public void setDonneesAnalyses(String donneesAnalyses) {
        this.donneesAnalyses = donneesAnalyses;
    }

    public PrioriteExpertise getPriorite() {
        return priorite;
    }

    public void setPriorite(PrioriteExpertise priorite) {
        this.priorite = priorite;
    }

    public StatutExpertise getStatut() {
        return statut;
    }

    public void setStatut(StatutExpertise statut) {
        this.statut = statut;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }

    public String getAvisMedical() {
        return avisMedical;
    }

    public void setAvisMedical(String avisMedical) {
        this.avisMedical = avisMedical;
    }

    public String getRecommandations() {
        return recommandations;
    }

    public void setRecommandations(String recommandations) {
        this.recommandations = recommandations;
    }

    public LocalDateTime getDateReponse() {
        return dateReponse;
    }

    public void setDateReponse(LocalDateTime dateReponse) {
        this.dateReponse = dateReponse;
    }

    public ModeExpertise getModeExpertise() {
        return modeExpertise;
    }

    public void setModeExpertise(ModeExpertise modeExpertise) {
        this.modeExpertise = modeExpertise;
    }
}
