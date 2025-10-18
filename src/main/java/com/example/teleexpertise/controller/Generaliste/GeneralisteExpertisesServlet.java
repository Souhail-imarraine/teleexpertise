package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/generaliste/expertises")
public class GeneralisteExpertisesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // Vérifier si l'utilisateur est connecté
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Vérifier le rôle
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"GENERALISTE".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // TODO: Récupérer les demandes d'expertise du généraliste depuis la base de données
            // Long generalisteId = user.getId();
            // List<DemandeExpertise> expertises = expertiseService.getExpertisesByGeneraliste(generalisteId);

            // Filtrer par statut et priorité avec Stream API
            // List<DemandeExpertise> expertisesEnAttente = expertises.stream()
            //     .filter(e -> e.getStatut() == StatutExpertise.EN_ATTENTE)
            //     .collect(Collectors.toList());

            // List<DemandeExpertise> expertisesUrgentes = expertises.stream()
            //     .filter(e -> e.getPriorite() == Priorite.URGENTE)
            //     .collect(Collectors.toList());

            // request.setAttribute("expertises", expertises);
            // request.setAttribute("expertisesEnAttente", expertisesEnAttente);
            // request.setAttribute("expertisesUrgentes", expertisesUrgentes);

            // Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/expertises.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des expertises: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/expertises.jsp")
                    .forward(request, response);
        }
    }
}

