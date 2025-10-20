package com.example.teleexpertise.controller.Specialiste;

import com.example.teleexpertise.model.Specialiste;
import com.example.teleexpertise.service.SpecialisteService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet pour gérer le profil du spécialiste
 */
@WebServlet("/specialiste/profil")
public class SpecialisteProfilServlet extends HttpServlet {
    private SpecialisteService specialisteService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.specialisteService = new SpecialisteService();
        System.out.println("✅ SpecialisteProfilServlet initialisé");
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
            Object userIdObj = session.getAttribute("userId");
            Long specialisteId = (userIdObj instanceof Integer)
                ? ((Integer) userIdObj).longValue()
                : (Long) userIdObj;

            Specialiste specialiste = specialisteService.getSpecialisteById(specialisteId);
            request.setAttribute("specialiste", specialiste);

            request.getRequestDispatcher("/WEB-INF/jsp/specialiste/profil.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors du chargement du profil");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Object userIdObj = session.getAttribute("userId");
            Long specialisteId = (userIdObj instanceof Integer)
                ? ((Integer) userIdObj).longValue()
                : (Long) userIdObj;

            Specialiste specialiste = specialisteService.getSpecialisteById(specialisteId);

            if (specialiste != null) {
                // Mettre à jour les informations
                String tarifStr = request.getParameter("tarif");
                String dureeStr = request.getParameter("dureeMoyenneConsultation");

                if (tarifStr != null && !tarifStr.isEmpty()) {
                    specialiste.setTarif(Double.parseDouble(tarifStr));
                }

                if (dureeStr != null && !dureeStr.isEmpty()) {
                    specialiste.setDureeMoyenneConsultation(Integer.parseInt(dureeStr));
                }

                boolean success = specialisteService.updateProfil(specialiste);

                if (success) {
                    session.setAttribute("successMessage", "Profil mis à jour avec succès");
                } else {
                    session.setAttribute("errorMessage", "Erreur lors de la mise à jour");
                }
            }

            response.sendRedirect(request.getContextPath() + "/specialiste/profil");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Erreur lors de la mise à jour du profil");
            response.sendRedirect(request.getContextPath() + "/specialiste/profil");
        }
    }
}

