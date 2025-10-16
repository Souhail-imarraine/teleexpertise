package com.example.teleexpertise.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Classe utilitaire pour créer automatiquement toutes les tables dans la base de données
 */
public class DatabaseInitializer {

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("🚀 CRÉATION DES TABLES DANS LA BASE DE DONNÉES");
        System.out.println("==================================================\n");

        EntityManagerFactory emf = null;


        try {

            System.out.println("📡 Connexion à MySQL via XAMPP...");

            // Cette ligne va créer automatiquement toutes les tables
            emf = Persistence.createEntityManagerFactory("teleexpertisePU");

            System.out.println("\n✅ SUCCÈS ! Les tables ont été créées avec succès !");
            System.out.println("\n📊 Tables créées :");
            System.out.println("   1. utilisateurs (table parent)");
            System.out.println("   2. patients");
            System.out.println("   3. infirmiers");
            System.out.println("   4. generalistes");
            System.out.println("   5. specialistes");
            System.out.println("   6. consultations");
            System.out.println("   7. actes_techniques");
            System.out.println("   8. demandes_expertise");
            System.out.println("   9. creneaux_horaires");

            System.out.println("\n💡 Vérifie dans phpMyAdmin : http://localhost/phpmyadmin");
            System.out.println("   Base de données : teleexpertise_db");

            System.out.println("\n==================================================");
            System.out.println("✅ INITIALISATION TERMINÉE AVEC SUCCÈS");
            System.out.println("==================================================");

        } catch (Exception e) {
            System.err.println("\n ERREUR lors de la création des tables :");
            System.err.println("Message : " + e.getMessage());
            e.printStackTrace();

            System.err.println("\n🔍 Vérifications à faire :");
            System.err.println("   1. XAMPP est démarré ?");
            System.err.println("   2. MySQL tourne sur le port 3306 ?");
            System.err.println("   3. Le mot de passe root est vide ?");

        } finally {
            if (emf != null) {
                emf.close();
                System.out.println("\n🔒 Connexion fermée proprement.");
            }
        }
    }
}

