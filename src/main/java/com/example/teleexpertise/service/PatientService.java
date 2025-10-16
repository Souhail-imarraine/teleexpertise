package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.PatientDAO;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.enums.StatutPatient;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Service pour gérer la logique métier des patients
 */
public class PatientService {

    private final PatientDAO patientDAO;

    public PatientService() {
        this.patientDAO = new PatientDAO();
    }

    public Patient creerPatient(Patient patient) {
        // Validation des données obligatoires
        if (patient.getNom() == null || patient.getNom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le nom est obligatoire");
        }

        if (patient.getPrenom() == null || patient.getPrenom().trim().isEmpty()) {
            throw new IllegalArgumentException("Le prénom est obligatoire");
        }

        if (patient.getNumeroSecuriteSociale() == null || patient.getNumeroSecuriteSociale().trim().isEmpty()) {
            throw new IllegalArgumentException("Le numéro de sécurité sociale est obligatoire");
        }

        // Vérifier si le patient existe déjà
        Patient existant = patientDAO.findByNumeroSecuriteSociale(patient.getNumeroSecuriteSociale());
        if (existant != null) {
            throw new IllegalArgumentException("Un patient avec ce numéro de sécurité sociale existe déjà");
        }

        // Initialiser les données automatiques
        patient.setRole("PATIENT");
        patient.setDateEnregistrement(LocalDate.now());
        patient.setHeureArrivee(LocalDateTime.now());
        patient.setStatut(StatutPatient.EN_ATTENTE);

        // Sauvegarder le patient
        patientDAO.save(patient);

        return patient;
    }

    public Patient mettreAJourSignesVitaux(Long patientId, String tensionArterielle,
                                           Integer frequenceCardiaque, Double temperature,
                                           Integer frequenceRespiratoire, Double poids, Double taille) {
        Patient patient = patientDAO.findById(patientId);

        if (patient == null) {
            throw new IllegalArgumentException("Patient introuvable");
        }

        // Mettre à jour les signes vitaux
        patient.setTensionArterielle(tensionArterielle);
        patient.setFrequenceCardiaque(frequenceCardiaque);
        patient.setTemperature(temperature);
        patient.setFrequenceRespiratoire(frequenceRespiratoire);
        patient.setPoids(poids);
        patient.setTaille(taille);

        // Mettre à jour l'heure d'arrivée
        patient.setHeureArrivee(LocalDateTime.now());
        patient.setDateEnregistrement(LocalDate.now());
        patient.setStatut(StatutPatient.EN_ATTENTE);

        patientDAO.update(patient);
        return patient;
    }


    public Patient rechercherParNumeroSS(String numeroSS) {
        if (numeroSS == null || numeroSS.trim().isEmpty()) {
            throw new IllegalArgumentException("Le numéro de sécurité sociale est requis");
        }

        return patientDAO.findByNumeroSecuriteSociale(numeroSS.trim());
    }


    public List<Patient> rechercherParNomOuPrenom(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return List.of();
        }

        return patientDAO.findByNomOrPrenom(searchTerm.trim());
    }


    public List<Patient> obtenirTousLesPatients() {
        return patientDAO.findAll();
    }


    public List<Patient> obtenirPatientsAujourdhui() {
        return patientDAO.findPatientsAujourdhui();
    }


    public Patient obtenirPatientParId(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("L'ID du patient est requis");
        }

        Patient patient = patientDAO.findById(id);
        if (patient == null) {
            throw new IllegalArgumentException("Patient introuvable avec l'ID: " + id);
        }

        return patient;
    }


    public void ajouterALaFileAttente(Long patientId) {
        Patient patient = obtenirPatientParId(patientId);
        patient.setStatut(StatutPatient.EN_ATTENTE);
        patient.setHeureArrivee(LocalDateTime.now());
        patientDAO.update(patient);
    }

    public long compterPatientsAujourdhui() {
        return patientDAO.countPatientsAujourdhui();
    }
}
