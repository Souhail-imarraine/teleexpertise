package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * DAO pour l'entité Patient
 */
public class PatientDAO {

    /**
     * Sauvegarder un patient
     */
    public void save(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = null;

        try {
            transaction = em.getTransaction();
            transaction.begin();
            em.persist(patient);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la sauvegarde du patient", e);
        } finally {
            em.close();
        }
    }

    /**
     * Mettre à jour un patient
     */
    public void update(Patient patient) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = null;

        try {
            transaction = em.getTransaction();
            transaction.begin();
            em.merge(patient);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la mise à jour du patient", e);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un patient par son ID
     */
    public Patient findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Patient.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Récupérer tous les patients
     */
    public List<Patient> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Supprimer un patient
     */
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction transaction = null;

        try {
            transaction = em.getTransaction();
            transaction.begin();

            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Erreur lors de la suppression du patient", e);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un patient par son numéro de sécurité sociale
     */
    public Patient findByNumeroSecuriteSociale(String numeroSS) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE p.numeroSecuriteSociale = :numeroSS",
                Patient.class
            );
            query.setParameter("numeroSS", numeroSS);

            List<Patient> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche du patient: " + e.getMessage());
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les patients enregistrés à une date donnée
     * Utilise Stream API pour filtrer
     */
    public List<Patient> findByDateEnregistrement(LocalDate date) {
        List<Patient> allPatients = findAll();

        // STREAM API - Filtrer par date d'enregistrement
        return allPatients.stream()
            .filter(p -> p.getDateEnregistrement() != null &&
                        p.getDateEnregistrement().equals(date))
            .sorted((p1, p2) -> {
                if (p1.getHeureArrivee() != null && p2.getHeureArrivee() != null) {
                    return p1.getHeureArrivee().compareTo(p2.getHeureArrivee());
                }
                return 0;
            })
            .collect(Collectors.toList());
    }

    /**
     * Rechercher des patients par nom ou prénom
     */
    public List<Patient> findByNomOrPrenom(String searchTerm) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE " +
                "LOWER(p.nom) LIKE LOWER(:searchTerm) OR " +
                "LOWER(p.prenom) LIKE LOWER(:searchTerm) " +
                "ORDER BY p.nom, p.prenom",
                Patient.class
            );
            query.setParameter("searchTerm", "%" + searchTerm + "%");

            return query.getResultList();

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche: " + e.getMessage());
            return List.of();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les patients d'aujourd'hui
     */
    public List<Patient> findPatientsAujourdhui() {
        return findByDateEnregistrement(LocalDate.now());
    }

    /**
     * Compter les patients enregistrés aujourd'hui
     */
    public long countPatientsAujourdhui() {
        return findPatientsAujourdhui().size();
    }
}
