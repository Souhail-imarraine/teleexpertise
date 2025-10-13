<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Télé-Expertise Médicale - Accueil</title>
    <style>
        /* =========== RESET & BASE ========== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* ========== HEADER / NAVIGATION ========== */
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.98);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
            padding: 15px 0;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: 700;
            color: #667eea;
        }

        .logo-icon {
            font-size: 32px;
        }

        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        /* ========== HERO SECTION ========== */
        .hero {
            margin-top: 80px;
            min-height: 600px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.1" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,138.7C960,139,1056,117,1152,101.3C1248,85,1344,75,1392,69.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
            background-size: cover;
        }

        .hero-content {
            max-width: 1200px;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .hero-text {
            color: white;
        }

        .hero-text h1 {
            font-size: 48px;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero-text p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.95;
        }

        .hero-buttons {
            display: flex;
            gap: 20px;
        }

        .btn-primary {
            background: white;
            color: #667eea;
            padding: 15px 35px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: transform 0.3s, box-shadow 0.3s;
            display: inline-block;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }

        .btn-secondary {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 15px 35px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            border: 2px solid white;
            transition: all 0.3s;
            display: inline-block;
        }

        .btn-secondary:hover {
            background: white;
            color: #667eea;
        }

        .hero-image {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .hero-illustration {
            font-size: 250px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        /* ========== FEATURES SECTION ========== */
        .features {
            padding: 80px 20px;
            background: #f8f9fa;
        }

        .features-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title h2 {
            font-size: 36px;
            color: #333;
            margin-bottom: 15px;
        }

        .section-title p {
            font-size: 18px;
            color: #666;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .feature-card {
            background: white;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .feature-icon {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-size: 22px;
            color: #333;
            margin-bottom: 15px;
        }

        .feature-card p {
            color: #666;
            line-height: 1.8;
        }

        /* ========== ROLES SECTION ========== */
        .roles {
            padding: 80px 20px;
            background: white;
        }

        .roles-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .roles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .role-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 40px;
            border-radius: 20px;
            color: white;
            text-align: center;
            transition: transform 0.3s;
            cursor: pointer;
        }

        .role-card:hover {
            transform: scale(1.05);
        }

        .role-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .role-card h3 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        .role-card ul {
            text-align: left;
            list-style: none;
            margin-top: 20px;
        }

        .role-card li {
            margin-bottom: 10px;
            padding-left: 25px;
            position: relative;
        }

        .role-card li::before {
            content: '✓';
            position: absolute;
            left: 0;
            font-weight: bold;
        }

        /* ========== CTA SECTION ========== */
        .cta {
            padding: 80px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            text-align: center;
            color: white;
        }

        .cta h2 {
            font-size: 36px;
            margin-bottom: 20px;
        }

        .cta p {
            font-size: 18px;
            margin-bottom: 40px;
            opacity: 0.95;
        }

        /* ========== FOOTER ========== */
        .footer {
            background: #2d3748;
            color: white;
            padding: 40px 20px;
            text-align: center;
        }

        .footer p {
            margin-bottom: 10px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: #667eea;
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 768px) {
            .hero-content {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .hero-text h1 {
                font-size: 32px;
            }

            .hero-buttons {
                justify-content: center;
                flex-wrap: wrap;
            }

            .hero-illustration {
                font-size: 150px;
            }

            .nav-links {
                display: none;
            }
        }
    </style>
</head>
<body>
<!-- ========== NAVIGATION BAR ========== -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">
            <span class="logo-icon">🏥</span>
            <span>Télé-Expertise</span>
        </div>
        <ul class="nav-links">
            <li><a href="#accueil">Accueil</a></li>
            <li><a href="#fonctionnalites">Fonctionnalités</a></li>
            <li><a href="#roles">Rôles</a></li>
            <li><a href="#contact">Contact</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/login" class="btn-login">
            🔐 Se connecter
        </a>
    </div>
</nav>

<!-- ========== HERO SECTION ========== -->
<section id="accueil" class="hero">
    <div class="hero-content">
        <div class="hero-text">
            <h1>Plateforme de Télé-Expertise Médicale</h1>
            <p>
                Optimisez le parcours patient en facilitant la coordination entre
                médecins généralistes et spécialistes. Une prise en charge efficace
                et rapide pour de meilleurs soins.
            </p>
            <div class="hero-buttons">
                <a href="${pageContext.request.contextPath}/login" class="btn-primary">
                    Commencer maintenant →
                </a>
                <a href="#fonctionnalites" class="btn-secondary">
                    En savoir plus
                </a>
            </div>
        </div>
        <div class="hero-image">
            <div class="hero-illustration">🏥</div>
        </div>
    </div>
</section>

<!-- ========== FEATURES SECTION ========== -->
<section id="fonctionnalites" class="features">
    <div class="features-container">
        <div class="section-title">
            <h2>Fonctionnalités Principales</h2>
            <p>Un système complet pour une meilleure coordination médicale</p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">👨‍⚕️</div>
                <h3>Accueil Patient</h3>
                <p>
                    Enregistrement rapide des patients avec saisie des signes vitaux
                    et données médicales essentielles par l'équipe infirmière.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📋</div>
                <h3>Consultation Médicale</h3>
                <p>
                    Création de consultations complètes avec examens cliniques,
                    diagnostics et prescriptions par les médecins généralistes.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3>Télé-Expertise</h3>
                <p>
                    Demande d'avis spécialisé en temps réel avec possibilité
                    d'échange synchrone ou asynchrone entre professionnels.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📅</div>
                <h3>Gestion Créneaux</h3>
                <p>
                    Planification intelligente des disponibilités des spécialistes
                    avec créneaux de 30 minutes et mise à jour automatique.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3>Calcul Automatique</h3>
                <p>
                    Facturation automatique incluant consultation, actes techniques
                    et expertise avec transparence totale des coûts.
                </p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Suivi en Temps Réel</h3>
                <p>
                    Tableaux de bord personnalisés par rôle avec statistiques,
                    file d'attente et historique des consultations.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- ========== ROLES SECTION ========== -->
<section id="roles" class="roles">
    <div class="roles-container">
        <div class="section-title">
            <h2>Accès par Rôle</h2>
            <p>Chaque utilisateur dispose d'un espace personnalisé selon son rôle</p>
        </div>

        <div class="roles-grid">
            <div class="role-card">
                <div class="role-icon">👨‍⚕️</div>
                <h3>Infirmier</h3>
                <p>Accueil et enregistrement des patients</p>
                <ul>
                    <li>Enregistrer un patient</li>
                    <li>Saisir les signes vitaux</li>
                    <li>Gérer la file d'attente</li>
                    <li>Liste patients du jour</li>
                </ul>
            </div>

            <div class="role-card">
                <div class="role-icon">👨‍⚕️</div>
                <h3>Médecin Généraliste</h3>
                <p>Consultation et coordination des soins</p>
                <ul>
                    <li>Créer des consultations</li>
                    <li>Établir diagnostics</li>
                    <li>Demander avis spécialiste</li>
                    <li>Prescrire actes techniques</li>
                </ul>
            </div>

            <div class="role-card">
                <div class="role-icon">👨‍⚕️</div>
                <h3>Médecin Spécialiste</h3>
                <p>Expertise et conseil médical</p>
                <ul>
                    <li>Gérer les créneaux horaires</li>
                    <li>Consulter demandes expertise</li>
                    <li>Fournir avis médical</li>
                    <li>Recommandations thérapeutiques</li>
                </ul>
            </div>
        </div>
    </div>
</section>

<!-- ========== CTA SECTION ========== -->
<section class="cta">
    <h2>Prêt à commencer ?</h2>
    <p>Connectez-vous dès maintenant pour accéder à votre espace personnalisé</p>
    <a href="${pageContext.request.contextPath}/login" class="btn-primary">
        Se connecter maintenant →
    </a>
</section>

<!-- ========== FOOTER ========== -->
<footer class="footer">
    <p>&copy; 2025 Télé-Expertise Médicale. Tous droits réservés.</p>
    <div class="footer-links">
        <a href="#accueil">Accueil</a>
        <a href="#fonctionnalites">Fonctionnalités</a>
        <a href="#roles">Rôles</a>
        <a href="#contact">Contact</a>
    </div>
    <p style="margin-top: 20px; font-size: 14px; opacity: 0.8;">
        Plateforme de coordination médicale pour une meilleure prise en charge des patients
    </p>
</footer>

<!-- ========== JAVASCRIPT ========== -->
<script>
    // Animation au scroll
    document.addEventListener('DOMContentLoaded', function() {
        // Smooth scroll pour les liens d'ancrage
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Animation des cartes au scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '0';
                    entry.target.style.transform = 'translateY(20px)';
                    entry.target.style.transition = 'opacity 0.6s ease, transform 0.6s ease';

                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }, 100);

                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        // Observer toutes les cartes
        document.querySelectorAll('.feature-card, .role-card').forEach(card => {
            observer.observe(card);
        });
    });

    // Change navbar background on scroll
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.style.background = 'rgba(255, 255, 255, 1)';
            navbar.style.boxShadow = '0 4px 15px rgba(0,0,0,0.1)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
            navbar.style.boxShadow = '0 2px 10px rgba(0,0,0,0.1)';
        }
    });
</script>
</body>
</html>

