package com.example.teleexpertise.service;

import com.example.teleexpertise.dao.CreneauHoraireDAO;
import com.example.teleexpertise.model.CreneauHoraire;
import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.model.enums.StatutCreneau;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Service pour gérer les créneaux horaires des spécialistes
 */
public class CreneauService {
    private final CreneauHoraireDAO creneauDao;

    public CreneauService() {
        this.creneauDao = new CreneauHoraireDAO();
    }

    /**
     * Génère les créneaux de 30 minutes pour une semaine donnée
     */
    public void genererCreneauxSemaine(Specialiste specialiste, LocalDate dateDebut) {
        // Créneaux du matin : 9h00 - 12h00
        // Créneaux de l'après-midi : 14h00 - 17h00

        LocalTime[] horairesMatin = {
            LocalTime.of(9, 0), LocalTime.of(9, 30),
            LocalTime.of(10, 0), LocalTime.of(10, 30),
            LocalTime.of(11, 0), LocalTime.of(11, 30)
        };

        LocalTime[] horairesApresMidi = {
            LocalTime.of(14, 0), LocalTime.of(14, 30),
            LocalTime.of(15, 0), LocalTime.of(15, 30),
            LocalTime.of(16, 0), LocalTime.of(16, 30)
        };

        // Générer pour chaque jour ouvré de la semaine (Lundi à Vendredi)
        for (int i = 0; i < 5; i++) {
            LocalDate jour = dateDebut.plusDays(i);

            // Créneaux du matin
            for (int j = 0; j < horairesMatin.length; j++) {
                LocalDateTime debut = LocalDateTime.of(jour, horairesMatin[j]);
                LocalDateTime fin = debut.plusMinutes(30);

                creerCreneau(specialiste, debut, fin);
            }

            // Créneaux de l'après-midi
            for (int j = 0; j < horairesApresMidi.length; j++) {
                LocalDateTime debut = LocalDateTime.of(jour, horairesApresMidi[j]);
                LocalDateTime fin = debut.plusMinutes(30);

                creerCreneau(specialiste, debut, fin);
            }
        }
    }

    /**
     * Crée un créneau s'il n'existe pas déjà
     */
    private void creerCreneau(Specialiste specialiste, LocalDateTime debut, LocalDateTime fin) {
        try {
            // Vérifier si le créneau existe déjà
            List<CreneauHoraire> existants = creneauDao.findBySpecialisteAndDate(
                    (long) specialiste.getId(), debut, fin
            );

            if (existants.isEmpty()) {
                CreneauHoraire creneau = new CreneauHoraire();
                creneau.setSpecialiste(specialiste);
                creneau.setDateDebut(debut);
                creneau.setDateFin(fin);

                // Déterminer le statut : PASSE si la date est passée, DISPONIBLE sinon
                if (debut.isBefore(LocalDateTime.now())) {
                    creneau.setStatut(StatutCreneau.PASSE);
                } else {
                    creneau.setStatut(StatutCreneau.DISPONIBLE);
                }

                creneauDao.save(creneau);
            }
        } catch (Exception e) {
        }
    }

    /**
     * Récupère les créneaux d'une semaine pour un spécialiste
     */
    public Map<String, Object> getCreneauxSemaine(Long specialisteId, LocalDate dateDebut) {
        Map<String, Object> result = new HashMap<>();

        try {
            // Calculer la fin de la semaine
            LocalDate dateFin = dateDebut.plusDays(4); // Lundi à Vendredi

            // Récupérer tous les créneaux de la semaine
            List<CreneauHoraire> creneaux = creneauDao.findBySpecialisteAndPeriode(
                specialisteId,
                dateDebut.atStartOfDay(),
                dateFin.atTime(23, 59)
            );

            // Organiser les créneaux par jour et par heure
            Map<String, List<CreneauHoraire>> creneauxParJour = new HashMap<>();

            for (int i = 0; i < 5; i++) {
                LocalDate jour = dateDebut.plusDays(i);
                String cle = jour.toString();

                List<CreneauHoraire> creneauxDuJour = creneaux.stream()
                    .filter(c -> c.getDateDebut().toLocalDate().equals(jour))
                    .sorted((c1, c2) -> c1.getDateDebut().compareTo(c2.getDateDebut()))
                    .collect(Collectors.toList());

                creneauxParJour.put(cle, creneauxDuJour);
            }

            result.put("creneauxParJour", creneauxParJour);
            result.put("dateDebut", dateDebut);
            result.put("dateFin", dateFin);

            // Calculer les statistiques
            long disponibles = creneaux.stream()
                .filter(c -> c.getStatut() == StatutCreneau.DISPONIBLE)
                .count();
            long reserves = creneaux.stream()
                .filter(c -> c.getStatut() == StatutCreneau.RESERVE)
                .count();
            long bloques = creneaux.stream()
                .filter(c -> c.getStatut() == StatutCreneau.BLOQUE)
                .count();
            long passes = creneaux.stream()
                .filter(c -> c.getStatut() == StatutCreneau.PASSE)
                .count();

            result.put("statsDisponibles", disponibles);
            result.put("statsReserves", reserves);
            result.put("statsBloques", bloques);
            result.put("statsPasses", passes);

        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la récupération des créneaux: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    /**
     * Change le statut d'un créneau
     */
    public boolean changerStatut(Long creneauId, StatutCreneau nouveauStatut) {
        try {
            CreneauHoraire creneau = creneauDao.findById(creneauId).orElse(null);

            if (creneau != null && creneau.getStatut() != StatutCreneau.PASSE) {
                creneau.setStatut(nouveauStatut);
                creneauDao.update(creneau);
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Erreur lors du changement de statut: " + e.getMessage());
            return false;
        }
    }

    /**
     * Récupère le début de la semaine actuelle (lundi)
     */
    public LocalDate getDebutSemaineActuelle() {
        return LocalDate.now().with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
    }

    /**
     * Récupère les créneaux disponibles pour un spécialiste
     */
    public List<CreneauHoraire> getCreneauxDisponibles(Long specialisteId) {
        try {
            List<CreneauHoraire> tous = creneauDao.findBySpecialisteId(specialisteId);
            return tous.stream()
                .filter(c -> c.getStatut() == StatutCreneau.DISPONIBLE)
                .filter(c -> c.getDateDebut().isAfter(LocalDateTime.now()))
                .sorted((c1, c2) -> c1.getDateDebut().compareTo(c2.getDateDebut()))
                .collect(Collectors.toList());
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }
}

