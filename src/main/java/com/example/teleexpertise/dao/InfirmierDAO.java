package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

/**
 * DAO pour Infirmier - Hérite de GenericDAOImpl
 */
public class InfirmierDAO extends GenericDAOImpl<Infirmier> {

    public InfirmierDAO() {
        super(Infirmier.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS
    // Pas besoin de les réécrire !

    /**
     * Trouver un infirmier par email
     */
    public Infirmier findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Infirmier> query = em.createQuery(
                "SELECT i FROM Infirmier i WHERE i.email = :email",
                Infirmier.class
            );
            query.setParameter("email", email);
            List<Infirmier> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}