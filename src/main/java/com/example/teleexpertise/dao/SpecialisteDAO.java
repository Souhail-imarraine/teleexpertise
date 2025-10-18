package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class SpecialisteDAO extends GenericDAOImpl<Specialiste> {

    public SpecialisteDAO() {
        super(Specialiste.class);
    }

    // ✅ CRUD de base hérité automatiquement

    // Méthode spécifique : trouver par spécialité
    public List<Specialiste> findBySpecialite(String specialite) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Specialiste> query = em.createQuery(
                    "SELECT s FROM Specialiste s WHERE s.specialite = :specialite",
                    Specialiste.class
            );
            query.setParameter("specialite", specialite);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
