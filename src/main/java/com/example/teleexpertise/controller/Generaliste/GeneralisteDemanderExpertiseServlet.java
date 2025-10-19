package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.GeneralisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour demander un avis spécialiste (expertise)
 * ✅ Controller simple : gère seulement les requêtes HTTP
 * ✅ Logique métier déplacée dans GeneralisteService
 */
@WebServlet("/generaliste/demander-expertise")
public class GeneralisteDemanderExpertiseServlet extends HttpServlet {

    private final GeneralisteService generalisteService;

    public GeneralisteDemanderExpertiseServlet() {
        this.generalisteService = new GeneralisteService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // 1. Vérifier l'authentification
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Vérifier le rôle
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"GENERALISTE".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 3. Récupérer l'ID de la consultation (si fourni)
            String consultationId = request.getParameter("consultationId");
            if (consultationId != null) {
                request.setAttribute("consultationId", consultationId);
            }

            // 4. Afficher le formulaire
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du formulaire: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // 1. Vérifier l'authentification
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"GENERALISTE".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // 2. Récupérer les paramètres du formulaire
            int consultationId = Integer.parseInt(request.getParameter("consultationId"));
            int generalisteId = user.getId();
            int specialisteId = Integer.parseInt(request.getParameter("specialiste"));
            int creneauId = Integer.parseInt(request.getParameter("creneau"));
            String priorite = request.getParameter("priorite");
            String question = request.getParameter("question");
            String donneesAnalyses = request.getParameter("donneesAnalyses");
            String modeExpertise = request.getParameter("modeExpertise");

            // 3. Appeler le service pour créer la demande (toute la logique métier est dans le service)
            generalisteService.creerDemandeExpertise(
                consultationId,
                generalisteId,
                specialisteId,
                creneauId,
                priorite,
                question,
                donneesAnalyses,
                modeExpertise
            );

            // 4. Message de succès et redirection
            session.setAttribute("successMessage", "Demande d'expertise envoyée avec succès !");
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Paramètres invalides");
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'envoi de la demande: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);
        }
    }
}
