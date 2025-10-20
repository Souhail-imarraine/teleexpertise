package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

/**
 * DAO pour Consultation - Hérite de GenericDAOImpl
 */
public class ConsultationDAO extends GenericDAOImpl<Consultation> {

    public ConsultationDAO() {
        super(Consultation.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS

    /**
     * Trouver toutes les consultations d'un patient
     */
    public List<Consultation> findByPatientId(Long patientId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.patient.id = :patientId ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver toutes les consultations d'un généraliste
     * ✅ JOIN FETCH pour charger le patient, demandeExpertise ET actesTechniques
     */
    public List<Consultation> findByGeneralisteId(Long generalisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c " +
                "JOIN FETCH c.patient " +
                "LEFT JOIN FETCH c.demandeExpertise " +
                "LEFT JOIN FETCH c.actesTechniques " +
                "WHERE c.generaliste.id = :generalisteId " +
                "ORDER BY c.dateConsultation DESC",
                Consultation.class
            );
            query.setParameter("generalisteId", generalisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les consultations par statut
     */
    public List<Consultation> findByStatut(String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c WHERE c.statut = :statut",
                Consultation.class
            );
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver une consultation par ID avec tous les détails chargés (patient, généraliste, etc.)
     * ✅ JOIN FETCH pour éviter LazyInitializationException
     */
    public Consultation findByIdWithDetails(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Consultation> query = em.createQuery(
                "SELECT c FROM Consultation c " +
                "JOIN FETCH c.patient " +
                "JOIN FETCH c.generaliste " +
                "LEFT JOIN FETCH c.demandeExpertise " +
                "LEFT JOIN FETCH c.actesTechniques " +
                "WHERE c.id = :id",
                Consultation.class
            );
            query.setParameter("id", id);
            Consultation result = query.getSingleResult();
            System.out.println("✅ DAO: Consultation trouvée avec ID " + id);
            return result;
        } catch (jakarta.persistence.NoResultException e) {
            System.out.println("⚠️ DAO: Aucune consultation trouvée avec ID " + id);
            return null;
        } catch (Exception e) {
            System.out.println("❌ DAO: Erreur lors du chargement de la consultation ID " + id);
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }
}
