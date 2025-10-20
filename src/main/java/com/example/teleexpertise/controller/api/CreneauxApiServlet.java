package com.example.teleexpertise.controller.api;

import com.example.teleexpertise.model.CreneauHoraire;
import com.example.teleexpertise.service.GeneralisteService;
import com.example.teleexpertise.util.DateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * API pour récupérer les créneaux disponibles d'un spécialiste
 */
@WebServlet("/api/creneaux")
public class CreneauxApiServlet extends HttpServlet {

    private final GeneralisteService generalisteService;
    private final ObjectMapper objectMapper;

    public CreneauxApiServlet() {
        this.generalisteService = new GeneralisteService();
        this.objectMapper = new ObjectMapper();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Récupérer le paramètre specialisteId
            String specialisteIdParam = request.getParameter("specialisteId");
            if (specialisteIdParam == null || specialisteIdParam.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Paramètre specialisteId manquant\"}");
                return;
            }

            int specialisteId = Integer.parseInt(specialisteIdParam);

            // Récupérer les créneaux disponibles
            List<CreneauHoraire> creneaux = generalisteService.obtenirCreneauxDisponibles(specialisteId);

            // Convertir en format JSON simple
            List<Map<String, Object>> result = new ArrayList<>();
            for (CreneauHoraire creneau : creneaux) {
                Map<String, Object> creneauMap = new HashMap<>();
                creneauMap.put("id", creneau.getId());

                // Formater les dates avec DateUtil
                String dateDebut = DateUtil.formatDateTime(creneau.getDateDebut());
                String dateFin = DateUtil.formatDateTime(creneau.getDateFin());

                creneauMap.put("dateDebut", dateDebut);
                creneauMap.put("dateFin", dateFin);
                creneauMap.put("statut", creneau.getStatut().toString());

                // Calculer la durée en minutes
                long dureeMinutes = java.time.Duration.between(
                    creneau.getDateDebut(),
                    creneau.getDateFin()
                ).toMinutes();
                creneauMap.put("duree", dureeMinutes);

                result.add(creneauMap);
            }

            // Envoyer la réponse JSON
            String json = objectMapper.writeValueAsString(result);
            response.getWriter().write(json);

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"ID spécialiste invalide\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Erreur serveur: " + e.getMessage() + "\"}");
        }
    }
}

