package com.example.teleexpertise.controller.Specialiste;

import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.service.CreneauService;
import com.example.teleexpertise.service.SpecialisteService;
import com.example.teleexpertise.util.DateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;

/**
 * Servlet pour gérer les créneaux horaires du spécialiste
 */
@WebServlet("/specialiste/creneaux")
public class SpecialisteCreneauxServlet extends HttpServlet {
    private CreneauService creneauService;
    private SpecialisteService specialisteService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.creneauService = new CreneauService();
        this.specialisteService = new SpecialisteService();
        System.out.println("✅ SpecialisteCreneauxServlet initialisé");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");
        if (!"SPECIALISTE".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Récupérer l'ID du spécialiste
            Object userIdObj = session.getAttribute("userId");
            Long specialisteId = (userIdObj instanceof Integer)
                ? ((Integer) userIdObj).longValue()
                : (Long) userIdObj;

            // Récupérer le spécialiste
            Specialiste specialiste = specialisteService.getSpecialisteById(specialisteId);

            // Déterminer la semaine à afficher
            String semaineParam = request.getParameter("semaine");
            LocalDate dateDebut;

            if (semaineParam != null) {
                // Semaine spécifique
                dateDebut = LocalDate.parse(semaineParam);
            } else {
                // Semaine actuelle par défaut
                dateDebut = creneauService.getDebutSemaineActuelle();
            }

            // Générer les créneaux de la semaine si nécessaire
            creneauService.genererCreneauxSemaine(specialiste, dateDebut);

            // Récupérer les créneaux de la semaine
            Map<String, Object> donneesCreneaux = creneauService.getCreneauxSemaine(specialisteId, dateDebut);

            // Calculer les semaines précédente et suivante
            LocalDate semainePrecedente = dateDebut.minusWeeks(1);
            LocalDate semaineSuivante = dateDebut.plusWeeks(1);

            // Ajouter les données à la requête
            request.setAttribute("creneauxParJour", donneesCreneaux.get("creneauxParJour"));
            request.setAttribute("dateDebut", donneesCreneaux.get("dateDebut"));
            request.setAttribute("dateFin", donneesCreneaux.get("dateFin"));
            request.setAttribute("statsDisponibles", donneesCreneaux.get("statsDisponibles"));
            request.setAttribute("statsReserves", donneesCreneaux.get("statsReserves"));
            request.setAttribute("statsBloques", donneesCreneaux.get("statsBloques"));
            request.setAttribute("statsPasses", donneesCreneaux.get("statsPasses"));
            request.setAttribute("semainePrecedente", semainePrecedente);
            request.setAttribute("semaineSuivante", semaineSuivante);
            request.setAttribute("semaineActuelle", creneauService.getDebutSemaineActuelle());

            System.out.println("📅 Créneaux chargés pour la semaine du " + dateDebut);

            request.getRequestDispatcher("/WEB-INF/jsp/specialiste/creneaux.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des créneaux");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String action = request.getParameter("action");
            String creneauIdStr = request.getParameter("creneauId");

            if (action != null && creneauIdStr != null) {
                Long creneauId = Long.parseLong(creneauIdStr);

                // TODO: Gérer les actions (bloquer, débloquer, etc.)

                session.setAttribute("successMessage", "Action effectuée avec succès");
            }

            response.sendRedirect(request.getContextPath() + "/specialiste/creneaux");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de l'action sur le créneau");
            response.sendRedirect(request.getContextPath() + "/specialiste/creneaux");
        }
    }
}
