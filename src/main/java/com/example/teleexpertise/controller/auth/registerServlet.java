package com.example.teleexpertise.controller.auth;
import com.example.teleexpertise.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(value = "/register")
public class registerServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.authService = new AuthService();
        System.out.println("✅ RegisterServlet initialisé avec succès");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Récupération des paramètres du formulaire
        String nom = request.getParameter("lastName");
        String prenom = request.getParameter("firstName");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String specialite = request.getParameter("specialite");

        try {
            // Vérification que les mots de passe correspondent
            if (motDePasse == null || !motDePasse.equals(confirmPassword)) {
                request.setAttribute("error", "Les mots de passe ne correspondent pas");
                request.setAttribute("nom", nom);
                request.setAttribute("prenom", prenom);
                request.setAttribute("email", email);
                request.setAttribute("role", role);
                request.setAttribute("specialite", specialite);
                request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
                return;
            }

            // Vérification que la spécialité est fournie pour les spécialistes
            if ("SPECIALISTE".equals(role) && (specialite == null || specialite.trim().isEmpty())) {
                request.setAttribute("error", "Veuillez sélectionner une spécialité médicale");
                request.setAttribute("nom", nom);
                request.setAttribute("prenom", prenom);
                request.setAttribute("email", email);
                request.setAttribute("role", role);
                request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
                return;
            }

            // Appel du service d'inscription (le mot de passe sera haché dans AuthService)
            authService.register(nom, prenom, email, motDePasse, role, specialite);

            // Succès : redirection vers la page de connexion avec message
            System.out.println("✅ Inscription réussie pour : " + email);
            request.getSession().setAttribute("successMessage",
                "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            response.sendRedirect(request.getContextPath() + "/");

        } catch (Exception e) {
            // Erreur : retour au formulaire avec message d'erreur
            System.out.println("❌ Erreur inscription : " + e.getMessage());
            request.setAttribute("error", e.getMessage());
            request.setAttribute("nom", nom);
            request.setAttribute("prenom", prenom);
            request.setAttribute("email", email);
            request.setAttribute("role", role);
            request.setAttribute("specialite", specialite);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
