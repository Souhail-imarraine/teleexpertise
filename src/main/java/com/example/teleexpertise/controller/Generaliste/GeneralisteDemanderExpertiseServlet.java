package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour demander un avis spécialiste (expertise)
 */
@WebServlet("/generaliste/demander-expertise")
public class GeneralisteDemanderExpertiseServlet extends HttpServlet {

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
            // Récupérer l'ID de la consultation si fourni
            String consultationId = request.getParameter("consultationId");

            // TODO: Récupérer la consultation et les spécialistes disponibles
            // if (consultationId != null) {
            //     Consultation consultation = consultationService.getConsultationById(Long.parseLong(consultationId));
            //     request.setAttribute("consultation", consultation);
            // }

            // List<Specialiste> specialistes = specialisteService.getAllSpecialistes();
            // request.setAttribute("specialistes", specialistes);

            if (consultationId != null) {
                request.setAttribute("consultationId", consultationId);
            }

            // Forward vers la JSP
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
            // TODO: Récupérer les données du formulaire et créer la demande d'expertise
            // String consultationId = request.getParameter("consultationId");
            // String specialite = request.getParameter("specialite");
            // String specialisteId = request.getParameter("specialiste");
            // String creneauId = request.getParameter("creneau");
            // String priorite = request.getParameter("priorite");
            // String question = request.getParameter("question");

            // DemandeExpertise expertise = new DemandeExpertise();
            // expertise.setPriorite(Priorite.valueOf(priorite));
            // expertise.setQuestion(question);
            // ... set other fields

            // expertiseService.createDemandeExpertise(expertise);

            // Mettre à jour le statut de la consultation
            // consultationService.updateStatut(consultationId, StatutConsultation.EN_ATTENTE_AVIS_SPECIALISTE);

            session.setAttribute("successMessage", "Demande d'expertise envoyée avec succès !");
            response.sendRedirect(request.getContextPath() + "/generaliste/expertises");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'envoi de la demande: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/demander-expertise.jsp")
                    .forward(request, response);
        }
    }
}

