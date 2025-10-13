package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.UtilisateurDAO;
import com.example.teleexpertise.model.utilisateur;

public class AuthService {

    private UtilisateurDAO utilisateurDAO;

    public AuthService() {
        this.utilisateurDAO = new UtilisateurDAO();
    }

    public utilisateur login(String email, String motDePasse) {
        // Validation des entrées
        if(isValidEmail(email)){
            System.out.println("✅ Email valide");
        }

        if (isValidPassword(motDePasse)) {
            System.out.println("❌ Mot de passe vide");
            return null;
        }

        utilisateur user = utilisateurDAO.authenticate(email.trim(), motDePasse);

        if (user != null) {
            System.out.println("✅ Authentification réussie pour : " + user.getEmail());
            System.out.println("   Rôle : " + user.getRole());
        } else {
            System.out.println("❌ Échec authentification pour : " + email);
        }

        return user;
    }


    public utilisateur getUserByIdAndRole(int id, String role) {
        return utilisateurDAO.findByIdAndRole(id, role);
    }


    public boolean isValidEmail(String email) {
        return email != null &&
               email.contains("@") &&
               email.contains(".") &&
               email.length() > 5;
    }


    public boolean isValidPassword(String motDePasse) {
        return motDePasse != null && motDePasse.length() >= 6;
    }
}
