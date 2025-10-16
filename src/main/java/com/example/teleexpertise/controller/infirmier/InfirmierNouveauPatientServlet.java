//package com.example.teleexpertise.controller.infirmier;
//
//import com.example.teleexpertise.model.utilisateur;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//
//@WebServlet("/infirmier/accueil/nouveau")
//public class InfirmierNouveauPatientServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        request.setCharacterEncoding("UTF-8");
//
//        // Vérifier si l'utilisateur est connecté
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//
//        // Vérifier le rôle
//        utilisateur user = (utilisateur) session.getAttribute("user");
//        if (!"INFIRMIER".equalsIgnoreCase(user.getRole())) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }
//
//        // Rediriger vers la page d'accueil (formulaire nouveau patient)
//        request.getRequestDispatcher("/WEB-INF/jsp/infirmier/accueil.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Gérer l'enregistrement d'un nouveau patient
//        doGet(request, response);
//    }
//}
//
