package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.util.JpaUtil;
import com.example.teleexpertise.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

/**
 * DAO pour l'entité utilisateur - Hérite de GenericDAOImpl
 */
public class UtilisateurDAO extends GenericDAOImpl<utilisateur> {

    public UtilisateurDAO() {
        super(utilisateur.class);
    }

    // ✅ save(), update(), findById(), findAll(), deleteById() sont HÉRITÉS

    /**
     * Trouver un utilisateur par email
     */
    public utilisateur findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                            "SELECT u FROM utilisateur u WHERE u.email = :email",
                            utilisateur.class
                    )
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    /**
     * Authentifier un utilisateur
     */
    public utilisateur authenticate(String email, String motDePasse) {
        utilisateur user = findByEmail(email);
        if (user != null) {
            // Utiliser BCrypt pour vérifier le mot de passe
            if (PasswordUtil.checkPassword(motDePasse, user.getMotDePasse())) {
                System.out.println("✅ Authentification réussie pour: " + email);
                return user;
            } else {
                System.out.println("❌ Mot de passe incorrect pour: " + email);
            }
        } else {
            System.out.println("❌ Email introuvable: " + email);
        }
        return null;
    }

    /**
     * Trouver un infirmier par ID
     */
    public Infirmier findInfirmierById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Infirmier.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un généraliste par ID
     */
    public Generaliste findGeneralisteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Generaliste.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un spécialiste par ID
     */
    public Specialiste findSpecialisteById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Specialiste.class, id);
        } finally {
            em.close();
        }
    }

    /**
     * Trouver un utilisateur par ID et rôle
     */
    public utilisateur findByIdAndRole(Long id, String role) {
        switch (role.toUpperCase()) {
            case "INFIRMIER":
                return findInfirmierById(id);
            case "GENERALISTE":
            case "MEDECIN":
                return findGeneralisteById(id);
            case "SPECIALISTE":
                return findSpecialisteById(id);
            default:
                return null;
        }
    }
}
