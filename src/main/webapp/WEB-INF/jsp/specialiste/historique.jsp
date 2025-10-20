<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Historique - Spécialiste</title>
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
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                </svg>
                Mon Profil
            </a>

            <a href="${pageContext.request.contextPath}/specialiste/historique"
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                Historique
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
            <h1 class="text-2xl font-bold text-gray-900">🕒 Historique des Expertises</h1>
            <p class="text-sm text-gray-600 mt-1">Consultez vos expertises passées et vos statistiques</p>
        </div>
    </header>

    <main class="p-8">
        <!-- Statistiques globales -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-blue-100 text-sm font-semibold uppercase">Total Expertises</p>
                        <p class="text-4xl font-bold mt-2">156</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-green-100 text-sm font-semibold uppercase">Ce mois</p>
                        <p class="text-4xl font-bold mt-2">24</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-br from-purple-500 to-purple-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-purple-100 text-sm font-semibold uppercase">Revenus Total</p>
                        <p class="text-4xl font-bold mt-2">47K</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-br from-orange-500 to-orange-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-orange-100 text-sm font-semibold uppercase">Temps Moyen</p>
                        <p class="text-4xl font-bold mt-2">28m</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filtres -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Période</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option>Tous</option>
                        <option>Ce mois</option>
                        <option>Mois dernier</option>
                        <option>Cette année</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Statut</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option>Tous</option>
                        <option>Terminées</option>
                        <option>Annulées</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Priorité</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option>Toutes</option>
                        <option>Urgente</option>
                        <option>Normale</option>
                        <option>Non urgente</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-700 mb-2">Rechercher</label>
                    <input type="text" placeholder="Nom du patient..."
                           class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                </div>
            </div>
        </div>

        <!-- Timeline des expertises -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <h2 class="text-lg font-bold text-gray-900 mb-6">Historique des expertises</h2>

            <div class="space-y-6">
                <!-- Expertise 1 -->
                <div class="relative pl-8 pb-6 border-l-2 border-gray-200 last:border-transparent">
                    <div class="absolute -left-2 top-0 h-4 w-4 rounded-full bg-green-500 border-2 border-white"></div>
                    <div class="bg-gray-50 rounded-lg p-4 hover:bg-gray-100 transition-all cursor-pointer">
                        <div class="flex items-start justify-between mb-3">
                            <div>
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-sm font-bold text-gray-900">Expertise Cardiologique</h3>
                                    <span class="px-2 py-1 bg-green-100 text-green-800 text-xs font-bold rounded-full">
                                        Terminée
                                    </span>
                                    <span class="px-2 py-1 bg-yellow-100 text-yellow-800 text-xs font-bold rounded-full">
                                        Normale
                                    </span>
                                </div>
                                <p class="text-xs text-gray-600">
                                    Patient: <span class="font-semibold">Ahmed BENALI</span> •
                                    Médecin: <span class="font-semibold">Dr. Fatima BENNANI</span>
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="text-xs font-bold text-gray-900">18 Oct 2025</p>
                                <p class="text-xs text-gray-500">14:30</p>
                            </div>
                        </div>
                        <p class="text-sm text-gray-700 mb-3">
                            Avis demandé concernant un patient présentant des palpitations cardiaques...
                        </p>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-4 text-xs text-gray-600">
                                <span>⏱️ 25 minutes</span>
                                <span>💰 300 DH</span>
                            </div>
                            <button class="text-sm text-black font-bold hover:underline">
                                Voir détails →
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Expertise 2 -->
                <div class="relative pl-8 pb-6 border-l-2 border-gray-200 last:border-transparent">
                    <div class="absolute -left-2 top-0 h-4 w-4 rounded-full bg-green-500 border-2 border-white"></div>
                    <div class="bg-gray-50 rounded-lg p-4 hover:bg-gray-100 transition-all cursor-pointer">
                        <div class="flex items-start justify-between mb-3">
                            <div>
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-sm font-bold text-gray-900">Consultation Urgente</h3>
                                    <span class="px-2 py-1 bg-green-100 text-green-800 text-xs font-bold rounded-full">
                                        Terminée
                                    </span>
                                    <span class="px-2 py-1 bg-red-100 text-red-800 text-xs font-bold rounded-full">
                                        Urgente
                                    </span>
                                </div>
                                <p class="text-xs text-gray-600">
                                    Patient: <span class="font-semibold">Karim IDRISSI</span> •
                                    Médecin: <span class="font-semibold">Dr. Hassan TAZI</span>
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="text-xs font-bold text-gray-900">17 Oct 2025</p>
                                <p class="text-xs text-gray-500">10:00</p>
                            </div>
                        </div>
                        <p class="text-sm text-gray-700 mb-3">
                            Cas urgent nécessitant un avis spécialisé pour douleurs thoraciques...
                        </p>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-4 text-xs text-gray-600">
                                <span>⏱️ 15 minutes</span>
                                <span>💰 300 DH</span>
                            </div>
                            <button class="text-sm text-black font-bold hover:underline">
                                Voir détails →
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Expertise 3 -->
                <div class="relative pl-8 pb-6 border-l-2 border-gray-200 last:border-transparent">
                    <div class="absolute -left-2 top-0 h-4 w-4 rounded-full bg-green-500 border-2 border-white"></div>
                    <div class="bg-gray-50 rounded-lg p-4 hover:bg-gray-100 transition-all cursor-pointer">
                        <div class="flex items-start justify-between mb-3">
                            <div>
                                <div class="flex items-center gap-3 mb-2">
                                    <h3 class="text-sm font-bold text-gray-900">Suivi Cardiologique</h3>
                                    <span class="px-2 py-1 bg-green-100 text-green-800 text-xs font-bold rounded-full">
                                        Terminée
                                    </span>
                                    <span class="px-2 py-1 bg-blue-100 text-blue-800 text-xs font-bold rounded-full">
                                        Non Urgente
                                    </span>
                                </div>
                                <p class="text-xs text-gray-600">
                                    Patient: <span class="font-semibold">Salma OUARDI</span> •
                                    Médecin: <span class="font-semibold">Dr. Youssef ALAMI</span>
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="text-xs font-bold text-gray-900">15 Oct 2025</p>
                                <p class="text-xs text-gray-500">16:15</p>
                            </div>
                        </div>
                        <p class="text-sm text-gray-700 mb-3">
                            Suivi post-opératoire pour patiente avec antécédents cardiaques...
                        </p>
                        <div class="flex items-center justify-between">
                            <div class="flex items-center gap-4 text-xs text-gray-600">
                                <span>⏱️ 30 minutes</span>
                                <span>💰 300 DH</span>
                            </div>
                            <button class="text-sm text-black font-bold hover:underline">
                                Voir détails →
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Message si vide -->
                <div class="text-center py-12 hidden">
                    <svg class="mx-auto h-16 w-16 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <p class="mt-4 text-gray-500">Aucune expertise dans l'historique</p>
                </div>
            </div>

            <!-- Pagination -->
            <div class="flex items-center justify-between mt-8 pt-6 border-t border-gray-200">
                <p class="text-sm text-gray-600">Affichage de 1 à 10 sur 156 expertises</p>
                <div class="flex gap-2">
                    <button class="px-3 py-2 bg-gray-100 text-gray-400 rounded-lg text-sm font-medium cursor-not-allowed">
                        ← Précédent
                    </button>
                    <button class="px-3 py-2 bg-black text-white rounded-lg text-sm font-medium hover:bg-gray-800">
                        Suivant →
                    </button>
                </div>
            </div>
        </div>
    </main>
</div>

</body>
</html>

