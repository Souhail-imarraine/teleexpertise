package com.example.teleexpertise.dao;

import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.util.JpaUtil;
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
            .setParameter("email", email)  // Remplace :email par la valeur
            .getSingleResult();

        } catch (NoResultException e) {
            return null;
        }
    }

    public utilisateur authenticate(String email, String motDePasse) {
        utilisateur user = findByEmail(email);

        if (user != null && user.getMotDePasse().equals(motDePasse)) {
            // Identifiants corrects
            return user;
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
}

