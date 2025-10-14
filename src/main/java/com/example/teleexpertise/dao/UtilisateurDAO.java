package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.util.JpaUtil;
import com.example.teleexpertise.util.PasswordUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;


public class UtilisateurDAO {

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
        }
    }

    public utilisateur authenticate(String email, String motDePasse) {
        utilisateur user = findByEmail(email);

        if (user != null) {
            // Utiliser BCrypt pour vérifier le mot de passe
            if (PasswordUtil.checkPassword(motDePasse, user.getMotDePasse())) {
                // Mot de passe correct
                return user;
            }
        }
        // Email ou mot de passe incorrect
        return null;
    }

    public Infirmier findInfirmierById(int id) {
        EntityManager em = JpaUtil.getEntityManager();
        return em.find(Infirmier.class, id);
    }

    public Generaliste findGeneralisteById(int id) {
        EntityManager em = JpaUtil.getEntityManager();
        return em.find(Generaliste.class, id);
    }

    public Specialiste findSpecialisteById(int id) {
        EntityManager em = JpaUtil.getEntityManager();
        return em.find(Specialiste.class, id);
    }

    public utilisateur findByIdAndRole(int id, String role) {
        switch (role) {
            case "INFIRMIER":
                return findInfirmierById(id);
            case "GENERALISTE":
                return findGeneralisteById(id);
            case "SPECIALISTE":
                return findSpecialisteById(id);
            default:
                return null;
        }
    }

    public void save(utilisateur user) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            System.out.println("Utilisateur sauvegardé avec succès dans la BD");
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            System.err.println("Erreur lors de la sauvegarde: " + e.getMessage());
            throw e;
        } finally {
            em.close();
        }
    }
}
