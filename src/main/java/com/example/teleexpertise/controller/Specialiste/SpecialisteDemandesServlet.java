package com.example.teleexpertise.controller.Specialiste;

import com.example.teleexpertise.model.DemandeExpertise;
import com.example.teleexpertise.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet pour afficher les demandes d'expertise du spécialiste
 */
@WebServlet("/specialiste/demandes")
public class SpecialisteDemandesServlet extends HttpServlet {
    private SpecialisteService specialisteService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.specialisteService = new SpecialisteService();
        System.out.println("✅ SpecialisteDemandesServlet initialisé");
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
            Object userIdObj = session.getAttribute("userId");
            Long specialisteId = (userIdObj instanceof Integer)
                ? ((Integer) userIdObj).longValue()
                : (Long) userIdObj;

            // Récupérer toutes les demandes
            List<DemandeExpertise> demandes = specialisteService.getDemandesRecentes(specialisteId, 100);

            // Récupérer les demandes urgentes
            List<DemandeExpertise> demandesUrgentes = specialisteService.getDemandesUrgentes(specialisteId);

            request.setAttribute("demandes", demandes);
            request.setAttribute("demandesUrgentes", demandesUrgentes);

            request.getRequestDispatcher("/WEB-INF/jsp/specialiste/demandes.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des demandes");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
                    .forward(request, response);
        }
    }
}

