package com.example.teleexpertise.controller.Generaliste;

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

/**
 * Servlet pour afficher la liste des patients en attente
 */
@WebServlet("/generaliste/patients")
public class GeneralistePatientsServlet extends HttpServlet {

    private final PatientService patientService;

    public GeneralistePatientsServlet() {
        this.patientService = new PatientService();
    }

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
            List<Patient> patientsAujourdhui = patientService.obtenirPatientsAujourdhui();

            List<Patient> patientsEnAttente = patientsAujourdhui.stream()
                .filter(p -> p.getStatut() != null && "EN_ATTENTE".equals(p.getStatut().name()))
                .collect(Collectors.toList());

            // 3. Calculer les statistiques
            int totalEnAttente = patientsEnAttente.size();

            // 4. Envoyer les données à la JSP
            request.setAttribute("patients", patientsEnAttente);

            // 5. Afficher la page
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/patients.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des patients: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/patients.jsp")
                    .forward(request, response);
        }
    }
}
