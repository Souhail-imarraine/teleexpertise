package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.UtilisateurDAO;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.model.*;
import com.example.teleexpertise.model.enums.TypeSpecialite;
import com.example.teleexpertise.util.PasswordUtil;

public class AuthService {

    private UtilisateurDAO utilisateurDAO;

    private static final Double TARIF_PAR_DEFAUT = 300.0;

    public AuthService() {
        this.utilisateurDAO = new UtilisateurDAO();
    }

    public utilisateur login(String email, String motDePasse) {
        // Validation des entrées
        if(email == null || email.trim().isEmpty()){
            System.out.println("❌ Email vide");
            return null;
        }

        if (motDePasse == null || motDePasse.trim().isEmpty()) {
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

    public void register(String nom, String prenom, String email, String motDePasse, String role, String specialite) throws Exception {
        // Validation des entrées
        validateName(nom, prenom);
        validateEmail(email);
        validatePassword(motDePasse);
        validRole(role);

        utilisateur newUser;
        switch (role.toUpperCase()) {
            case "INFIRMIER":
                newUser = new Infirmier();
                break;
            case "GENERALISTE":
            case "MEDECIN":
                newUser = new Generaliste();
                break;
            case "SPECIALISTE":
                Specialiste specialisteUser = new Specialiste();
                // Valider et assigner la spécialité
                if (specialite != null && !specialite.trim().isEmpty()) {
                    try {
                        TypeSpecialite typeSpec = TypeSpecialite.valueOf(specialite.toUpperCase());
                        specialisteUser.setSpecialite(typeSpec);
                    } catch (IllegalArgumentException e) {
                        throw new Exception("Spécialité invalide : " + specialite);
                    }
                } else if ("SPECIALISTE".equalsIgnoreCase(role)) {
                    throw new Exception("La spécialité est obligatoire pour les spécialistes");
                }

                specialisteUser.setTarif(TARIF_PAR_DEFAUT);

                newUser = specialisteUser;
                break;
            default:
                throw new Exception("Rôle invalide");
        }

        newUser.setNom(nom);
        newUser.setPrenom(prenom);
        newUser.setEmail(email);

        String hashedPassword = PasswordUtil.hashPassword(motDePasse);
        newUser.setMotDePasse(hashedPassword);

        newUser.setRole(role.toUpperCase());

        // Sauvegarder l'utilisateur dans la base de données
        utilisateurDAO.save(newUser);
        System.out.println("✅ Utilisateur enregistré avec mot de passe haché : " + email);
    }

    public void validateEmail(String email) throws Exception {
        if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new Exception("Email invalide");
        }else if(utilisateurDAO.findByEmail(email) != null){
            throw new Exception("Email déjà utilisé");
        }
    }

    public void validatePassword(String password) throws Exception {
        if (password == null || password.length() < 6) {
            throw new Exception("Le mot de passe doit contenir au moins 6 caractères");
        }
    }

    public void validateName(String name, String prenom) throws Exception {
        if (name == null || prenom == null || name.trim().isEmpty() || prenom.trim().isEmpty()) {
            throw new Exception("Le nom et le prénom ne peuvent pas être vides");
        }else if (!name.matches("^[a-zA-ZÀ-ÿ '-]+$") || !prenom.matches("^[a-zA-ZÀ-ÿ '-]+$")) {
            throw new Exception("Le nom ou le prénom contient des caractères invalides");
        }
    }

    public void validRole(String role) throws Exception {
        if (role == null || !(role.equalsIgnoreCase("INFIRMIER") ||
                             role.equalsIgnoreCase("GENERALISTE") ||
                             role.equalsIgnoreCase("MEDECIN") ||
                             role.equalsIgnoreCase("SPECIALISTE") ||
                             role.equalsIgnoreCase("RADIOLOGUE"))) {
            throw new Exception("Rôle invalide");
        }
    }
}
