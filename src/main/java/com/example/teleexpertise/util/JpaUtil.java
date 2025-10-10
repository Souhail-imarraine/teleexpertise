package com.example.teleexpertise.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {
    private static EntityManagerFactory entityManagerFactory;

    static {
        try {
            entityManagerFactory = Persistence.createEntityManagerFactory("teleexpertisePU");
            System.out.println("✅ EntityManagerFactory créé avec succès!");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la création de l'EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static EntityManager getEntityManager() {
        if (entityManagerFactory == null) {
            throw new IllegalStateException("EntityManagerFactory n'est pas initialisé");
        }
        return entityManagerFactory.createEntityManager();
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return entityManagerFactory;
    }

    public static void close() {
        if (entityManagerFactory != null && entityManagerFactory.isOpen()) {
            entityManagerFactory.close();
            System.out.println("✅ EntityManagerFactory fermé");
        }
    }

    // Méthode pour tester la connexion
    public static boolean testConnection() {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            // Test simple avec une requête native
            em.createNativeQuery("SELECT 1").getSingleResult();
            em.getTransaction().commit();
            System.out.println("✅ Connexion à la bcase de données réussie!");
            return true;
        } catch (Exception e) {
            System.err.println("❌ Erreur de connexion à la base de données: " + e.getMessage());
            e.printStackTrace();
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
