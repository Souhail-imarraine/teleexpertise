<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Infirmier - Télé-Expertise</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
        }

        /* HEADER */
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 24px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info span {
            font-size: 14px;
        }

        .btn-logout {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.3s;
        }

        .btn-logout:hover {
            background: rgba(255,255,255,0.3);
        }

        /* CONTAINER */
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* WELCOME CARD */
        .welcome-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .welcome-card h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-card p {
            color: #666;
        }

        /* STATS CARDS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 40px;
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        .stat-icon.blue {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stat-icon.green {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        .stat-icon.orange {
            background: linear-gradient(135deg, #f2994a 0%, #f2c94c 100%);
        }

        .stat-content h3 {
            font-size: 28px;
            color: #333;
            margin-bottom: 5px;
        }

        .stat-content p {
            color: #666;
            font-size: 14px;
        }

        /* ACTIONS GRID */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .action-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s;
            cursor: pointer;
        }

        .action-card:hover {
            transform: translateY(-5px);
        }

        .action-card .icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .action-card h3 {
            color: #333;
            margin-bottom: 10px;
        }

        .action-card p {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .btn-action {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.3s;
        }

        .btn-action:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <!-- HEADER -->
    <div class="header">
        <h1>👨‍⚕️ Dashboard Infirmier</h1>
        <div class="user-info">
            <span>👤 ${sessionScope.userName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Déconnexion</a>
        </div>
    </div>

    <!-- CONTAINER -->
    <div class="container">
        <!-- WELCOME CARD -->
        <div class="welcome-card">
            <h2>Bienvenue, ${sessionScope.userName} !</h2>
            <p>Vous êtes connecté en tant qu'<strong>Infirmier</strong>. Voici votre tableau de bord.</p>
        </div>

        <!-- STATS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">👥</div>
                <div class="stat-content">
                    <h3>0</h3>
                    <p>Patients en attente</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">✅</div>
                <div class="stat-content">
                    <h3>0</h3>
                    <p>Patients enregistrés aujourd'hui</p>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon orange">🏥</div>
                <div class="stat-content">
                    <h3>0</h3>
                    <p>Consultations en cours</p>
                </div>
            </div>
        </div>

        <!-- ACTIONS -->
        <div class="actions-grid">
            <div class="action-card">
                <div class="icon">➕</div>
                <h3>Enregistrer un patient</h3>
                <p>Ajouter un nouveau patient ou mettre à jour les signes vitaux d'un patient existant</p>
                <a href="${pageContext.request.contextPath}/infirmier/patient/nouveau" class="btn-action">
                    Commencer
                </a>
            </div>

            <div class="action-card">
                <div class="icon">📋</div>
                <h3>Liste des patients</h3>
                <p>Voir tous les patients enregistrés aujourd'hui avec leurs signes vitaux</p>
                <a href="${pageContext.request.contextPath}/infirmier/patients" class="btn-action">
                    Voir la liste
                </a>
            </div>

            <div class="action-card">
                <div class="icon">⏰</div>
                <h3>File d'attente</h3>
                <p>Gérer la file d'attente des patients en attente de consultation</p>
                <a href="${pageContext.request.contextPath}/infirmier/file-attente" class="btn-action">
                    Gérer
                </a>
            </div>
        </div>
    </div>

    <script>
        // Animation au chargement
        window.addEventListener('load', function() {
            const cards = document.querySelectorAll('.stat-card, .action-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';

                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 50);
                }, index * 100);
            });
        });
    </script>
</body>
</html>
package com.example.teleexpertise.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet Dashboard - Point d'entrée après connexion
 * Redirige vers le dashboard approprié selon le rôle
 *
 * EXPLICATION :
 * - Après connexion, l'utilisateur arrive sur /dashboard
 * - Le servlet vérifie le rôle dans la session
 * - Redirige vers le dashboard spécifique (infirmier, generaliste, specialiste)
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier si l'utilisateur est connecté
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            // Pas de session → Redirection vers login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupérer le rôle depuis la session
        String role = (String) session.getAttribute("userRole");

        // Redirection selon le rôle
        switch (role) {
            case "INFIRMIER":
                response.sendRedirect(request.getContextPath() + "/infirmier/dashboard");
                break;
            case "GENERALISTE":
                response.sendRedirect(request.getContextPath() + "/generaliste/dashboard");
                break;
            case "SPECIALISTE":
                response.sendRedirect(request.getContextPath() + "/specialiste/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}

