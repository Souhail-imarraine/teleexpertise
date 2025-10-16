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

    public utilisateur authenticate(String email, String password) throws Exception {
        // Validation des entrées
        if (email == null || email.trim().isEmpty()) {
            throw new Exception("L'email ne peut pas être vide");
        }
        if (password == null || password.trim().isEmpty()) {
            throw new Exception("Le mot de passe ne peut pas être vide");
        }
        // Authenticate user
        utilisateur user = utilisateurDAO.authenticate(email.trim(), password);
        if (user == null) {
            throw new Exception("Email ou mot de passe incorrect");
        }
        return user;
    }

    public String getRedirectUrlByRole(String role) {
        if (role == null) {
            return "/login";
        }

        switch (role.toUpperCase()) {
            case "INFIRMIER":
                return "/infirmier/dashboard";
            case "GENERALISTE":
            case "MEDECIN":
                return "/generaliste/dashboard";
            case "SPECIALISTE":
                return "/specialiste/dashboard";
            default:
                return "/login";
        }
    }


    public void registerUser(String nom, String prenom, String email, String motDePasse,
                            String confirmPassword, String role, String specialite) throws Exception {
        // Validate password confirmation
        if (motDePasse == null || !motDePasse.equals(confirmPassword)) {
            throw new Exception("Les mots de passe ne correspondent pas");
        }

        // Validate specialty for specialists
        if ("SPECIALISTE".equalsIgnoreCase(role) && (specialite == null || specialite.trim().isEmpty())) {
            throw new Exception("Veuillez sélectionner une spécialité médicale");
        }

        // Validate all fields
        validateName(nom, prenom);
        validateEmail(email);
        validatePassword(motDePasse);
        validateRole(role);

        // Create user based on role
        utilisateur newUser = createUserByRole(role, specialite);

        // Set common fields
        newUser.setNom(nom);
        newUser.setPrenom(prenom);
        newUser.setEmail(email);
        newUser.setMotDePasse(PasswordUtil.hashPassword(motDePasse));
        newUser.setRole(role.toUpperCase());

        // Save user
        utilisateurDAO.save(newUser);
    }

    private utilisateur createUserByRole(String role, String specialite) throws Exception {
        switch (role.toUpperCase()) {
            case "INFIRMIER":
                return new Infirmier();
            case "GENERALISTE":
                return new Generaliste();
            case "SPECIALISTE":
                Specialiste specialisteUser = new Specialiste();
                if (specialite != null && !specialite.trim().isEmpty()) {
                    try {
                        TypeSpecialite typeSpec = TypeSpecialite.valueOf(specialite.toUpperCase());
                        specialisteUser.setSpecialite(typeSpec);
                    } catch (IllegalArgumentException e) {
                        throw new Exception("Spécialité invalide : " + specialite);
                    }
                }
                specialisteUser.setTarif(TARIF_PAR_DEFAUT);
                return specialisteUser;

            default:
                throw new Exception("Rôle invalide");
        }
    }


    private void validateEmail(String email) throws Exception {
        if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
            throw new Exception("Email invalide");
        }

        if (utilisateurDAO.findByEmail(email) != null) {
            throw new Exception("Email déjà utilisé");
        }
    }

    /**
     * Validate password strength
     */
    private void validatePassword(String password) throws Exception {
        if (password == null || password.length() < 6) {
            throw new Exception("Le mot de passe doit contenir au moins 6 caractères");
        }
    }

    /**
     * Validate name format
     */
    private void validateName(String nom, String prenom) throws Exception {
        if (nom == null || prenom == null || nom.trim().isEmpty() || prenom.trim().isEmpty()) {
            throw new Exception("Le nom et le prénom ne peuvent pas être vides");
        }

        if (!nom.matches("^[a-zA-ZÀ-ÿ '-]+$") || !prenom.matches("^[a-zA-ZÀ-ÿ '-]+$")) {
            throw new Exception("Le nom ou le prénom contient des caractères invalides");
        }
    }

    /**
     * Validate role
     */
    private void validateRole(String role) throws Exception {
        if (role == null || !(role.equalsIgnoreCase("INFIRMIER") ||
                             role.equalsIgnoreCase("GENERALISTE") ||
                             role.equalsIgnoreCase("SPECIALISTE"))) {
            throw new Exception("Rôle invalide");
        }
    }
}
