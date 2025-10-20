<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Spécialiste - Télé-Expertise</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        input:focus, textarea:focus, button:focus, select:focus { outline: none !important; }
        * { transition: all 0.2s ease; }
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        ::-webkit-scrollbar-thumb { background: #888; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #555; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Mobile Menu Button -->
<div class="lg:hidden fixed top-4 left-4 z-50">
    <button id="mobile-menu-btn" class="bg-white p-2 rounded-lg shadow-lg hover:bg-gray-100">
        <svg class="h-6 w-6 text-gray-800" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
        </svg>
    </button>
</div>

<!-- Sidebar -->
<div id="sidebar" class="fixed inset-y-0 left-0 z-40 w-64 bg-white shadow-xl transform -translate-x-full lg:translate-x-0 transition-transform duration-300 border-r border-gray-200">
    <div class="flex items-center h-16 px-6 bg-black border-b border-gray-800">
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
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
        </div>
    </nav>

    <div class="absolute bottom-0 w-full p-4 border-t border-gray-200 bg-white">
        <div class="flex items-center mb-3">
            <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-semibold text-sm">
                <c:out value="${sessionScope.userName.substring(0,1).toUpperCase()}"/>
            </div>
            <div class="ml-3">
                <p class="text-sm font-medium text-gray-900">Dr. <c:out value="${sessionScope.userName}"/></p>
                <p class="text-xs text-gray-500">Médecin Spécialiste</p>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/logout"
           class="w-full bg-gray-900 hover:bg-black text-white font-medium py-2 px-4 rounded-lg text-sm flex items-center justify-center">
            <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Déconnexion
        </a>
    </div>
</div>

<div id="overlay" class="hidden lg:hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

<!-- Main Content -->
<div class="lg:ml-64">
    <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20">
        <div class="px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-xl sm:text-2xl font-bold text-gray-900">🩺 Dashboard Spécialiste</h1>
                    <p class="text-sm text-gray-600 mt-1">Gérez vos demandes d'expertise et votre planning</p>
                </div>
                <div class="text-right">
                    <p class="text-sm font-semibold text-gray-900" id="current-date"></p>
                    <p class="text-xs text-gray-500" id="current-time"></p>
                </div>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Success Message -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="bg-green-50 border-l-4 border-green-500 p-4 mb-6 rounded-lg">
                <div class="flex items-center">
                    <svg class="h-5 w-5 text-green-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <p class="text-sm font-medium text-green-800">${sessionScope.successMessage}</p>
                </div>
            </div>
            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <!-- Statistics Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <!-- Demandes en Attente -->
            <div class="bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-yellow-100 text-sm font-semibold uppercase">En Attente</p>
                        <p class="text-4xl font-bold mt-2">${statistiques.demandesEnAttente != null ? statistiques.demandesEnAttente : 0}</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <!-- Demandes Urgentes -->
            <div class="bg-gradient-to-br from-red-500 to-red-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-red-100 text-sm font-semibold uppercase">Urgentes</p>
                        <p class="text-4xl font-bold mt-2">${statistiques.demandesUrgentes != null ? statistiques.demandesUrgentes : 0}</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <!-- Demandes Traitées -->
            <div class="bg-gradient-to-br from-green-500 to-green-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-green-100 text-sm font-semibold uppercase">Traitées</p>
                        <p class="text-4xl font-bold mt-2">${statistiques.demandesTerminees != null ? statistiques.demandesTerminees : 0}</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-8">
            <h2 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                </svg>
                Actions Rapides
            </h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <a href="${pageContext.request.contextPath}/specialiste/demandes"
                   class="flex flex-col items-center justify-center p-6 bg-gradient-to-br from-black to-gray-800 hover:from-gray-800 hover:to-black text-white rounded-xl shadow-lg transform hover:scale-105 transition-all">
                    <svg class="h-12 w-12 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    <span class="font-bold text-center text-sm">Voir Demandes</span>
                </a>

                <a href="${pageContext.request.contextPath}/specialiste/creneaux"
                   class="flex flex-col items-center justify-center p-6 bg-white hover:bg-gray-50 border-2 border-gray-300 hover:border-black rounded-xl shadow transform hover:scale-105 transition-all">
                    <svg class="h-12 w-12 mb-3 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                    <span class="font-bold text-center text-sm text-gray-900">Gérer Créneaux</span>
                </a>

                <a href="${pageContext.request.contextPath}/specialiste/profil"
                   class="flex flex-col items-center justify-center p-6 bg-white hover:bg-gray-50 border-2 border-gray-300 hover:border-black rounded-xl shadow transform hover:scale-105 transition-all">
                    <svg class="h-12 w-12 mb-3 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    <span class="font-bold text-center text-sm text-gray-900">Configurer Profil</span>
                </a>

                <a href="${pageContext.request.contextPath}/specialiste/historique"
                   class="flex flex-col items-center justify-center p-6 bg-white hover:bg-gray-50 border-2 border-gray-300 hover:border-black rounded-xl shadow transform hover:scale-105 transition-all">
                    <svg class="h-12 w-12 mb-3 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <span class="font-bold text-center text-sm text-gray-900">Historique</span>
                </a>
            </div>
        </div>

        <!-- Activité Récente -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- Demandes Urgentes -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-lg font-bold text-gray-900 flex items-center">
                        <svg class="h-6 w-6 mr-2 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                        </svg>
                        Demandes Urgentes
                    </h2>
                    <span class="bg-red-100 text-red-800 text-xs font-bold px-3 py-1 rounded-full">
                        ${statistiques.demandesUrgentes != null ? statistiques.demandesUrgentes : 0}
                    </span>
                </div>

                <c:choose>
                    <c:when test="${statistiques.demandesUrgentes == 0}">
                        <div class="text-center py-8">
                            <svg class="mx-auto h-12 w-12 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <p class="mt-2 text-sm text-gray-500">Aucune demande urgente</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="space-y-3">
                            <div class="bg-red-50 border border-red-200 rounded-lg p-4">
                                <div class="flex items-start justify-between">
                                    <div class="flex-1">
                                        <div class="flex items-center mb-2">
                                            <span class="bg-red-600 text-white text-xs font-bold px-2 py-1 rounded">URGENT</span>
                                            <span class="ml-2 text-xs text-gray-500">Il y a 2h</span>
                                        </div>
                                        <p class="text-sm font-medium text-gray-900">Consultation cardiologique</p>
                                        <p class="text-xs text-gray-600 mt-1">Patient: Mohamed ALAMI</p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/specialiste/demandes"
                                       class="text-red-600 hover:text-red-800 font-medium text-sm">
                                        Voir →
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 text-center">
                            <a href="${pageContext.request.contextPath}/specialiste/demandes?priorite=urgente"
                               class="text-sm text-red-600 hover:text-red-800 font-medium">
                                Voir toutes les demandes urgentes →
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Prochains Créneaux -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-lg font-bold text-gray-900 flex items-center">
                        <svg class="h-6 w-6 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        Prochains Créneaux
                    </h2>
                </div>

                <div class="space-y-3">
                    <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="bg-blue-500 text-white rounded-lg p-2 text-center">
                                <div class="text-xs font-bold">AUJ</div>
                                <div class="text-lg font-bold">${pageContext.request.getAttribute('currentDay') != null ? pageContext.request.getAttribute('currentDay') : '19'}</div>
                            </div>
                            <div class="ml-3">
                                <p class="text-sm font-bold text-gray-900">09:00 - 09:30</p>
                                <p class="text-xs text-gray-500">Disponible</p>
                            </div>
                        </div>
                        <span class="bg-green-100 text-green-800 text-xs font-bold px-2 py-1 rounded">Libre</span>
                    </div>

                    <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="bg-gray-500 text-white rounded-lg p-2 text-center">
                                <div class="text-xs font-bold">AUJ</div>
                                <div class="text-lg font-bold">${pageContext.request.getAttribute('currentDay') != null ? pageContext.request.getAttribute('currentDay') : '19'}</div>
                            </div>
                            <div class="ml-3">
                                <p class="text-sm font-bold text-gray-900">10:00 - 10:30</p>
                                <p class="text-xs text-gray-500">Réservé</p>
                            </div>
                        </div>
                        <span class="bg-yellow-100 text-yellow-800 text-xs font-bold px-2 py-1 rounded">Occupé</span>
                    </div>

                    <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="bg-blue-500 text-white rounded-lg p-2 text-center">
                                <div class="text-xs font-bold">DEM</div>
                                <div class="text-lg font-bold">20</div>
                            </div>
                            <div class="ml-3">
                                <p class="text-sm font-bold text-gray-900">14:00 - 14:30</p>
                                <p class="text-xs text-gray-500">Disponible</p>
                            </div>
                        </div>
                        <span class="bg-green-100 text-green-800 text-xs font-bold px-2 py-1 rounded">Libre</span>
                    </div>
                </div>

                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/specialiste/creneaux"
                       class="text-sm text-blue-600 hover:text-blue-800 font-medium">
                        Gérer tous mes créneaux →
                    </a>
                </div>
            </div>
        </div>

        <!-- Informations du Profil -->
        <div class="mt-8 bg-gradient-to-br from-gray-900 to-black rounded-xl shadow-lg p-6 text-white">
            <div class="flex items-center justify-between">
                <div>
                    <h3 class="text-lg font-bold mb-2">Informations de votre profil</h3>
                    <div class="space-y-2">
                        <p class="text-sm text-gray-300">
                            <span class="font-semibold">Spécialité:</span>
                            <c:out value="${sessionScope.specialite != null ? sessionScope.specialite : 'Non définie'}"/>
                        </p>
                        <c:if test="${specialiste != null}">
                            <p class="text-sm text-gray-300">
                                <span class="font-semibold">Tarif:</span>
                                ${specialiste.tarif} DH
                            </p>
                            <p class="text-sm text-gray-300">
                                <span class="font-semibold">Durée consultation:</span>
                                ${specialiste.dureeMoyenneConsultation} minutes
                            </p>
                        </c:if>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/specialiste/profil"
                   class="bg-white text-black hover:bg-gray-100 font-bold py-3 px-6 rounded-lg transition-all">
                    Modifier le profil
                </a>
            </div>
        </div>
    </main>
</div>

<script>
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', () => {
            sidebar.classList.toggle('-translate-x-full');
            overlay.classList.toggle('hidden');
        });
    }

    if (overlay) {
        overlay.addEventListener('click', () => {
            sidebar.classList.add('-translate-x-full');
            overlay.classList.add('hidden');
        });
    }

    function updateDateTime() {
        const now = new Date();
        const dateOptions = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const timeOptions = { hour: '2-digit', minute: '2-digit', second: '2-digit' };
        document.getElementById('current-date').textContent = now.toLocaleDateString('fr-FR', dateOptions);
        document.getElementById('current-time').textContent = now.toLocaleTimeString('fr-FR', timeOptions);
    }

    updateDateTime();
    setInterval(updateDateTime, 1000);
</script>
</body>
</html>

