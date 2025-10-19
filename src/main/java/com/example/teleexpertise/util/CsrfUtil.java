package com.example.teleexpertise.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utilitaire pour la protection CSRF (Cross-Site Request Forgery)
 */
public class CsrfUtil {

    private static final String CSRF_TOKEN_SESSION_ATTR = "csrfToken";
    private static final int TOKEN_LENGTH = 32;
    private static final SecureRandom secureRandom = new SecureRandom();

    /**
     * Génère un nouveau token CSRF et le stocke dans la session
     */
    public static String generateToken(HttpSession session) {
        byte[] tokenBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
        session.setAttribute(CSRF_TOKEN_SESSION_ATTR, token);
        return token;
    }

    /**
     * Récupère le token CSRF de la session, ou en génère un nouveau s'il n'existe pas
     */
    public static String getToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_TOKEN_SESSION_ATTR);
        if (token == null) {
            token = generateToken(session);
        }
        return token;
    }

    /**
     * Valide le token CSRF reçu avec celui stocké dans la session
     */
    public static boolean validateToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_SESSION_ATTR);
        String requestToken = request.getParameter("csrfToken");

        if (sessionToken == null || requestToken == null) {
            return false;
        }

        // Utiliser une comparaison constant-time pour éviter les attaques de timing
        return constantTimeEquals(sessionToken, requestToken);
    }

    /**
     * Comparaison constant-time pour éviter les attaques de timing
     */
    private static boolean constantTimeEquals(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }

        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }

    /**
     * Supprime le token CSRF de la session
     */
    public static void removeToken(HttpSession session) {
        if (session != null) {
            session.removeAttribute(CSRF_TOKEN_SESSION_ATTR);
        }
    }
}

