package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.CreneauHoraire;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

/**
 * DAO pour CreneauHoraire - Hérite de GenericDAOImpl
 */
public class CreneauHoraireDAO extends GenericDAOImpl<CreneauHoraire> {

    public CreneauHoraireDAO() {
        super(CreneauHoraire.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS

    /**
     * Trouver les créneaux d'un spécialiste
     */
    public List<CreneauHoraire> findBySpecialisteId(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId ORDER BY c.date, c.heureDebut",
                CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les créneaux disponibles d'un spécialiste
     */
    public List<CreneauHoraire> findDisponiblesBySpecialiste(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                "AND c.statut = 'DISPONIBLE' AND c.date >= :today ORDER BY c.date, c.heureDebut",
                CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un créneau par date et heure pour un spécialiste
     */
    public CreneauHoraire findByDateAndHeure(Long specialisteId, LocalDate date, LocalTime heureDebut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                "AND c.date = :date AND c.heureDebut = :heureDebut",
                CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("date", date);
            query.setParameter("heureDebut", heureDebut);
            List<CreneauHoraire> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }
}
