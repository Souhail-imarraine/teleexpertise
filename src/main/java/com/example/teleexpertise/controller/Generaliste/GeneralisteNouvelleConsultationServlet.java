package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.PatientService;
import com.example.teleexpertise.service.ConsultationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour créer une nouvelle consultation
 */
@WebServlet("/generaliste/nouvelle-consultation")
public class GeneralisteNouvelleConsultationServlet extends HttpServlet {

    private final PatientService patientService;
    private final ConsultationService consultationService;

    public GeneralisteNouvelleConsultationServlet() {
        this.patientService = new PatientService();
        this.consultationService = new ConsultationService();
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
            // Récupérer l'ID du patient depuis l'URL
            String patientIdStr = request.getParameter("patientId");
            if (patientIdStr != null && !patientIdStr.isEmpty()) {
                Long patientId = Long.parseLong(patientIdStr);
                // Récupérer le patient via le service
                Patient patient = patientService.obtenirPatientParId(patientId);
                // Envoyer le patient au formulaire
                request.setAttribute("patient", patient);
            }

            // Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID du patient invalide");
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du patient: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
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
            // 1. Récupérer les données du formulaire
            String patientIdStr = request.getParameter("patientId");
            String motif = request.getParameter("motif");
            String symptomes = request.getParameter("symptomes");
            String examen = request.getParameter("examen");
            String observations = request.getParameter("observations");
            String diagnostic = request.getParameter("diagnostic");
            String traitement = request.getParameter("traitement");

            // 2. Valider les données obligatoires
            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Le patient est requis");
                request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                        .forward(request, response);
                return;
            }

            Long patientId = Long.parseLong(patientIdStr);
            Long generalisteId = Long.valueOf(user.getId());
            // 3. Créer la consultation via le service
            Consultation consultation = consultationService.creerConsultation(
                    patientId,
                    generalisteId,
                    motif,
                    symptomes,
                    examen,
                    observations,
                    diagnostic,
                    traitement
            );

            // 4. Rediriger avec message de succès
            session.setAttribute("successMessage", "Consultation créée avec succès !");
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Données invalides");
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);
        } catch (IllegalArgumentException e) {
            // Récupérer le patient pour réafficher le formulaire
            try {
                String patientIdStr = request.getParameter("patientId");
                if (patientIdStr != null && !patientIdStr.isEmpty()) {
                    Long patientId = Long.parseLong(patientIdStr);
                    Patient patient = patientService.obtenirPatientParId(patientId);
                    request.setAttribute("patient", patient);
                }
            } catch (Exception ex) {
                // Ignore
            }

            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();

            try {
                String patientIdStr = request.getParameter("patientId");
                if (patientIdStr != null && !patientIdStr.isEmpty()) {
                    Long patientId = Long.parseLong(patientIdStr);
                    Patient patient = patientService.obtenirPatientParId(patientId);
                    request.setAttribute("patient", patient);
                }
            } catch (Exception ex) {
                // Ignore
            }

            request.setAttribute("errorMessage", "Erreur lors de la création de la consultation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/nouvelle-consultation.jsp")
                    .forward(request, response);
        }
    }
}
