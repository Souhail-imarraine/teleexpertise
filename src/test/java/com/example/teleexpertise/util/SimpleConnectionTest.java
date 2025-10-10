package com.example.teleexpertise.util;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;

/**
 * Test simple pour vérifier la connexion à la base de données
 * Clic droit sur cette classe dans IntelliJ -> Run 'SimpleConnectionTest'
 */
public class SimpleConnectionTest {

    @Test
    @DisplayName("✅ Test de connexion MySQL")
    public void testMySQLConnection() {
        System.out.println("\n" + "=".repeat(50));
        System.out.println("🔍 TEST DE CONNEXION À LA BASE DE DONNÉES");
        System.out.println("=".repeat(50));

        try {
            // Test de la connexion
            boolean connected = JpaUtil.testConnection();

            if (connected) {
                System.out.println("\n" + "✅".repeat(25));
                System.out.println("🎉 SUCCÈS! La connexion fonctionne parfaitement!");
                System.out.println("✅".repeat(25) + "\n");
            } else {
                System.err.println("\n❌ ÉCHEC: La connexion n'a pas réussi");
                throw new RuntimeException("Connexion échouée");
            }

        } catch (Exception e) {
            System.err.println("\n❌ ERREUR: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            JpaUtil.close();
        }
    }
}

