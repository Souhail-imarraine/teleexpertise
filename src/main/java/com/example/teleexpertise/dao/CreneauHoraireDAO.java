package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.CreneauHoraire;
import com.example.teleexpertise.model.enums.StatutCreneau;
import com.example.teleexpertise.util.JpaUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
     * Trouver les créneaux d'un spécialiste (ordre par dateDebut)
     */
    public List<CreneauHoraire> findBySpecialisteId(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                    "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId ORDER BY c.dateDebut",
                    CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver les créneaux disponibles d'un spécialiste (statut DISPONIBLE et dateDebut >= maintenant)
     */
    public List<CreneauHoraire> findDisponiblesBySpecialiste(Long specialisteId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                    "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                            "AND c.statut = :statut AND c.dateDebut >= :now ORDER BY c.dateDebut",
                    CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("statut", StatutCreneau.DISPONIBLE);
            query.setParameter("now", LocalDateTime.now());
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un créneau par date et heure pour un spécialiste
     * (on compare la dateDebut exacte construite à partir de date + heureDebut)
     */
    public CreneauHoraire findByDateAndHeure(Long specialisteId, LocalDate date, LocalTime heureDebut) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            LocalDateTime start = LocalDateTime.of(date, heureDebut);
            TypedQuery<CreneauHoraire> query = em.createQuery(
                    "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                            "AND c.dateDebut = :start",
                    CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("start", start);
            List<CreneauHoraire> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver créneaux pour un spécialiste correspondant exactement à (debut, fin)
     * (service anciennement appelait findBySpecialisteAndDate(specialisteId, debut, fin))
     */
    public List<CreneauHoraire> findBySpecialisteAndDate(Long specialisteId, LocalDateTime debut, LocalDateTime fin) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                    "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                            "AND c.dateDebut = :debut AND c.dateFin = :fin",
                    CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("debut", debut);
            query.setParameter("fin", fin);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    /**
     * Trouver tous les créneaux d'un spécialiste qui intersectent une période donnée
     * (utilisé pour détecter les overlaps / récupérer créneaux dans une plage)
     *
     * Condition d'intersection :
     *   c.dateDebut < :end AND c.dateFin > :start
     */
    public List<CreneauHoraire> findBySpecialisteAndPeriode(Long specialisteId, LocalDateTime start, LocalDateTime end) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<CreneauHoraire> query = em.createQuery(
                    "SELECT c FROM CreneauHoraire c WHERE c.specialiste.id = :specialisteId " +
                            "AND c.dateDebut < :end AND c.dateFin > :start ORDER BY c.dateDebut",
                    CreneauHoraire.class
            );
            query.setParameter("specialisteId", specialisteId);
            query.setParameter("start", start);
            query.setParameter("end", end);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
