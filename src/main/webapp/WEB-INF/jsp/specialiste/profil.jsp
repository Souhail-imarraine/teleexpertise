<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Profil - Spécialiste</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        input:focus, textarea:focus, button:focus, select:focus { outline: none !important; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Sidebar -->
<div class="fixed inset-y-0 left-0 z-40 w-64 bg-white shadow-xl border-r border-gray-200">
    <div class="flex items-center h-16 px-6 bg-black">
        <div class="flex items-center">
            <div class="bg-white p-2 rounded-lg">
                <svg class="h-5 w-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
            </div>
            <span class="ml-3 text-white font-bold text-lg">TéléMed</span>
        </div>
    </div>

    <nav class="mt-6 px-3">
        <div class="space-y-1">
            <a href="${pageContext.request.contextPath}/specialiste/dashboard"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                </svg>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/specialiste/demandes"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                Demandes d'Expertise
            </a>

            <a href="${pageContext.request.contextPath}/specialiste/creneaux"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
                Mes Créneaux
            </a>

            <a href="${pageContext.request.contextPath}/specialiste/profil"
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
                Mon Profil
            </a>
        </div>
    </nav>

    <div class="absolute bottom-0 w-full p-4 border-t border-gray-200 bg-white">
        <a href="${pageContext.request.contextPath}/logout"
           class="w-full bg-gray-900 hover:bg-black text-white font-medium py-2 px-4 rounded-lg text-sm flex items-center justify-center">
            <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Déconnexion
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="ml-64">
    <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20">
        <div class="px-8 py-4">
            <h1 class="text-2xl font-bold text-gray-900">👤 Mon Profil</h1>
            <p class="text-sm text-gray-600 mt-1">Gérez vos informations professionnelles</p>
        </div>
    </header>

    <main class="p-8">
        <!-- Messages -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="bg-green-50 border-l-4 border-green-500 p-4 mb-6 rounded-lg">
                <p class="text-sm font-medium text-green-800">${sessionScope.successMessage}</p>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-lg">
                <p class="text-sm font-medium text-red-800">${sessionScope.errorMessage}</p>
            </div>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Informations personnelles (lecture seule) -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="text-center mb-6">
                        <div class="mx-auto h-24 w-24 bg-black text-white rounded-full flex items-center justify-center text-3xl font-bold">
                            ${specialiste.nom.substring(0,1).toUpperCase()}${specialiste.prenom.substring(0,1).toUpperCase()}
                        </div>
                        <h2 class="mt-4 text-xl font-bold text-gray-900">
                            Dr. ${specialiste.nom} ${specialiste.prenom}
                        </h2>
                        <p class="text-sm text-gray-500">${specialiste.specialite.label}</p>
                    </div>

                    <div class="border-t border-gray-200 pt-6 space-y-4">
                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Email</label>
                            <p class="text-sm text-gray-900">${specialiste.email}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Spécialité</label>
                            <p class="text-sm text-gray-900">${specialiste.specialite.label}</p>
                        </div>

                        <div>
                            <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Rôle</label>
                            <span class="inline-flex px-3 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-800">
                                Médecin Spécialiste
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Formulaire de modification -->
            <div class="lg:col-span-2">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-6">Paramètres Professionnels</h3>

                    <form action="${pageContext.request.contextPath}/specialiste/profil" method="post">
                        <div class="space-y-6">
                            <!-- Tarif de consultation -->
                            <div>
                                <label for="tarif" class="block text-sm font-bold text-gray-700 mb-2">
                                    Tarif de consultation (DH)
                                </label>
                                <div class="relative">
                                    <input type="number"
                                           id="tarif"
                                           name="tarif"
                                           step="0.01"
                                           value="${specialiste.tarif}"
                                           class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-gray-900 focus:border-black"
                                           required>
                                    <span class="absolute right-4 top-3 text-gray-500 font-medium">DH</span>
                                </div>
                                <p class="mt-2 text-xs text-gray-500">
                                    Le tarif que vous facturez pour une consultation d'expertise
                                </p>
                            </div>

                            <!-- Durée moyenne de consultation -->
                            <div>
                                <label for="dureeMoyenneConsultation" class="block text-sm font-bold text-gray-700 mb-2">
                                    Durée moyenne de consultation (minutes)
                                </label>
                                <div class="relative">
                                    <input type="number"
                                           id="dureeMoyenneConsultation"
                                           name="dureeMoyenneConsultation"
                                           value="${specialiste.dureeMoyenneConsultation}"
                                           min="15"
                                           step="15"
                                           class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg text-gray-900 focus:border-black"
                                           required>
                                    <span class="absolute right-4 top-3 text-gray-500 font-medium">min</span>
                                </div>
                                <p class="mt-2 text-xs text-gray-500">
                                    Temps moyen que vous consacrez à chaque expertise (par défaut: 30 minutes)
                                </p>
                            </div>

                            <!-- Informations de référence -->
                            <div class="bg-gray-50 rounded-lg p-4 border-2 border-gray-200">
                                <h4 class="text-sm font-bold text-gray-700 mb-3">Informations actuelles</h4>
                                <div class="grid grid-cols-2 gap-4 text-sm">
                                    <div>
                                        <span class="text-gray-500">Tarif actuel:</span>
                                        <span class="ml-2 font-bold text-gray-900">${specialiste.tarif} DH</span>
                                    </div>
                                    <div>
                                        <span class="text-gray-500">Durée actuelle:</span>
                                        <span class="ml-2 font-bold text-gray-900">${specialiste.dureeMoyenneConsultation} min</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Boutons d'action -->
                            <div class="flex items-center justify-end gap-4 pt-6 border-t border-gray-200">
                                <a href="${pageContext.request.contextPath}/specialiste/dashboard"
                                   class="px-6 py-3 bg-white border-2 border-gray-300 text-gray-700 font-bold rounded-lg hover:border-black">
                                    Annuler
                                </a>
                                <button type="submit"
                                        class="px-6 py-3 bg-black text-white font-bold rounded-lg hover:bg-gray-800">
                                    💾 Enregistrer les modifications
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Statistiques du profil -->
                <div class="mt-6 bg-gradient-to-br from-gray-900 to-black rounded-xl shadow-lg p-6 text-white">
                    <h3 class="text-lg font-bold mb-4">📊 Statistiques de votre profil</h3>
                    <div class="grid grid-cols-3 gap-4">
                        <div class="text-center">
                            <div class="text-3xl font-bold">0</div>
                            <div class="text-sm text-gray-300 mt-1">Expertises réalisées</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold">${specialiste.tarif}</div>
                            <div class="text-sm text-gray-300 mt-1">Tarif (DH)</div>
                        </div>
                        <div class="text-center">
                            <div class="text-3xl font-bold">${specialiste.dureeMoyenneConsultation}</div>
                            <div class="text-sm text-gray-300 mt-1">Durée (min)</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

</body>
</html>

