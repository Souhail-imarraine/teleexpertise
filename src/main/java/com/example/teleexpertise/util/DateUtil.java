package com.example.teleexpertise.util;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;

/**
 * Classe utilitaire pour la gestion des dates
 * Fournit des méthodes pour formater les dates et calculer l'âge
 */
public class DateUtil {

    // Formatters prédéfinis
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");
    private static final DateTimeFormatter DATETIME_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    /**
     * Formate une LocalDate au format dd/MM/yyyy
     * @param date La date à formater
     * @return La date formatée ou "-" si null
     */
    public static String formatDate(LocalDate date) {
        if (date == null) {
            return "-";
        }
        return date.format(DATE_FORMATTER);
    }

    /**
     * Formate une LocalDateTime au format dd/MM/yyyy
     * @param dateTime La date/heure à formater
     * @return La date formatée ou "-" si null
     */
    public static String formatDate(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "-";
        }
        return dateTime.toLocalDate().format(DATE_FORMATTER);
    }

    /**
     * Formate une LocalDateTime au format HH:mm
     * @param dateTime La date/heure à formater
     * @return L'heure formatée ou "-" si null
     */
    public static String formatTime(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "-";
        }
        return dateTime.toLocalTime().format(TIME_FORMATTER);
    }

    /**
     * Formate une LocalDateTime au format dd/MM/yyyy HH:mm
     * @param dateTime La date/heure à formater
     * @return La date et l'heure formatées ou "-" si null
     */
    public static String formatDateTime(LocalDateTime dateTime) {
        if (dateTime == null) {
            return "-";
        }
        return dateTime.format(DATETIME_FORMATTER);
    }

    /**
     * Calcule l'âge d'une personne à partir de sa date de naissance
     * @param dateNaissance La date de naissance
     * @return L'âge en années
     */
    public static int calculerAge(LocalDate dateNaissance) {
        if (dateNaissance == null) {
            return 0;
        }
        LocalDate today = LocalDate.now();
        Period period = Period.between(dateNaissance, today);
        return period.getYears();
    }

    /**
     * Calcule l'âge et retourne une chaîne formatée "XX ans"
     * @param dateNaissance La date de naissance
     * @return L'âge formaté ou "N/A" si null
     */
    public static String calculerAgeFormate(LocalDate dateNaissance) {
        if (dateNaissance == null) {
            return "N/A";
        }
        int age = calculerAge(dateNaissance);
        return age + " ans";
    }

    /**
     * Vérifie si une date est dans le futur
     * @param date La date à vérifier
     * @return true si la date est dans le futur, false sinon
     */
    public static boolean estDansFutur(LocalDate date) {
        if (date == null) {
            return false;
        }
        return date.isAfter(LocalDate.now());
    }

    /**
     * Vérifie si une date/heure est dans le futur
     * @param dateTime La date/heure à vérifier
     * @return true si la date/heure est dans le futur, false sinon
     */
    public static boolean estDansFutur(LocalDateTime dateTime) {
        if (dateTime == null) {
            return false;
        }
        return dateTime.isAfter(LocalDateTime.now());
    }

    /**
     * Vérifie si une date est dans le passé
     * @param date La date à vérifier
     * @return true si la date est dans le passé, false sinon
     */
    public static boolean estDansLePasse(LocalDate date) {
        if (date == null) {
            return false;
        }
        return date.isBefore(LocalDate.now());
    }

    /**
     * Vérifie si une date/heure est dans le passé
     * @param dateTime La date/heure à vérifier
     * @return true si la date/heure est dans le passé, false sinon
     */
    public static boolean estDansLePasse(LocalDateTime dateTime) {
        if (dateTime == null) {
            return false;
        }
        return dateTime.isBefore(LocalDateTime.now());
    }

    /**
     * Vérifie si une date est aujourd'hui
     * @param date La date à vérifier
     * @return true si la date est aujourd'hui, false sinon
     */
    public static boolean estAujourdhui(LocalDate date) {
        if (date == null) {
            return false;
        }
        return date.equals(LocalDate.now());
    }

    /**
     * Retourne la date d'aujourd'hui
     * @return La date d'aujourd'hui
     */
    public static LocalDate aujourdhui() {
        return LocalDate.now();
    }

    /**
     * Retourne la date et l'heure actuelles
     * @return La date et l'heure actuelles
     */
    public static LocalDateTime maintenant() {
        return LocalDateTime.now();
    }
}

