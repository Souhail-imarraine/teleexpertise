<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - Télé-Expertise Médicale</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen flex">
    <!-- Section gauche avec image et texte -->
    <div class="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-gray-900 via-gray-800 to-black relative overflow-hidden">
        <div class="absolute inset-0 opacity-10">
            <svg class="w-full h-full" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                <defs>
                    <pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse">
                        <path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" stroke-width="0.5"/>
                    </pattern>
                </defs>
                <rect width="100" height="100" fill="url(#grid)" />
            </svg>
        </div>
        <div class="relative z-10 flex flex-col justify-center px-16 text-white">
            <svg class="w-16 h-16 mb-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
            </svg>
            <h1 class="text-4xl font-bold mb-4">Rejoignez notre plateforme médicale</h1>
            <p class="text-gray-300 text-lg leading-relaxed mb-8">
                Créez votre compte professionnel pour accéder à notre système de télé-expertise médicale sécurisé.
            </p>
            <div class="space-y-4">
                <div class="flex items-center space-x-3">
                    <svg class="w-6 h-6 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <span>Inscription rapide et sécurisée</span>
                </div>
                <div class="flex items-center space-x-3">
                    <svg class="w-6 h-6 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <span>Accès aux consultations en ligne</span>
                </div>
                <div class="flex items-center space-x-3">
                    <svg class="w-6 h-6 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <span>Protection des données personnelles</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Section droite avec formulaire -->
    <div class="w-full lg:w-1/2 flex items-center justify-center px-6 py-12">
        <div class="w-full max-w-md">
            <!-- Logo et titre -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-black rounded-2xl mb-4">
                    <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                </div>
                <h2 class="text-3xl font-bold text-gray-900">Créer un compte</h2>
                <p class="text-gray-600 mt-2">Inscrivez-vous pour commencer</p>
            </div>

            <!-- Formulaire -->
            <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-5">
                <!-- Prénom et Nom -->
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label for="firstName" class="block text-sm font-semibold text-gray-700 mb-2">
                            Prénom
                        </label>
                        <div class="relative">
                            <input type="text" id="firstName" name="firstName" required
                                   class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg transition"
                                   placeholder="Prénom"/>
                        </div>
                    </div>
                    <div>
                        <label for="lastName" class="block text-sm font-semibold text-gray-700 mb-2">
                            Nom
                        </label>
                        <div class="relative">
                            <input type="text" id="lastName" name="lastName" required
                                   class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg transition"
                                   placeholder="Nom"/>
                        </div>
                    </div>
                </div>

                <!-- Email -->
                <div>
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-2">
                        Adresse email
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <input type="email" id="email" name="email" required
                               class="w-full pl-10 pr-4 py-3 border-2 border-gray-200 rounded-lg transition"
                               placeholder="exemple@domaine.com"/>
                    </div>
                </div>

                <!-- Mot de passe -->
                <div>
                    <label for="password" class="block text-sm font-semibold text-gray-700 mb-2">
                        Mot de passe
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                            </svg>
                        </div>
                        <input type="password" id="password" name="password" required
                               class="w-full pl-10 pr-4 py-3 border-2 border-gray-200 rounded-lg transition"
                               placeholder="Minimum 8 caractères"/>
                    </div>
                </div>

                <!-- Confirmation mot de passe -->
                <div>
                    <label for="confirmPassword" class="block text-sm font-semibold text-gray-700 mb-2">
                        Confirmer le mot de passe
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                            </svg>
                        </div>
                        <input type="password" id="confirmPassword" name="confirmPassword" required
                               class="w-full pl-10 pr-4 py-3 border-2 border-gray-200 rounded-lg transition"
                               placeholder="Confirmez votre mot de passe"/>
                    </div>
                </div>

                <!-- Rôle -->
                <div>
                    <label for="role" class="block text-sm font-semibold text-gray-700 mb-2">
                        Rôle professionnel
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <select id="role" name="role" required
                                class="w-full pl-10 pr-4 py-3 border-2 border-gray-200 rounded-lg transition appearance-none bg-white">
                            <option value="">Sélectionnez votre rôle</option>
                            <option value="MEDECIN">Médecin</option>
                            <option value="PATIENT">Patient</option>
                            <option value="RADIOLOGUE">Radiologue</option>
                            <option value="INFIRMIER">Infirmier(ère)</option>
                        </select>
                    </div>
                </div>

                <!-- Conditions d'utilisation -->
                <div class="flex items-start">
                    <input type="checkbox" id="terms" name="terms" required
                           class="w-4 h-4 mt-1 border-gray-300 rounded text-black focus:ring-black"/>
                    <label for="terms" class="ml-2 text-sm text-gray-600">
                        J'accepte les <a href="#" class="font-semibold text-black hover:underline">conditions d'utilisation</a>
                        et la <a href="#" class="font-semibold text-black hover:underline">politique de confidentialité</a>
                    </label>
                </div>

                <!-- Bouton d'inscription -->
                <button type="submit"
                        class="w-full py-3 px-4 bg-black text-white font-semibold rounded-lg hover:bg-gray-800 focus:ring-4 focus:ring-gray-300 transition duration-200 flex items-center justify-center space-x-2">
                    <span>Créer mon compte</span>
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"/>
                    </svg>
                </button>
            </form>

            <!-- Lien vers connexion -->
            <div class="mt-6 text-center">
                <p class="text-sm text-gray-600">
                    Vous avez déjà un compte ?
                    <a href="${pageContext.request.contextPath}/login" class="font-semibold text-black hover:underline">Se connecter</a>
                </p>
            </div>

            <!-- Sécurité -->
            <div class="mt-6 flex items-center justify-center space-x-2 text-xs text-gray-500">
                <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd"/>
                </svg>
                <span>Vos données sont protégées et cryptées</span>
            </div>
        </div>
    </div>
</body>
</html>