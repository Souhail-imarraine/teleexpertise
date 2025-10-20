package com.example.teleexpertise.controller.Specialiste;

import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

/**
 * Servlet pour le dashboard du spécialiste
 * Affiche les statistiques et informations principales
 */
@WebServlet("/specialiste/dashboard")
public class SpecialisteDashboardServlet extends HttpServlet {
    private SpecialisteService specialisteService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.specialisteService = new SpecialisteService();
        System.out.println("✅ SpecialisteDashboardServlet initialisé avec succès");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Vérifier le rôle
        String userRole = (String) session.getAttribute("userRole");
        if (!"SPECIALISTE".equals(userRole)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Récupérer l'ID et le convertir correctement en Long
            Object userIdObj = session.getAttribute("userId");
            Long specialisteId;

            if (userIdObj instanceof Integer) {
                specialisteId = ((Integer) userIdObj).longValue();
            } else if (userIdObj instanceof Long) {
                specialisteId = (Long) userIdObj;
            } else {
                throw new IllegalStateException("userId a un type inattendu: " + userIdObj.getClass());
            }

            // Récupérer les statistiques
            Map<String, Long> statistiques = specialisteService.getStatistiques(specialisteId);

            // Récupérer le spécialiste
            Specialiste specialiste = specialisteService.getSpecialisteById(specialisteId);

            // Mettre à jour le nom dans la session si nécessaire
            if (specialiste != null) {
                session.setAttribute("userName", specialiste.getNom() + " " + specialiste.getPrenom());
                session.setAttribute("specialite", specialiste.getSpecialite().getLabel());
                request.setAttribute("specialiste", specialiste);
            }

            request.setAttribute("statistiques", statistiques);

            System.out.println("📊 Statistiques du spécialiste " + specialisteId + " : " + statistiques);

            // Rediriger vers la page JSP
            request.getRequestDispatcher("/WEB-INF/jsp/specialiste/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du dashboard");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
                    .forward(request, response);
        }
    }
}
