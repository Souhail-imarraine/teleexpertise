package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/generaliste/consultation/*")
public class GeneralisteDetailConsultationServlet extends HttpServlet {

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
            // Récupérer l'ID de la consultation depuis l'URL
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
                return;
            }

            String consultationId = pathInfo.substring(1); // Enlever le "/"

            // TODO: Récupérer la consultation depuis la base de données
            // Consultation consultation = consultationService.getConsultationById(Long.parseLong(consultationId));
            // if (consultation == null) {
            //     response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
            //     return;
            // }
            // request.setAttribute("consultation", consultation);

            request.setAttribute("consultationId", consultationId);

            // Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement de la consultation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);
        }
    }
}

