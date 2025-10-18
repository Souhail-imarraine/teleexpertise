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
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Servlet pour afficher toutes les consultations du généraliste connecté
 */
@WebServlet("/generaliste/consultations")
public class GeneralisteConsultationsServlet extends HttpServlet {

    private final ConsultationService consultationService;

    public GeneralisteConsultationsServlet() {
        this.consultationService = new ConsultationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // 1. Vérifier si l'utilisateur est connecté
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
            // 3. Récupérer l'ID du généraliste connecté
            Long generalisteId = (long) user.getId();

            // 4. Récupérer toutes les consultations de ce généraliste via le service
            List<Consultation> consultations = consultationService.obtenirConsultationsParGeneraliste(generalisteId);

            // 5. Préparer les données formatées pour éviter les appels de méthodes dans JSP
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            Map<Integer, String> dateMap = new HashMap<>();
            Map<Integer, String> timeMap = new HashMap<>();
            Map<Integer, String> patientInitialsMap = new HashMap<>();
            Map<Integer, String> patientFullNameMap = new HashMap<>();
            Map<Integer, String> patientNssMap = new HashMap<>();
            Map<Integer, Boolean> hasActesTechniquesMap = new HashMap<>();
            Map<Integer, Boolean> hasDemandeExpertiseMap = new HashMap<>();

            for (Consultation consultation : consultations) {
                int id = consultation.getId();

                // Formater la date et l'heure
                if (consultation.getDateConsultation() != null) {
                    dateMap.put(id, consultation.getDateConsultation().format(dateFormatter));
                    timeMap.put(id, consultation.getDateConsultation().format(timeFormatter));
                } else {
                    dateMap.put(id, "-");
                    timeMap.put(id, "-");
                }

                // Préparer les informations du patient
                if (consultation.getPatient() != null) {
                    String nom = consultation.getPatient().getNom() != null ? consultation.getPatient().getNom() : "";
                    String prenom = consultation.getPatient().getPrenom() != null ? consultation.getPatient().getPrenom() : "";

                    // Créer les initiales
                    String initiales = "";
                    if (!nom.isEmpty()) {
                        initiales += nom.substring(0, 1).toUpperCase();
                    }
                    if (!prenom.isEmpty()) {
                        initiales += prenom.substring(0, 1).toUpperCase();
                    }

                    patientInitialsMap.put(id, initiales);
                    patientFullNameMap.put(id, nom + " " + prenom);
                    patientNssMap.put(id, consultation.getPatient().getNumeroSecuriteSociale() != null
                        ? consultation.getPatient().getNumeroSecuriteSociale() : "-");
                } else {
                    patientInitialsMap.put(id, "??");
                    patientFullNameMap.put(id, "Patient inconnu");
                    patientNssMap.put(id, "-");
                }

                // Vérifier si la consultation a des actes techniques ou une demande d'expertise
                hasActesTechniquesMap.put(id, consultation.getActesTechniques() != null && !consultation.getActesTechniques().isEmpty());
                hasDemandeExpertiseMap.put(id, consultation.getDemandeExpertise() != null);
            }

            // 6. Envoyer les données à la JSP
            request.setAttribute("consultations", consultations);
            request.setAttribute("dateMap", dateMap);
            request.setAttribute("timeMap", timeMap);
            request.setAttribute("patientInitialsMap", patientInitialsMap);
            request.setAttribute("patientFullNameMap", patientFullNameMap);
            request.setAttribute("patientNssMap", patientNssMap);
            request.setAttribute("hasActesTechniquesMap", hasActesTechniquesMap);
            request.setAttribute("hasDemandeExpertiseMap", hasDemandeExpertiseMap);

            // 7. Afficher les messages de succès/erreur s'ils existent
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }

            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage");
            }

            // 8. Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/consultations.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des consultations: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/consultations.jsp")
                    .forward(request, response);
        }
    }
}
