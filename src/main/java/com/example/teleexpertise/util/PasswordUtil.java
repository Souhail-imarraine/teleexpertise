package com.example.teleexpertise.util;

import org.mindrot.jbcrypt.BCrypt;


public class PasswordUtil {

    // Nombre de rounds pour le hachage (10-12 recommandé, plus = plus sécurisé mais plus lent)
    private static final int BCRYPT_ROUNDS = 12;

    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Le mot de passe ne peut pas être vide");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("Erreur lors de la vérification du mot de passe: " + e.getMessage());
            return false;
        }
    }
}

