package com.example.teleexpertise.controller.auth;

import com.example.teleexpertise.model.utilisateur;
import com.example.teleexpertise.service.AuthService;
import com.example.teleexpertise.util.CsrfUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.authService = new AuthService();
        System.out.println("✅ LoginServlet initialisé avec succès");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Générer un token CSRF pour le formulaire
        HttpSession session = request.getSession(true);
        String csrfToken = CsrfUtil.generateToken(session);
        request.setAttribute("csrfToken", csrfToken);

        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // ✅ Validation du token CSRF
        if (!CsrfUtil.validateToken(request)) {
            request.setAttribute("error", "Token de sécurité invalide. Veuillez réessayer.");
            request.setAttribute("username", request.getParameter("username"));

            // Régénérer un nouveau token
            HttpSession session = request.getSession(true);
            String csrfToken = CsrfUtil.generateToken(session);
            request.setAttribute("csrfToken", csrfToken);

            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            utilisateur user = authService.authenticate(username, password);

            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getPrenom() + " " + user.getNom());
            session.setMaxInactiveInterval(30 * 60);

            // Régénérer un nouveau token CSRF après connexion réussie
            CsrfUtil.generateToken(session);

            String redirectUrl = authService.getRedirectUrlByRole(user.getRole());
            response.sendRedirect(request.getContextPath() + redirectUrl);

        } catch (Exception e) {
            // Handle error
            request.setAttribute("error", e.getMessage());
            request.setAttribute("username", username);

            // Régénérer un nouveau token en cas d'erreur
            HttpSession session = request.getSession(true);
            String csrfToken = CsrfUtil.generateToken(session);
            request.setAttribute("csrfToken", csrfToken);

            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}