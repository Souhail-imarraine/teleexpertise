package com.example.teleexpertise.controller.api;

import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.model.enums.TypeSpecialite;
import com.example.teleexpertise.service.GeneralisteService;
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
 * API pour récupérer la liste des spécialistes par spécialité
 */
@WebServlet("/api/specialistes")
public class SpecialistesApiServlet extends HttpServlet {

    private final GeneralisteService generalisteService;
    private final ObjectMapper objectMapper;

    public SpecialistesApiServlet() {
        this.generalisteService = new GeneralisteService();
        this.objectMapper = new ObjectMapper();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Récupérer le paramètre spécialité
            String specialiteParam = request.getParameter("specialite");
            if (specialiteParam == null || specialiteParam.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Paramètre spécialité manquant\"}");
                return;
            }

            // Convertir en enum
            TypeSpecialite specialite = TypeSpecialite.valueOf(specialiteParam);

            // Récupérer les spécialistes
            List<Specialiste> specialistes = generalisteService.obtenirSpecialistesParSpecialite(specialite);

            // Convertir en format JSON simple
            List<Map<String, Object>> result = new ArrayList<>();
            for (Specialiste spec : specialistes) {
                Map<String, Object> specMap = new HashMap<>();
                specMap.put("id", spec.getId());
                specMap.put("nom", spec.getNom());
                specMap.put("prenom", spec.getPrenom());
                specMap.put("specialite", spec.getSpecialite().toString());
                specMap.put("tarif", spec.getTarif());
                result.add(specMap);
            }

            // Envoyer la réponse JSON
            String json = objectMapper.writeValueAsString(result);
            response.getWriter().write(json);

        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Spécialité invalide\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Erreur serveur\"}");
        }
    }
}

