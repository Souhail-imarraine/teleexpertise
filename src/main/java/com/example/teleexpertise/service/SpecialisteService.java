package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.DemandeExpertiseDAO;
import com.example.teleexpertise.dao.SpecialisteDAO;
import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.model.enums.PrioriteExpertise;
import com.example.teleexpertise.model.enums.StatutExpertise;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SpecialisteService {
    private final DemandeExpertiseDAO demandeDao;
    private final SpecialisteDAO specialisteDao;

    public SpecialisteService() {
        this.demandeDao = new DemandeExpertiseDAO();
        this.specialisteDao = new SpecialisteDAO();
    }

    /**
     * Récupère les statistiques du spécialiste pour le dashboard
     */
    public Map<String, Long> getStatistiques(Long specialisteId) {
        Map<String, Long> stats = new HashMap<>();

        try {
            // Récupérer toutes les demandes du spécialiste
            List<DemandeExpertise> demandes = demandeDao.findBySpecialisteId(specialisteId);

            // Compter les demandes en attente
            long enAttente = demandes.stream()
                    .filter(d -> d.getStatut() == StatutExpertise.EN_ATTENTE)
                    .count();

            // Compter les demandes urgentes (en attente + urgentes)
            long urgentes = demandes.stream()
                    .filter(d -> d.getStatut() == StatutExpertise.EN_ATTENTE
                            && d.getPriorite() == PrioriteExpertise.URGENTE)
                    .count();

            // Compter les demandes terminées
            long terminees = demandes.stream()
                    .filter(d -> d.getStatut() == StatutExpertise.TERMINEE)
                    .count();

            stats.put("demandesEnAttente", enAttente);
            stats.put("demandesUrgentes", urgentes);
            stats.put("demandesTerminees", terminees);
            stats.put("demandesTotal", (long) demandes.size());

        } catch (Exception e) {
            System.err.println("❌ Erreur lors du calcul des statistiques: " + e.getMessage());
            e.printStackTrace();
            // Retourner des valeurs par défaut
            stats.put("demandesEnAttente", 0L);
            stats.put("demandesUrgentes", 0L);
            stats.put("demandesTerminees", 0L);
            stats.put("demandesTotal", 0L);
        }

        return stats;
    }

    /**
     * Récupère les demandes récentes du spécialiste
     */
    public List<DemandeExpertise> getDemandesRecentes(Long specialisteId, int limit) {
        try {
            List<DemandeExpertise> demandes = demandeDao.findBySpecialisteId(specialisteId);

            // Trier par date de création (plus récentes en premier)
            demandes.sort((d1, d2) -> d2.getDateCreation().compareTo(d1.getDateCreation()));

            // Limiter le nombre de résultats
            return demandes.size() > limit ? demandes.subList(0, limit) : demandes;

        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la récupération des demandes récentes: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    /**
     * Récupère les demandes urgentes du spécialiste
     */
    public List<DemandeExpertise> getDemandesUrgentes(Long specialisteId) {
        try {
            List<DemandeExpertise> demandes = demandeDao.findBySpecialisteId(specialisteId);

            // Filtrer les demandes urgentes en attente
            return demandes.stream()
                    .filter(d -> d.getStatut() == StatutExpertise.EN_ATTENTE
                            && d.getPriorite() == PrioriteExpertise.URGENTE)
                    .sorted((d1, d2) -> d1.getDateCreation().compareTo(d2.getDateCreation()))
                    .toList();

        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la récupération des demandes urgentes: " + e.getMessage());
            e.printStackTrace();
            return List.of();
        }
    }

    /**
     * Récupère un spécialiste par son ID
     */
    public Specialiste getSpecialisteById(Long id) {
        try {
            return specialisteDao.findById(id).orElse(null);
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la récupération du spécialiste: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Met à jour le profil du spécialiste
     */
    public boolean updateProfil(Specialiste specialiste) {
        try {
            specialisteDao.update(specialiste);
            return true;
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la mise à jour du profil: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
