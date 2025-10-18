package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

/**
 * DAO pour DemandeExpertise - Hérite de GenericDAOImpl
 */
public class DemandeExpertiseDAO extends GenericDAOImpl<DemandeExpertise> {

    public DemandeExpertiseDAO() {
        super(DemandeExpertise.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS

    /**
     * Trouver les demandes d'expertise d'un généraliste
     */
    public List<DemandeExpertise> findByGeneralisteId(Long generalisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.consultation.generaliste.id = :generalisteId ORDER BY d.dateCreation DESC",
                DemandeExpertise.class
            );
            query.setParameter("generalisteId", generalisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les demandes d'expertise pour un spécialiste
     */
    public List<DemandeExpertise> findBySpecialisteId(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.specialiste.id = :specialisteId ORDER BY d.dateCreation DESC",
                DemandeExpertise.class
            );
            query.setParameter("specialisteId", specialisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les demandes par statut
     */
    public List<DemandeExpertise> findByStatut(String statut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.statut = :statut ORDER BY d.dateCreation DESC",
                DemandeExpertise.class
            );
            query.setParameter("statut", statut);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les demandes par priorité
     */
    public List<DemandeExpertise> findByPriorite(String priorite) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.priorite = :priorite ORDER BY d.dateCreation DESC",
                DemandeExpertise.class
            );
            query.setParameter("priorite", priorite);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les demandes urgentes en attente
     */
    public List<DemandeExpertise> findUrgentesEnAttente() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<DemandeExpertise> query = em.createQuery(
                "SELECT d FROM DemandeExpertise d WHERE d.priorite = 'URGENTE' AND d.statut = 'EN_ATTENTE' ORDER BY d.dateCreation ASC",
                DemandeExpertise.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
