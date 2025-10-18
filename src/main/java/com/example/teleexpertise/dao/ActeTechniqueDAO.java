package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.ActeTechnique;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

/**
 * DAO pour ActeTechnique - Hérite de GenericDAOImpl
 */
public class ActeTechniqueDAO extends GenericDAOImpl<ActeTechnique> {

    public ActeTechniqueDAO() {
        super(ActeTechnique.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS

    /**
     * Trouver les actes techniques d'une consultation
     */
    public List<ActeTechnique> findByConsultationId(Long consultationId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.consultation.id = :consultationId",
                ActeTechnique.class
            );
            query.setParameter("consultationId", consultationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les actes par type
     */
    public List<ActeTechnique> findByType(String type) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<ActeTechnique> query = em.createQuery(
                "SELECT a FROM ActeTechnique a WHERE a.type = :type",
                ActeTechnique.class
            );
            query.setParameter("type", type);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
