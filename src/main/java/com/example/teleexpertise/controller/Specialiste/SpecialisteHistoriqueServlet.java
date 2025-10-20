package com.example.teleexpertise.controller.Specialiste;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour afficher l'historique des expertises du spécialiste
 */
@WebServlet("/specialiste/historique")
public class SpecialisteHistoriqueServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("✅ SpecialisteHistoriqueServlet initialisé");
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
            request.getRequestDispatcher("/WEB-INF/jsp/specialiste/historique.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement de l'historique");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
                    .forward(request, response);
        }
    }
}

