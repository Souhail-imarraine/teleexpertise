package com.example.teleexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import com.example.teleexpertise.model.enums.StatutCreneau;

@Entity
@Table(name = "creneaux_horaires")
public class CreneauHoraire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialiste_id", nullable = false)
    private Specialiste specialiste;

    @Column(nullable = false)
    private LocalDateTime dateDebut;

    @Column(nullable = false)
    private LocalDateTime dateFin;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutCreneau statut;

    @OneToOne(mappedBy = "creneauHoraire", fetch = FetchType.LAZY)
    private DemandeExpertise demandeExpertise;

    // Constructeurs
    public CreneauHoraire() {
    }

    public CreneauHoraire(Specialiste specialiste, LocalDateTime dateDebut, LocalDateTime dateFin) {
        this.specialiste = specialiste;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.statut = StatutCreneau.DISPONIBLE;
    }

    // Méthode pour vérifier si le créneau est passé
    public boolean estPasse() {
        return LocalDateTime.now().isAfter(dateFin);
    }

    // Méthode pour vérifier si le créneau est disponible
    public boolean estDisponible() {
        return statut == StatutCreneau.DISPONIBLE && !estPasse();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Specialiste getSpecialiste() {
        return specialiste;
    }

    public void setSpecialiste(Specialiste specialiste) {
        this.specialiste = specialiste;
    }

    public LocalDateTime getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDateTime getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }

    public StatutCreneau getStatut() {
        return statut;
    }

    public void setStatut(StatutCreneau statut) {
        this.statut = statut;
    }

    public DemandeExpertise getDemandeExpertise() {
        return demandeExpertise;
    }

    public void setDemandeExpertise(DemandeExpertise demandeExpertise) {
        this.demandeExpertise = demandeExpertise;
    }
}
