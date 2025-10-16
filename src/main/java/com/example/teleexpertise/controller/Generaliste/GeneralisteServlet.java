package com.example.teleexpertise.controller;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.PatientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/generaliste/dashboard")
public class GeneralisteServlet extends HttpServlet {

    private final PatientService patientService;

    public GeneralisteServlet() {
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has correct role
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"GENERALISTE".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Récupérer les patients du jour
            List<Patient> patientsAujourdhui = patientService.obtenirPatientsAujourdhui();

            // Filtrer les patients EN_ATTENTE (Stream API)
            List<Patient> patientsEnAttente = patientsAujourdhui.stream()
                .filter(p -> p.getStatut() != null && "EN_ATTENTE".equals(p.getStatut().name()))
                .collect(Collectors.toList());

            // Statistiques
            long nombrePatientsTotal = patientsAujourdhui.size();
            long nombrePatientsEnAttente = patientsEnAttente.size();

            // Ajouter les données à la requête
            request.setAttribute("patientsEnAttente", patientsEnAttente);
            request.setAttribute("nombrePatientsTotal", nombrePatientsTotal);
            request.setAttribute("nombrePatientsEnAttente", nombrePatientsEnAttente);

            // Forward to dashboard JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/dashboard.jsp")
                    .forward(request, response);
        }
    }
}