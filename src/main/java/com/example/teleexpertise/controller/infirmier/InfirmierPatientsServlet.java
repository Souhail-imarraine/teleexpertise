package com.example.teleexpertise.controller.infirmier;

import com.example.teleexpertise.model.Patient;
import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.PatientService;
import com.example.teleexpertise.util.DateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/infirmier/patients")
public class InfirmierPatientsServlet extends HttpServlet {

    private final PatientService patientService;

    public InfirmierPatientsServlet() {
        this.patientService = new PatientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Vérifier si l'utilisateur est connecté
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
            // Récupérer les patients d'aujourd'hui (triés par heure d'arrivée)
            List<Patient> patientsAujourdhui = patientService.obtenirPatientsAujourdhui();

            // Compter les patients
            long nombrePatients = patientService.compterPatientsAujourdhui();

            // Préparer les données formatées pour chaque patient
            Map<Integer, String> ageMap = new HashMap<>();
            Map<Integer, String> dateNaissanceMap = new HashMap<>();

            for (Patient patient : patientsAujourdhui) {
                int patientId = patient.getId();

                // Utiliser DateUtil pour calculer l'âge et formater la date
                ageMap.put(patientId, DateUtil.calculerAgeFormate(patient.getDateNaissance()));
                dateNaissanceMap.put(patientId, DateUtil.formatDate(patient.getDateNaissance()));
            }

            // Ajouter les données à la requête
            request.setAttribute("patients", patientsAujourdhui);
            request.setAttribute("nombrePatients", nombrePatients);
            request.setAttribute("ageMap", ageMap);
            request.setAttribute("dateNaissanceMap", dateNaissanceMap);

            // Rediriger vers la page liste des patients
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/patients.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement des patients: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/infirmier/patients.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
