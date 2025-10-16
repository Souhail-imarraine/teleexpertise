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

/**
 * Servlet pour mettre à jour les signes vitaux d'un patient existant
 */
@WebServlet("/infirmier/mettre-a-jour-patient")
public class InfirmierMettreAJourPatientServlet extends HttpServlet {

    private final PatientService patientService;

    public InfirmierMettreAJourPatientServlet() {
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
            // Récupérer l'ID du patient
            String patientIdStr = request.getParameter("patientId");

            if (patientIdStr == null || patientIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "ID du patient manquant");
                request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
                return;
            }

            Long patientId = Long.parseLong(patientIdStr);

            // Récupérer les signes vitaux
            String tensionArterielle = request.getParameter("tensionArterielle");
            String frequenceCardiaqueStr = request.getParameter("frequenceCardiaque");
            String temperatureStr = request.getParameter("temperature");
            String frequenceRespiratoireStr = request.getParameter("frequenceRespiratoire");
            String poidsStr = request.getParameter("poids");
            String tailleStr = request.getParameter("taille");

            // Convertir les valeurs numériques
            Integer frequenceCardiaque = null;
            if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.trim().isEmpty()) {
                frequenceCardiaque = Integer.parseInt(frequenceCardiaqueStr);
            }

            Double temperature = null;
            if (temperatureStr != null && !temperatureStr.trim().isEmpty()) {
                temperature = Double.parseDouble(temperatureStr);
            }

            Integer frequenceRespiratoire = null;
            if (frequenceRespiratoireStr != null && !frequenceRespiratoireStr.trim().isEmpty()) {
                frequenceRespiratoire = Integer.parseInt(frequenceRespiratoireStr);
            }

            Double poids = null;
            if (poidsStr != null && !poidsStr.trim().isEmpty()) {
                poids = Double.parseDouble(poidsStr);
            }

            Double taille = null;
            if (tailleStr != null && !tailleStr.trim().isEmpty()) {
                taille = Double.parseDouble(tailleStr);
            }

            // Utiliser le service pour mettre à jour le patient
            Patient patientMisAJour = patientService.mettreAJourSignesVitaux(
                patientId, tensionArterielle, frequenceCardiaque, temperature,
                frequenceRespiratoire, poids, taille
            );

            // Message de succès
            session.setAttribute("successMessage", "Patient " + patientMisAJour.getPrenom() + " " +
                               patientMisAJour.getNom() + " mis à jour et ajouté à la file d'attente.");

            // Rediriger vers la liste des patients
            response.sendRedirect(request.getContextPath() + "/infirmier/patients");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Format de nombre invalide. Vérifiez les signes vitaux.");
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la mise à jour: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
        }
    }
}

