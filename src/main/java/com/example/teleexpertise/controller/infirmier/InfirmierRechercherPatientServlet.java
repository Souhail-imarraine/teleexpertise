package com.example.teleexpertise.controller.infirmier;

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

/**
 * Servlet pour rechercher un patient existant
 */
@WebServlet("/infirmier/rechercher-patient")
public class InfirmierRechercherPatientServlet extends HttpServlet {

    private final PatientService patientService;

    public InfirmierRechercherPatientServlet() {
        this.patientService = new PatientService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Vérifier l'authentification
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Vérifier le rôle
        utilisateur user = (utilisateur) session.getAttribute("user");
        if (!"INFIRMIER".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String numeroSS = request.getParameter("numeroSecuriteSociale");
            String searchTerm = request.getParameter("searchTerm");

            // Recherche par numéro de sécurité sociale (prioritaire)
            if (numeroSS != null && !numeroSS.trim().isEmpty()) {
                Patient patient = patientService.rechercherParNumeroSS(numeroSS.trim());

                if (patient != null) {
                    // Patient trouvé - afficher ses informations
                    request.setAttribute("patient", patient);
                    request.setAttribute("patientExistant", true);
                } else {
                    // Patient non trouvé
                    request.setAttribute("patientExistant", false);
                    request.setAttribute("infoMessage", "Aucun patient trouvé avec le numéro de sécurité sociale : " + numeroSS);
                }
            }
            // Recherche par nom ou prénom
            else if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                List<Patient> patients = patientService.rechercherParNomOuPrenom(searchTerm.trim());

                if (patients != null && !patients.isEmpty()) {
                    if (patients.size() == 1) {
                        // Un seul patient trouvé
                        request.setAttribute("patient", patients.get(0));
                        request.setAttribute("patientExistant", true);
                    } else {
                        // Plusieurs patients trouvés - afficher la liste
                        request.setAttribute("patientsRecherche", patients);
                        request.setAttribute("multiplePatients", true);
                        request.setAttribute("infoMessage", patients.size() + " patient(s) trouvé(s). Veuillez sélectionner le patient souhaité.");
                    }
                } else {
                    // Aucun patient trouvé
                    request.setAttribute("patientExistant", false);
                    request.setAttribute("infoMessage", "Aucun patient trouvé avec le terme de recherche : " + searchTerm);
                }
            } else {
                // Aucun critère de recherche fourni
                request.setAttribute("searchErrorMessage", "Veuillez saisir un numéro de sécurité sociale ou un nom/prénom pour rechercher un patient.");
            }

            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("searchErrorMessage", "Erreur lors de la recherche: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si un ID de patient est fourni dans l'URL (sélection depuis la liste)
        String patientIdStr = request.getParameter("patientId");

        if (patientIdStr != null && !patientIdStr.trim().isEmpty()) {
            try {
                Long patientId = Long.parseLong(patientIdStr);
                Patient patient = patientService.obtenirPatientParId(patientId);

                if (patient != null) {
                    request.setAttribute("patient", patient);
                    request.setAttribute("patientExistant", true);
                } else {
                    request.setAttribute("searchErrorMessage", "Patient introuvable.");
                }

                request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                request.setAttribute("searchErrorMessage", "ID de patient invalide.");
                request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
                return;
            }
        }

        // Sinon, rediriger vers POST
        doPost(request, response);
    }
}
