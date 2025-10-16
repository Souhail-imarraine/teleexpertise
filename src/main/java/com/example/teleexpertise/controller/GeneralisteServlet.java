package com.example.teleexpertise.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/generaliste/dashboard")
public class GeneralisteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if user has correct role
        String userRole = (String) session.getAttribute("userRole");
        if (!"GENERALISTE".equalsIgnoreCase(userRole)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/generaliste/dashboard.jsp")
                .forward(request, response);
    }
}