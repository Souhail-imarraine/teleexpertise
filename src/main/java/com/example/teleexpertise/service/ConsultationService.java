package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.ConsultationDAO;
import com.example.teleexpertise.dao.GeneralisteDAO;
import com.example.teleexpertise.dao.PatientDAO;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.enums.StatutConsultation;
import com.example.teleexpertise.model.enums.StatutPatient;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class ConsultationService {

    private final ConsultationDAO consultationDAO;
    private final PatientDAO patientDAO;
    private final GeneralisteDAO generalisteDAO;

    public ConsultationService() {
        this.consultationDAO = new ConsultationDAO();
        this.patientDAO = new PatientDAO();
        this.generalisteDAO = new GeneralisteDAO();
    }

    /**
     * Créer une nouvelle consultation
     */
    public Consultation creerConsultation(Long patientId, Long generalisteId,
                                          String motif, String symptomes,
                                          String examenClinique, String observations,
                                          String diagnostic, String traitement) {
        // 1. Validation des données obligatoires
        if (motif == null || motif.trim().isEmpty()) {
            throw new IllegalArgumentException("Le motif de consultation est obligatoire");
        }

        // 2. Récupérer le patient
        Optional<Patient> optionalPatient = patientDAO.findById(patientId);
        if (optionalPatient.isEmpty()) {
            throw new IllegalArgumentException("Patient introuvable avec l'ID: " + patientId);
        }
        Patient patient = optionalPatient.get();

        // 3. Récupérer le généraliste
        Optional<Generaliste> optionalGeneraliste = generalisteDAO.findById(generalisteId);
        if (optionalGeneraliste.isEmpty()) {
            throw new IllegalArgumentException("Généraliste introuvable avec l'ID: " + generalisteId);
        }
        Generaliste generaliste = optionalGeneraliste.get();

        // 4. Créer la consultation
        Consultation consultation = new Consultation();
        consultation.setPatient(patient);
        consultation.setGeneraliste(generaliste);
        consultation.setMotif(motif.trim());

        // ✅ Combiner symptômes, examen clinique et observations dans le champ observations
        StringBuilder observationsCompletes = new StringBuilder();
        if (symptomes != null && !symptomes.trim().isEmpty()) {
            observationsCompletes.append("SYMPTÔMES:\n").append(symptomes.trim()).append("\n\n");
        }
        if (examenClinique != null && !examenClinique.trim().isEmpty()) {
            observationsCompletes.append("EXAMEN CLINIQUE:\n").append(examenClinique.trim()).append("\n\n");
        }
        if (observations != null && !observations.trim().isEmpty()) {
            observationsCompletes.append("OBSERVATIONS:\n").append(observations.trim());
        }

        consultation.setObservations(observationsCompletes.length() > 0 ? observationsCompletes.toString() : null);
        consultation.setDiagnostic(diagnostic != null && !diagnostic.trim().isEmpty()
            ? diagnostic.trim() : null);
        consultation.setTraitement(traitement != null && !traitement.trim().isEmpty()
            ? traitement.trim() : null);
        consultation.setDateConsultation(LocalDateTime.now());
        consultation.setCoutBase(150.0); // Coût fixe pour consultation généraliste

        // 5. Déterminer le statut
        if (diagnostic != null && !diagnostic.trim().isEmpty() &&
            traitement != null && !traitement.trim().isEmpty()) {
            consultation.setStatut(StatutConsultation.TERMINEE);
        } else {
            consultation.setStatut(StatutConsultation.EN_COURS);
        }

        // 6. Sauvegarder la consultation
        Consultation savedConsultation = consultationDAO.save(consultation);

        // 7. Mettre à jour le statut du patient
        patient.setStatut(StatutPatient.EN_CONSULTATION);
        patientDAO.update(patient);

        return savedConsultation;
    }

    /**
     * Obtenir toutes les consultations d'un patient
     */
    public List<Consultation> obtenirConsultationsParPatient(Long patientId) {
        if (patientId == null) {
            throw new IllegalArgumentException("L'ID du patient est requis");
        }
        return consultationDAO.findByPatientId(patientId);
    }

    /**
     * Obtenir toutes les consultations d'un généraliste
     */
    public List<Consultation> obtenirConsultationsParGeneraliste(Long generalisteId) {
        if (generalisteId == null) {
            throw new IllegalArgumentException("L'ID du généraliste est requis");
        }
        return consultationDAO.findByGeneralisteId(generalisteId);
    }

    /**
     * Obtenir une consultation par son ID
     * ✅ Charge toutes les relations (patient, généraliste) pour éviter LazyInitializationException
     */
    public Consultation obtenirConsultationParId(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("L'ID de la consultation est requis");
        }

        Consultation consultation = consultationDAO.findByIdWithDetails(id);
        if (consultation == null) {
            throw new IllegalArgumentException("Consultation introuvable avec l'ID: " + id);
        }
        return consultation;
    }

    /**
     * Mettre à jour une consultation
     */
    public Consultation mettreAJourConsultation(Long consultationId, String diagnostic, String traitement) {
        Consultation consultation = obtenirConsultationParId(consultationId);

        if (diagnostic != null && !diagnostic.trim().isEmpty()) {
            consultation.setDiagnostic(diagnostic.trim());
        }

        if (traitement != null && !traitement.trim().isEmpty()) {
            consultation.setTraitement(traitement.trim());
        }

        // Si diagnostic et traitement sont renseignés, la consultation est terminée
        if (consultation.getDiagnostic() != null && consultation.getTraitement() != null) {
            consultation.setStatut(StatutConsultation.TERMINEE);

            // Mettre à jour le statut du patient
            Patient patient = consultation.getPatient();
            patient.setStatut(StatutPatient.TERMINE);
            patientDAO.update(patient);
        }

        return consultationDAO.update(consultation);
    }

    /**
     * Clôturer une consultation
     */
    public void cloturerConsultation(Long consultationId) {
        Consultation consultation = obtenirConsultationParId(consultationId);

        if (consultation.getDiagnostic() == null || consultation.getDiagnostic().trim().isEmpty()) {
            throw new IllegalArgumentException("Un diagnostic est requis pour clôturer la consultation");
        }

        consultation.setStatut(StatutConsultation.TERMINEE);
        consultationDAO.update(consultation);

        // Mettre à jour le statut du patient
        Patient patient = consultation.getPatient();
        patient.setStatut(StatutPatient.TERMINE);
        patientDAO.update(patient);
    }

    public List<Consultation> obtenirToutesLesConsultations() {
        return consultationDAO.findAll();
    }
}
