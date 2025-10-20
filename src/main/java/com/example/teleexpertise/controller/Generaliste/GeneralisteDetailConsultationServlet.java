package com.example.teleexpertise.controller.Generaliste;

import com.example.teleexpertise.model.Consultation;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.ConsultationService;
import com.example.teleexpertise.util.DateUtil;
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
            int consultationId = Integer.parseInt(consultationIdStr);

            // 4. Récupérer la consultation via le service
            System.out.println("🔍 Chargement de la consultation ID: " + consultationId);
            Consultation consultation = consultationService.obtenirConsultationParId((long) consultationId);

            if (consultation == null) {
                System.out.println("❌ Consultation introuvable avec ID: " + consultationId);
                session.setAttribute("errorMessage", "Consultation introuvable");
                response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
                return;
            }

            System.out.println("✅ Consultation chargée: " + consultation.getId() + " - " + consultation.getMotif());

            // 5. Vérifier que la consultation appartient bien au généraliste connecté
            if (consultation.getGeneraliste().getId() != user.getId()) {
                System.out.println("⚠️ Accès refusé: La consultation n'appartient pas au généraliste");
                session.setAttribute("errorMessage", "Vous n'avez pas accès à cette consultation");
                response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
                return;
            }

            System.out.println("✅ Accès autorisé pour le généraliste ID: " + user.getId());

            // 6. Préparer les données formatées avec DateUtil
            String dateConsultation = DateUtil.formatDate(consultation.getDateConsultation());
            String timeConsultation = DateUtil.formatTime(consultation.getDateConsultation());
            String dateNaissanceFormatted = DateUtil.formatDate(consultation.getPatient().getDateNaissance());

            // Préparer les initiales du patient
            String patientInitials = "??";
            if (consultation.getPatient() != null) {
                String nom = consultation.getPatient().getNom() != null ? consultation.getPatient().getNom() : "";
                String prenom = consultation.getPatient().getPrenom() != null ? consultation.getPatient().getPrenom() : "";

                if (!nom.isEmpty() && !prenom.isEmpty()) {
                    patientInitials = nom.substring(0, 1).toUpperCase() + prenom.substring(0, 1).toUpperCase();
                }
            }

            // 7. Envoyer les données à la JSP
            request.setAttribute("consultation", consultation);
            request.setAttribute("dateConsultation", dateConsultation);
            request.setAttribute("timeConsultation", timeConsultation);
            request.setAttribute("patientInitials", patientInitials);
            request.setAttribute("dateNaissanceFormatted", dateNaissanceFormatted);

            // 8. Forward vers la JSP
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("❌ Format d'ID invalide: " + e.getMessage());
            session.setAttribute("errorMessage", "ID de consultation invalide");
            response.sendRedirect(request.getContextPath() + "/generaliste/consultations");
        } catch (IllegalArgumentException e) {
            System.out.println("❌ Erreur: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement de la consultation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);
        } catch (Exception e) {
            System.out.println("❌ Erreur inattendue lors du chargement de la consultation");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement de la consultation: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/generaliste/detail-consultation.jsp")
                    .forward(request, response);
        }
    }
}
