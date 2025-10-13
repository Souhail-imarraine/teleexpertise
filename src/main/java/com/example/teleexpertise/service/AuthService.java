package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.UtilisateurDAO;
import com.example.teleexpertise.model.utilisateur;

public class AuthService {

    private UtilisateurDAO utilisateurDAO;

    public AuthService() {
        this.utilisateurDAO = new UtilisateurDAO();
    }

//    public utilisateur login(String email, String motDePasse) {
//        // Validation des entrées
//        if(isValidEmail(email)){
//            System.out.println("✅ Email valide");
//        }
//
//        if (isValidPassword(motDePasse)) {
//            System.out.println("❌ Mot de passe vide");
//            return null;
//        }
//
//        utilisateur user = utilisateurDAO.authenticate(email.trim(), motDePasse);
//
//        if (user != null) {
//            System.out.println("✅ Authentification réussie pour : " + user.getEmail());
//            System.out.println("   Rôle : " + user.getRole());
//        } else {
//            System.out.println("❌ Échec authentification pour : " + email);
//        }
//
//        return user;
//    }
    public void register(String nom, String prenom, String email, String motDePasse, String role) throws Exception {
        // Validation des entrées
        validateName(nom);
        validateName(prenom);
        validateEmail(email);
        validatePassword(motDePasse);
        validRole(role);
        // Vérifier si l'email existe déjà
        if (utilisateurDAO.findByEmail(email) != null) {
            throw new Exception("Email déjà utilisé");
        }

        // Créer un nouvel utilisateur
        utilisateur newUser;
        switch (role.toUpperCase()) {
            case "INFIRMIER":
                newUser = new com.example.teleexpertise.model.Infirmier();
                break;
            case "GENERALISTE":
                newUser = new com.example.teleexpertise.model.Generaliste();
                break;
            case "SPECIALISTE":
                newUser = new com.example.teleexpertise.model.Specialiste();
                break;
            default:
                throw new Exception("Rôle invalide");
        }

        newUser.setNom(nom);
        newUser.setPrenom(prenom);
        newUser.setEmail(email);
        newUser.setMotDePasse(motDePasse);
        newUser.setRole(role.toUpperCase());

        // Sauvegarder l'utilisateur dans la base de données
//        utilisateurDAO.save(newUser);

    }

    public void validateEmail(String email) throws Exception {
        if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new Exception("Email invalide");
        }
    }

    public void validatePassword(String password) throws Exception {
        if (password == null || password.length() < 6) {
            throw new Exception("Le mot de passe doit contenir au moins 6 caractères");
        }
    }

    public void validateName(String name) throws Exception {
        if (name == null || name.trim().isEmpty()) {
            throw new Exception("Le nom ne peut pas être vide");
        }else if (!name.matches("^[a-zA-ZÀ-ÿ '-]+$")) {
            throw new Exception("Le nom contient des caractères invalides");
        }
    }

    public void validRole(String role) throws Exception {
        if (role == null || !(role.equalsIgnoreCase("INFIRMIER") || role.equalsIgnoreCase("GENERALISTE") || role.equalsIgnoreCase("SPECIALISTE"))) {
            throw new Exception("Rôle invalide");
        }
    }
}
