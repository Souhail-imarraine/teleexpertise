<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Consultations - Télé-Expertise</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        input:focus, textarea:focus, button:focus, select:focus { outline: none !important; }
        * { transition: all 0.2s ease; }
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
            <a href="${pageContext.request.contextPath}/generaliste/dashboard"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                </svg>
                Dashboard
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
                <p class="text-xs text-gray-500">Médecin Généraliste</p>
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
                    <h1 class="text-2xl font-bold text-gray-900">Mes Consultations</h1>
                </div>
                <a href="${pageContext.request.contextPath}/generaliste/nouvelle-consultation"
                   class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nouvelle Consultation
                </a>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Messages de succès/erreur -->
        <c:if test="${not empty successMessage}">
            <div class="bg-green-50 border-2 border-green-500 rounded-lg p-4 mb-6 flex items-center">
                <svg class="h-6 w-6 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <p class="text-sm font-bold text-green-900"><c:out value="${successMessage}"/></p>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="bg-red-50 border-2 border-red-500 rounded-lg p-4 mb-6 flex items-center">
                <svg class="h-6 w-6 text-red-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <p class="text-sm font-bold text-red-900"><c:out value="${errorMessage}"/></p>
            </div>
        </c:if>

        <!-- Filters -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Rechercher</label>
                    <input type="text" placeholder="Nom du patient..."
                           class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Statut</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option value="">Tous les statuts</option>
                        <option value="EN_COURS">En cours</option>
                        <option value="EN_ATTENTE_AVIS">En attente d'avis</option>
                        <option value="TERMINEE">Terminée</option>
                    </select>
                </div>
                <div class="flex items-end">
                    <button class="w-full bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg">
                        Filtrer
                    </button>
                </div>
            </div>
        </div>


        <!-- Consultations List -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-gray-900 to-black">
                <h3 class="text-lg font-bold text-white flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Liste des Consultations (${not empty consultations ? consultations.size() : 0})
                </h3>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Date</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Patient</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Motif</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Statut</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Coût</th>
                            <th class="px-6 py-4 text-right text-xs font-bold text-gray-900 uppercase">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${empty consultations}">
                                <!-- Aucune consultation -->
                                <tr>
                                    <td colspan="6" class="px-6 py-12 text-center">
                                        <svg class="h-16 w-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        <p class="text-lg font-bold text-gray-900 mb-2">Aucune consultation</p>
                                        <p class="text-sm text-gray-500 mb-4">Vous n'avez pas encore créé de consultation</p>
                                        <a href="${pageContext.request.contextPath}/generaliste/patients"
                                           class="inline-block bg-black hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg">
                                            Commencer une consultation
                                        </a>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <!-- Afficher toutes les consultations -->
                                <c:forEach var="consultation" items="${consultations}">
                                    <tr class="hover:bg-gray-50">
                                        <!-- Date -->
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${dateMap[consultation.id]}"/>
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <c:out value="${timeMap[consultation.id]}"/>
                                            </div>
                                        </td>

                                        <!-- Patient -->
                                        <td class="px-6 py-4">
                                            <div class="flex items-center">
                                                <div class="h-10 w-10 bg-black text-white rounded-full flex items-center justify-center font-bold text-sm">
                                                    <c:out value="${patientInitialsMap[consultation.id]}"/>
                                                </div>
                                                <div class="ml-3">
                                                    <div class="text-sm font-bold text-gray-900">
                                                        <c:out value="${patientFullNameMap[consultation.id]}"/>
                                                    </div>
                                                    <div class="text-xs text-gray-500">
                                                        N° <c:out value="${patientNssMap[consultation.id]}"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Motif -->
                                        <td class="px-6 py-4">
                                            <div class="text-sm text-gray-900">
                                                <c:out value="${consultation.motif}"/>
                                            </div>
                                        </td>

                                        <!-- Statut avec couleurs dynamiques -->
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${consultation.statut == 'EN_COURS'}">
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-yellow-100 text-yellow-800">
                                                        En cours
                                                    </span>
                                                </c:when>
                                                <c:when test="${consultation.statut == 'EN_ATTENTE_AVIS_SPECIALISTE'}">
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-purple-100 text-purple-800">
                                                        En attente d'avis
                                                    </span>
                                                </c:when>
                                                <c:when test="${consultation.statut == 'TERMINEE'}">
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                                        Terminée
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-gray-100 text-gray-800">
                                                        <c:out value="${consultation.statut}"/>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Coût -->
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-bold text-gray-900">
                                                ${consultation.coutBase} DH
                                            </div>
                                            <div class="text-xs text-gray-500">
                                                <c:choose>
                                                    <c:when test="${hasDemandeExpertiseMap[consultation.id]}">
                                                        Consultation + Avis
                                                    </c:when>
                                                    <c:when test="${hasActesTechniquesMap[consultation.id]}">
                                                        Consultation + Actes
                                                    </c:when>
                                                    <c:otherwise>
                                                        Consultation simple
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>

                                        <!-- Actions -->
                                        <td class="px-6 py-4 text-right space-x-2">
                                            <c:choose>
                                                <c:when test="${consultation.statut == 'TERMINEE'}">
                                                    <a href="${pageContext.request.contextPath}/generaliste/consultation/${consultation.id}"
                                                       class="inline-block bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                                        Voir
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/generaliste/consultation/${consultation.id}"
                                                       class="inline-block bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                                        Continuer
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');

    mobileMenuBtn.addEventListener('click', () => {
        sidebar.classList.toggle('-translate-x-full');
        overlay.classList.toggle('hidden');
    });

    overlay.addEventListener('click', () => {
        sidebar.classList.add('-translate-x-full');
        overlay.classList.add('hidden');
    });
</script>
</body>
</html>
