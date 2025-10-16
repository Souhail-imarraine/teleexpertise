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
import java.time.LocalDate;

/**
 * Servlet pour gérer l'ajout de nouveaux patients par l'infirmier
 */
@WebServlet("/infirmier/ajouter-patient")
public class InfirmierAjouterPatientServlet extends HttpServlet {

    private final PatientService patientService;

    public InfirmierAjouterPatientServlet() {
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        // Afficher le formulaire d'ajout
        request.getRequestDispatcher("/WEB-INF/jsp/infirmier/ajouter-patient.jsp").forward(request, response);
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
            // Récupérer les données du formulaire
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            String numeroSS = request.getParameter("numeroSecuriteSociale");
            String dateNaissanceStr = request.getParameter("dateNaissance");
            String telephone = request.getParameter("telephone");
            String adresse = request.getParameter("adresse");
            String antecedents = request.getParameter("antecedents");
            String allergies = request.getParameter("allergies");
            String traitementsEnCours = request.getParameter("traitementsEnCours");

            // Signes vitaux
            String tensionArterielle = request.getParameter("tensionArterielle");
            String frequenceCardiaqueStr = request.getParameter("frequenceCardiaque");
            String temperatureStr = request.getParameter("temperature");
            String frequenceRespiratoireStr = request.getParameter("frequenceRespiratoire");
            String poidsStr = request.getParameter("poids");
            String tailleStr = request.getParameter("taille");

            // Créer l'objet Patient
            Patient patient = new Patient();
            patient.setNom(nom);
            patient.setPrenom(prenom);
            patient.setNumeroSecuriteSociale(numeroSS);

            // Date de naissance
            if (dateNaissanceStr != null && !dateNaissanceStr.trim().isEmpty()) {
                patient.setDateNaissance(LocalDate.parse(dateNaissanceStr));
            }

            // Informations optionnelles
            patient.setTelephone(telephone);
            patient.setAdresse(adresse);
            patient.setAntecedents(antecedents);
            patient.setAllergies(allergies);
            patient.setTraitementsEnCours(traitementsEnCours);

            // Signes vitaux
            patient.setTensionArterielle(tensionArterielle);

            if (frequenceCardiaqueStr != null && !frequenceCardiaqueStr.trim().isEmpty()) {
                patient.setFrequenceCardiaque(Integer.parseInt(frequenceCardiaqueStr));
            }

            if (temperatureStr != null && !temperatureStr.trim().isEmpty()) {
                patient.setTemperature(Double.parseDouble(temperatureStr));
            }

            if (frequenceRespiratoireStr != null && !frequenceRespiratoireStr.trim().isEmpty()) {
                patient.setFrequenceRespiratoire(Integer.parseInt(frequenceRespiratoireStr));
            }

            if (poidsStr != null && !poidsStr.trim().isEmpty()) {
                patient.setPoids(Double.parseDouble(poidsStr));
            }

            if (tailleStr != null && !tailleStr.trim().isEmpty()) {
                patient.setTaille(Double.parseDouble(tailleStr));
            }

            // Utiliser le service pour créer le patient
            Patient patientCree = patientService.creerPatient(patient);

            // Message de succès
            session.setAttribute("successMessage", "Patient " + patientCree.getPrenom() + " " +
                               patientCree.getNom() + " ajouté avec succès à la file d'attente.");

            // Rediriger vers la liste des patients
            response.sendRedirect(request.getContextPath() + "/infirmier/patients");

        } catch (IllegalArgumentException e) {
            // Erreur de validation
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/ajouter-patient.jsp").forward(request, response);

        } catch (Exception e) {
            // Erreur générale (incluant NumberFormatException)
            System.err.println("Erreur lors de l'ajout du patient: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur lors de l'ajout du patient: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/ajouter-patient.jsp").forward(request, response);
        }
    }
}
