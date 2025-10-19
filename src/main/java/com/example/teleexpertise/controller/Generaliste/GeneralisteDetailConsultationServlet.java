package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour afficher les détails d'une consultation
 * ✅ Controller simple qui utilise ConsultationService
 */
@WebServlet("/generaliste/consultation/*")
public class GeneralisteDetailConsultationServlet extends HttpServlet {

    private final ConsultationService consultationService;

    public GeneralisteDetailConsultationServlet() {
        this.consultationService = new ConsultationService();
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
            // 3. Récupérer l'ID de la consultation depuis l'URL
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
                return;
            }

            String consultationIdStr = pathInfo.substring(1); // Enlever le "/"
            Long consultationId = Long.parseLong(consultationIdStr);

            // 4. Récupérer la consultation via le service
            Consultation consultation = consultationService.obtenirConsultationParId(consultationId);

            // 5. Vérifier que la consultation appartient bien au généraliste connecté
            if (consultation.getGeneraliste().getId() != user.getId()) {
                session.setAttribute("errorMessage", "Vous n'avez pas accès à cette consultation");
                response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
                return;
            }

            // 6. Envoyer la consultation à la JSP
            request.setAttribute("consultation", consultation);

            // 7. Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "ID de consultation invalide");
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMessage", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors du chargement de la consultation");
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
        }
    }
}
