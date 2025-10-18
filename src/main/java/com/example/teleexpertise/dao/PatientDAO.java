package com.example.teleexpertise.dao;
import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * PatientDAO hérite de GenericDAOImpl
 */
public class PatientDAO extends GenericDAOImpl<Patient> {

    // Constructeur : on passe Patient.class au parent
    public PatientDAO() {
        super(Patient.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS
    // Pas besoin de les réécrire !

    // ⭐ Méthodes SPÉCIFIQUES à Patient

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
        } finally {
            em.close();
        }
    }

    public List<Patient> findByNomOrPrenom(String searchTerm) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Patient> query = em.createQuery(
                "SELECT p FROM Patient p WHERE " +
                "LOWER(p.nom) LIKE LOWER(:searchTerm) OR " +
                "LOWER(p.prenom) LIKE LOWER(:searchTerm)",
                Patient.class
            );
            query.setParameter("searchTerm", "%" + searchTerm + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Patient> findPatientsAujourdhui() {
        return findAll().stream()
            .filter(p -> p.getDateEnregistrement() != null &&
                        p.getDateEnregistrement().equals(LocalDate.now()))
            .sorted((p1, p2) -> {
                if (p1.getHeureArrivee() != null && p2.getHeureArrivee() != null) {
                    return p1.getHeureArrivee().compareTo(p2.getHeureArrivee());
                }
                return 0;
            })
            .collect(Collectors.toList());
    }
}