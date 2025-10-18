package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

/**
 * DAO pour Generaliste - Hérite de GenericDAOImpl
 */
public class GeneralisteDAO extends GenericDAOImpl<Generaliste> {

    public GeneralisteDAO() {
        super(Generaliste.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS
    // Pas besoin de les réécrire !

    /**
     * Trouver un généraliste par email
     */
    public Generaliste findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Generaliste> query = em.createQuery(
                "SELECT g FROM Generaliste g WHERE g.email = :email",
                Generaliste.class
            );
            query.setParameter("email", email);
            List<Generaliste> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}
