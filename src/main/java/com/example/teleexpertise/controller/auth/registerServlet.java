package com.example.teleexpertise.controller.auth;

import com.example.teleexpertise.service.AuthService;
import com.example.teleexpertise.util.CsrfUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = "/register")
public class registerServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.authService = new AuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Générer un token CSRF pour le formulaire
        HttpSession session = request.getSession(true);
        String csrfToken = CsrfUtil.generateToken(session);
        request.setAttribute("csrfToken", csrfToken);

        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // ✅ Validation du token CSRF
        if (!CsrfUtil.validateToken(request)) {
            request.setAttribute("error", "Token de sécurité invalide. Veuillez réessayer.");

            // Préserver les données saisies
            request.setAttribute("nom", request.getParameter("lastName"));
            request.setAttribute("prenom", request.getParameter("firstName"));
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("role", request.getParameter("role"));
            request.setAttribute("specialite", request.getParameter("specialite"));

            // Régénérer un nouveau token
            HttpSession session = request.getSession(true);
            String csrfToken = CsrfUtil.generateToken(session);
            request.setAttribute("csrfToken", csrfToken);

            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        // Récupération des paramètres du formulaire
        String nom = request.getParameter("lastName");
        String prenom = request.getParameter("firstName");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String specialite = request.getParameter("specialite");

        try {
            authService.registerUser(nom, prenom, email, motDePasse, confirmPassword, role, specialite);
            request.getSession().setAttribute("successMessage", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            response.sendRedirect(request.getContextPath() + "/login");

        } catch (Exception e) {
            // Error - forward back to form with error message and preserved data
            request.setAttribute("error", e.getMessage());
            request.setAttribute("nom", nom);
            request.setAttribute("prenom", prenom);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("specialite", specialite);

            // Régénérer un nouveau token en cas d'erreur
            HttpSession session = request.getSession(true);
            String csrfToken = CsrfUtil.generateToken(session);
            request.setAttribute("csrfToken", csrfToken);

            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
