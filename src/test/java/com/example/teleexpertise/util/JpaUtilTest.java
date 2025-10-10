package com.example.teleexpertise.util;

import org.junit.jupiter.api.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class JpaUtilTest {

    @Test
    @Order(1)
    @DisplayName("Test 1: Vérifier que l'EntityManagerFactory est initialisé")
    public void testEntityManagerFactoryInitialization() {
        System.out.println("\n🔍 Test 1: Vérification de l'EntityManagerFactory...");
        EntityManagerFactory emf = JpaUtil.getEntityManagerFactory();
        assertNotNull(emf, "EntityManagerFactory ne doit pas être null");
        assertTrue(emf.isOpen(), "EntityManagerFactory doit être ouvert");
        System.out.println("✅ EntityManagerFactory est initialisé et ouvert");
    }

    @Test
    @Order(2)
    @DisplayName("Test 2: Vérifier la création d'un EntityManager")
    public void testEntityManagerCreation() {
        System.out.println("\n🔍 Test 2: Création d'un EntityManager...");
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            assertNotNull(em, "EntityManager ne doit pas être null");
            assertTrue(em.isOpen(), "EntityManager doit être ouvert");
            System.out.println("✅ EntityManager créé avec succès");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Test
    @Order(3)
    @DisplayName("Test 3: Tester la connexion à la base de données")
    public void testDatabaseConnection() {
        System.out.println("\n🔍 Test 3: Test de la connexion à la base de données...");
        boolean connected = JpaUtil.testConnection();
        assertTrue(connected, "La connexion à la base de données doit réussir");
        System.out.println("✅ Connexion à la base de données réussie!");
    }

    @Test
    @Order(4)
    @DisplayName("Test 4: Vérifier l'exécution d'une requête simple")
    public void testSimpleQuery() {
        System.out.println("\n🔍 Test 4: Exécution d'une requête SQL simple...");
        EntityManager em = null;
        try {
            em = JpaUtil.getEntityManager();
            em.getTransaction().begin();

            Object result = em.createNativeQuery("SELECT 1 + 1 as result").getSingleResult();

            em.getTransaction().commit();

            assertNotNull(result, "Le résultat ne doit pas être null");
            System.out.println("✅ Requête exécutée avec succès. Résultat: " + result);
        } catch (Exception e) {
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            fail("Erreur lors de l'exécution de la requête: " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @AfterAll
    public static void cleanup() {
        System.out.println("\n🧹 Nettoyage des ressources...");
        JpaUtil.close();
    }
}

