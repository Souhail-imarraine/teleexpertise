package com.example.teleexpertise.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {

    private static final EntityManagerFactory emf;

    static {
        EntityManagerFactory temp = null;
        try {
            temp = Persistence.createEntityManagerFactory("teleexpertisePU");
            System.out.println("EntityManagerFactory créé avec succès !");
        } catch (Exception e) {
            System.err.println("Erreur lors de la création de l'EntityManagerFactory : " + e.getMessage());
            e.printStackTrace();
        }
        emf = temp;
    }

    public static EntityManager getEntityManager() {
        if (emf == null) {
            throw new IllegalStateException("EntityManagerFactory non initialisé");
        }
        return emf.createEntityManager();
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("EntityManagerFactory fermé");
        }
    }

    public static boolean testConnection() {
        try (EntityManager em = getEntityManager()) {
            em.getTransaction().begin();
            em.createNativeQuery("SELECT 1").getSingleResult();
            em.getTransaction().commit();
            System.out.println("Connexion à la base de données réussie !");
            return true;
        } catch (Exception e) {
            System.err.println("Erreur de connexion à la base de données : " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
