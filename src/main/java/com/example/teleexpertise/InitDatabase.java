package com.example.teleexpertise;

import com.example.teleexpertise.util.JpaUtil;

/**
 * Classe principale pour initialiser la base de données
 * Exécute cette classe pour créer automatiquement toutes les tables
 */
public class InitDatabase {

    public static void main(String[] args) {
        System.out.println("╔════════════════════════════════════════════════════╗");
        System.out.println("║   INITIALISATION DE LA BASE DE DONNÉES MySQL      ║");
        System.out.println("╚════════════════════════════════════════════════════╝\n");

        try {
            System.out.println("📡 Connexion à MySQL (XAMPP)...");
            System.out.println("   - Serveur: localhost:3306");
            System.out.println("   - Base de données: teleexpertise_db");
            System.out.println("   - Utilisateur: root\n");

            // Cette ligne initialise JPA et crée automatiquement les tables
            System.out.println("🔨 Création des tables en cours...\n");
            JpaUtil.testConnection();

            System.out.println("\n╔════════════════════════════════════════════════════╗");
            System.out.println("║              ✅ SUCCÈS !                           ║");
            System.out.println("╚════════════════════════════════════════════════════╝\n");

            System.out.println("📊 Tables créées avec succès :");
            System.out.println("   ✓ utilisateurs (table parent avec héritage JOINED)");
            System.out.println("   ✓ patients (hérite de utilisateurs)");
            System.out.println("   ✓ infirmiers (hérite de utilisateurs)");
            System.out.println("   ✓ generalistes (hérite de utilisateurs)");
            System.out.println("   ✓ specialistes (hérite de utilisateurs)");
            System.out.println("   ✓ consultations");
            System.out.println("   ✓ actes_techniques");
            System.out.println("   ✓ demandes_expertise");
            System.out.println("   ✓ creneaux_horaires\n");

            System.out.println("💡 Prochaines étapes :");
            System.out.println("   1. Ouvre phpMyAdmin: http://localhost/phpmyadmin");
            System.out.println("   2. Sélectionne la base 'teleexpertise_db'");
            System.out.println("   3. Vérifie que les 9 tables sont créées\n");

            System.out.println("📝 Structure de la base de données :");
            System.out.println("   utilisateurs");
            System.out.println("   ├── patients (FK: id → utilisateurs.id)");
            System.out.println("   ├── infirmiers (FK: id → utilisateurs.id)");
            System.out.println("   ├── generalistes (FK: id → utilisateurs.id)");
            System.out.println("   └── specialistes (FK: id → utilisateurs.id)");
            System.out.println("   consultations");
            System.out.println("   ├── FK: patient_id → patients.id");
            System.out.println("   └── FK: generaliste_id → generalistes.id");
            System.out.println("   actes_techniques (FK: consultation_id)");
            System.out.println("   demandes_expertise (FK: consultation_id, specialiste_id, etc.)");
            System.out.println("   creneaux_horaires (FK: specialiste_id)\n");

        } catch (Exception e) {
            System.err.println("\n╔════════════════════════════════════════════════════╗");
            System.err.println("║              ❌ ERREUR !                           ║");
            System.err.println("╚════════════════════════════════════════════════════╝\n");

            System.err.println("Message d'erreur : " + e.getMessage());
            System.err.println("\n🔍 Vérifications à faire :");
            System.err.println("   ❌ XAMPP est-il démarré ?");
            System.err.println("   ❌ MySQL tourne-t-il sur le port 3306 ?");
            System.err.println("   ❌ Le mot de passe MySQL root est-il vide ?");
            System.err.println("   ❌ Le driver MySQL est-il dans les dépendances Maven ?\n");

            System.err.println("📋 Détails techniques :");
            e.printStackTrace();
        }
    }
}

