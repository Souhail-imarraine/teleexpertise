package com.example.teleexpertise.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Test JDBC basique sans JPA/Hibernate
 * Clic droit -> Run 'TestJDBCConnection.main()'
 */
public class TestJDBCConnection {

    public static void main(String[] args) {
        System.out.println("=".repeat(60));
        System.out.println("   TEST DE CONNEXION MYSQL AVEC JDBC");
        System.out.println("=".repeat(60));

        String url = "jdbc:mysql://localhost:3306/?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String password = "";

        Connection conn = null;
        Statement stmt = null;

        try {
            // Étape 1: Charger le driver MySQL
            System.out.println("\n📌 Étape 1: Chargement du driver MySQL...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ Driver MySQL chargé avec succès!\n");

            // Étape 2: Connexion à MySQL
            System.out.println("📌 Étape 2: Connexion à MySQL...");
            System.out.println("   URL: " + url);
            System.out.println("   User: " + user);
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ Connexion MySQL établie avec succès!\n");

            // Étape 3: Tester une requête simple
            System.out.println("📌 Étape 3: Test de requête SQL...");
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT VERSION() as version");
            if (rs.next()) {
                System.out.println("✅ Version MySQL: " + rs.getString("version") + "\n");
            }
            rs.close();

            // Étape 4: Créer la base de données si elle n'existe pas
            System.out.println("📌 Étape 4: Création de la base de données teleexpertise_db...");
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS teleexpertise_db");
            System.out.println("✅ Base de données créée/vérifiée!\n");

            // Étape 5: Vérifier les bases de données
            System.out.println("📌 Étape 5: Liste des bases de données:");
            rs = stmt.executeQuery("SHOW DATABASES");
            while (rs.next()) {
                String dbName = rs.getString(1);
                if (dbName.equals("teleexpertise_db")) {
                    System.out.println("   ✅ " + dbName + " (VOTRE BASE)");
                } else if (!dbName.startsWith("information_") && !dbName.equals("mysql")
                        && !dbName.equals("performance_schema") && !dbName.equals("sys")) {
                    System.out.println("   - " + dbName);
                }
            }
            rs.close();

            // SUCCÈS
            System.out.println("\n" + "=".repeat(60));
            System.out.println("🎉 TOUS LES TESTS JDBC ONT RÉUSSI!");
            System.out.println("✅ MySQL fonctionne correctement");
            System.out.println("✅ La base 'teleexpertise_db' est prête");
            System.out.println("=".repeat(60));

        } catch (ClassNotFoundException e) {
            System.err.println("\n❌ ERREUR: Driver MySQL non trouvé!");
            System.err.println("   Cause: " + e.getMessage());
            System.err.println("   Solution: Vérifiez que mysql-connector-j est dans pom.xml");
            System.err.println("   Puis faites: Maven -> Reload Project dans IntelliJ");
        } catch (Exception e) {
            System.err.println("\n❌ ERREUR: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                System.out.println("\n✅ Connexion fermée proprement");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

