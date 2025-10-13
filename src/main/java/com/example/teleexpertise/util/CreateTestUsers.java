package com.example.teleexpertise.util;

import com.example.teleexpertise.model.Infirmier;
import com.example.teleexpertise.model.Generaliste;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.model.enums.TypeSpecialite;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class CreateTestUsers {

    public static void main(String[] args) {
        System.out.println("╔════════════════════════════════════════════════════╗");
        System.out.println("║        CRÉATION DES UTILISATEURS DE TEST          ║");
        System.out.println("╚════════════════════════════════════════════════════╝\n");

        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = null;

        try {
            tx = em.getTransaction();
            tx.begin();

            // ========== 1. CRÉER UN INFIRMIER ==========
            System.out.println("👨‍⚕️ Création d'un infirmier...");
            Infirmier infirmier = new Infirmier();
            infirmier.setNom("Alami");
            infirmier.setPrenom("Sara");
            infirmier.setEmail("infirmier@hopital.ma");
            infirmier.setMotDePasse("password123");
            infirmier.setRole("INFIRMIER");

            em.persist(infirmier);
            System.out.println("   ✅ Infirmier créé : " + infirmier.getEmail());
            System.out.println("      Mot de passe : password123\n");

            // ========== 2. CRÉER UN GÉNÉRALISTE ==========
            System.out.println("👨‍⚕️ Création d'un généraliste...");
            Generaliste generaliste = new Generaliste();
            generaliste.setNom("Benani");
            generaliste.setPrenom("Ahmed");
            generaliste.setEmail("generaliste@hopital.ma");
            generaliste.setMotDePasse("password123");
            generaliste.setRole("GENERALISTE");
            generaliste.setNumeroOrdre("MED-2024-001");
            generaliste.setSpecialite("Médecine générale");

            em.persist(generaliste);
            System.out.println("   ✅ Généraliste créé : " + generaliste.getEmail());
            System.out.println("      Mot de passe : password123");
            System.out.println("      Numéro d'ordre : " + generaliste.getNumeroOrdre() + "\n");

            // ========== 3. CRÉER UN SPÉCIALISTE (CARDIOLOGUE) ==========
            System.out.println("👨‍⚕️ Création d'un spécialiste...");
            Specialiste specialiste = new Specialiste();
            specialiste.setNom("Idrissi");
            specialiste.setPrenom("Hassan");
            specialiste.setEmail("specialiste@hopital.ma");
            specialiste.setMotDePasse("password123");
            specialiste.setRole("SPECIALISTE");
            specialiste.setSpecialite(TypeSpecialite.CARDIOLOGIE);
            specialiste.setTarif(400.0);
            specialiste.setDureeMoyenneConsultation(30);

            em.persist(specialiste);
            System.out.println("   ✅ Spécialiste créé : " + specialiste.getEmail());
            System.out.println("      Mot de passe : password123");
            System.out.println("      Spécialité : " + specialiste.getSpecialite());
            System.out.println("      Tarif : " + specialiste.getTarif() + " DH\n");

            // Commit de la transaction
            tx.commit();

            System.out.println("╔════════════════════════════════════════════════════╗");
            System.out.println("║              ✅ SUCCÈS !                           ║");
            System.out.println("╚════════════════════════════════════════════════════╝\n");

            System.out.println("📋 RÉCAPITULATIF DES COMPTES CRÉÉS :\n");

            System.out.println("┌─────────────────────────────────────────────────┐");
            System.out.println("│ 👨‍⚕️ INFIRMIER                                   │");
            System.out.println("├─────────────────────────────────────────────────┤");
            System.out.println("│ Email    : infirmier@hopital.ma                 │");
            System.out.println("│ Password : password123                          │");
            System.out.println("│ Nom      : Sara Alami                           │");
            System.out.println("└─────────────────────────────────────────────────┘\n");

            System.out.println("┌─────────────────────────────────────────────────┐");
            System.out.println("│ 👨‍⚕️ GÉNÉRALISTE                                 │");
            System.out.println("├─────────────────────────────────────────────────┤");
            System.out.println("│ Email    : generaliste@hopital.ma               │");
            System.out.println("│ Password : password123                          │");
            System.out.println("│ Nom      : Ahmed Benani                         │");
            System.out.println("│ N° Ordre : MED-2024-001                         │");
            System.out.println("└─────────────────────────────────────────────────┘\n");

            System.out.println("┌─────────────────────────────────────────────────┐");
            System.out.println("│ 👨‍⚕️ SPÉCIALISTE (Cardiologue)                   │");
            System.out.println("├─────────────────────────────────────────────────┤");
            System.out.println("│ Email    : specialiste@hopital.ma               │");
            System.out.println("│ Password : password123                          │");
            System.out.println("│ Nom      : Hassan Idrissi                       │");
            System.out.println("│ Tarif    : 400 DH                               │");
            System.out.println("└─────────────────────────────────────────────────┘\n");

            System.out.println("💡 Tu peux maintenant te connecter avec ces identifiants !");
            System.out.println("🌐 Va sur : http://localhost:8080/teleexpertise/login\n");

        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }

            System.err.println("\n❌ ERREUR lors de la création des utilisateurs :");
            e.printStackTrace();

            System.err.println("\n💡 Vérifications :");
            System.err.println("   - Les tables sont-elles créées dans MySQL ?");
            System.err.println("   - Les utilisateurs existent-ils déjà ?");

        } finally {
            if (em != null) {
                em.close();
            }
        }
    }
}

