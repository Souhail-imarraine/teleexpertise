package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ConsultationDAO;
import com.example.teleexpertise.dao.CreneauHoraireDAO;
import com.example.teleexpertise.dao.DemandeExpertiseDAO;
import com.example.teleexpertise.dao.GeneralisteDAO;
import com.example.teleexpertise.dao.SpecialisteDAO;
import com.example.teleexpertise.model.*;
import com.example.teleexpertise.model.enums.ModeExpertise;
import com.example.teleexpertise.model.enums.PrioriteExpertise;
import com.example.teleexpertise.model.enums.StatutConsultation;
import com.example.teleexpertise.model.enums.StatutExpertise;
import com.example.teleexpertise.model.enums.TypeSpecialite;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * Service pour gérer les opérations métier du médecin généraliste
 */
public class GeneralisteService {

    private final ConsultationDAO consultationDAO;
    private final SpecialisteDAO specialisteDAO;
    private final GeneralisteDAO generalisteDAO;
    private final CreneauHoraireDAO creneauHoraireDAO;
    private final DemandeExpertiseDAO demandeExpertiseDAO;

    public GeneralisteService() {
        this.consultationDAO = new ConsultationDAO();
        this.specialisteDAO = new SpecialisteDAO();
        this.generalisteDAO = new GeneralisteDAO();
        this.creneauHoraireDAO = new CreneauHoraireDAO();
        this.demandeExpertiseDAO = new DemandeExpertiseDAO();
    }

    public Consultation obtenirConsultation(int consultationId) {
        Optional<Consultation> consultationOpt = consultationDAO.findById((long) consultationId);
        if (consultationOpt.isEmpty()) {
            throw new IllegalArgumentException("Consultation introuvable avec l'ID: " + consultationId);
        }
        return consultationOpt.get();
    }


    public List<Specialiste> obtenirSpecialistesParSpecialite(TypeSpecialite specialite) {
        if (specialite == null) {
            throw new IllegalArgumentException("La spécialité est obligatoire");
        }

        return specialisteDAO.findAll().stream()
                .filter(s -> s.getSpecialite() == specialite)
                .sorted((s1, s2) -> Double.compare(s1.getTarif(), s2.getTarif()))
                .collect(Collectors.toList());
    }

    /**
     * Récupérer les créneaux disponibles d'un spécialiste
     */
    public List<CreneauHoraire> obtenirCreneauxDisponibles(int specialisteId) {
        LocalDateTime maintenant = LocalDateTime.now();

        return creneauHoraireDAO.findBySpecialisteId((long) specialisteId).stream()
                .filter(c -> c.getStatut().toString().equals("DISPONIBLE"))
                .filter(c -> c.getDateDebut().isAfter(maintenant))
                .sorted((c1, c2) -> c1.getDateDebut().compareTo(c2.getDateDebut()))
                .collect(Collectors.toList());
    }

    /**
     * Créer une demande d'expertise
     */
    public DemandeExpertise creerDemandeExpertise(
            int consultationId,
            int generalisteId,
            int specialisteId,
            int creneauId,
            String prioriteStr,
            String question,
            String donneesAnalyses,
            String modeExpertise
    ) {
        // 1. Validation des paramètres
        if (question == null || question.trim().isEmpty()) {
            throw new IllegalArgumentException("La question est obligatoire");
        }

        // 2. Récupérer les entités
        Consultation consultation = obtenirConsultation(consultationId);

        Optional<Generaliste> generalisteOpt = generalisteDAO.findById((long) generalisteId);
        if (generalisteOpt.isEmpty()) {
            throw new IllegalArgumentException("Généraliste introuvable");
        }
        Generaliste generaliste = generalisteOpt.get();

        Optional<Specialiste> specialisteOpt = specialisteDAO.findById((long) specialisteId);
        if (specialisteOpt.isEmpty()) {
            throw new IllegalArgumentException("Spécialiste introuvable");
        }
        Specialiste specialiste = specialisteOpt.get();

        Optional<CreneauHoraire> creneauOpt = creneauHoraireDAO.findById((long) creneauId);
        if (creneauOpt.isEmpty()) {
            throw new IllegalArgumentException("Créneau introuvable");
        }
        CreneauHoraire creneau = creneauOpt.get();

        // 3. Vérifier que le créneau est disponible
        if (!creneau.getStatut().toString().equals("DISPONIBLE")) {
            throw new IllegalArgumentException("Ce créneau n'est plus disponible");
        }

        // 4. Créer la demande d'expertise
        DemandeExpertise demande = new DemandeExpertise();
        demande.setConsultation(consultation);
        demande.setGeneraliste(generaliste);
        demande.setSpecialiste(specialiste);
        demande.setCreneauHoraire(creneau);
        demande.setPriorite(PrioriteExpertise.valueOf(prioriteStr));
        demande.setQuestionPosee(question.trim());
        demande.setDonneesAnalyses(donneesAnalyses != null ? donneesAnalyses.trim() : null);
        demande.setModeExpertise(modeExpertise != null ? ModeExpertise.valueOf(modeExpertise) : null);
        demande.setDateCreation(LocalDateTime.now());
        demande.setStatut(StatutExpertise.EN_ATTENTE);

        // 5. Sauvegarder la demande
        DemandeExpertise savedDemande = demandeExpertiseDAO.save(demande);

        // 6. Mettre à jour le statut de la consultation
        consultation.setStatut(StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE);
        consultationDAO.update(consultation);

        return savedDemande;
    }

    /**
     * Récupérer toutes les demandes d'expertise d'un généraliste
     */
    public List<DemandeExpertise> obtenirDemandesExpertise(int generalisteId) {
        return demandeExpertiseDAO.findAll().stream()
                .filter(d -> d.getGeneraliste() != null && d.getGeneraliste().getId() == generalisteId)
                .sorted((d1, d2) -> d2.getDateCreation().compareTo(d1.getDateCreation()))
                .collect(Collectors.toList());
    }


    public DemandeExpertise obtenirDemandeExpertise(int demandeId) {
        Optional<DemandeExpertise> demandeOpt = demandeExpertiseDAO.findById((long) demandeId);
        if (demandeOpt.isEmpty()) {
            throw new IllegalArgumentException("Demande d'expertise introuvable avec l'ID: " + demandeId);
        }
        return demandeOpt.get();
    }
}
