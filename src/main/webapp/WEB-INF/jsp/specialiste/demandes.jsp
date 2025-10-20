<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Demandes d'Expertise - Spécialiste</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        input:focus, textarea:focus, button:focus, select:focus { outline: none !important; }
        * { transition: all 0.2s ease; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Sidebar (même structure que dashboard) -->
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
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
            <h1 class="text-2xl font-bold text-gray-900">📋 Demandes d'Expertise</h1>
            <p class="text-sm text-gray-600 mt-1">Gérez vos demandes d'avis médical</p>
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

        <!-- Filtres -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div class="flex items-center justify-between">
                <div class="flex gap-4">
                    <button class="px-4 py-2 bg-black text-white rounded-lg font-medium text-sm">
                        Toutes
                    </button>
                    <button class="px-4 py-2 bg-white border-2 border-gray-300 text-gray-700 rounded-lg font-medium text-sm hover:border-black">
                        En Attente
                    </button>
                    <button class="px-4 py-2 bg-white border-2 border-gray-300 text-gray-700 rounded-lg font-medium text-sm hover:border-black">
                        Urgentes
                    </button>
                    <button class="px-4 py-2 bg-white border-2 border-gray-300 text-gray-700 rounded-lg font-medium text-sm hover:border-black">
                        Terminées
                    </button>
                </div>

                <div class="flex gap-3">
                    <input type="text" placeholder="Rechercher..."
                           class="px-4 py-2 border-2 border-gray-300 rounded-lg text-sm">
                    <button class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-medium text-sm hover:bg-gray-200">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <!-- Liste des demandes -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Priorité</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Patient</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Médecin</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Question</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Date</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Statut</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-700 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:choose>
                            <c:when test="${empty demandes}">
                                <tr>
                                    <td colspan="7" class="px-6 py-12 text-center">
                                        <svg class="mx-auto h-12 w-12 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        <p class="mt-2 text-sm text-gray-500">Aucune demande d'expertise</p>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="demande" items="${demandes}">
                                    <tr class="hover:bg-gray-50">
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${demande.priorite == 'URGENTE'}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-red-100 text-red-800">
                                                        🚨 URGENT
                                                    </span>
                                                </c:when>
                                                <c:when test="${demande.priorite == 'NORMALE'}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-yellow-100 text-yellow-800">
                                                        ⚠️ Normal
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-green-100 text-green-800">
                                                        ✓ Faible
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-bold text-gray-900">
                                                ${demande.consultation.patient.nom} ${demande.consultation.patient.prenom}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm text-gray-900">
                                                Dr. ${demande.generaliste.nom}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm text-gray-600 max-w-xs truncate">
                                                ${demande.questionPosee}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-500">
                                            ${demande.dateCreation}
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${demande.statut == 'EN_ATTENTE'}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-yellow-100 text-yellow-800">
                                                        En attente
                                                    </span>
                                                </c:when>
                                                <c:when test="${demande.statut == 'TERMINEE'}">
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-green-100 text-green-800">
                                                        Terminée
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex px-2 py-1 text-xs font-bold rounded-full bg-blue-100 text-blue-800">
                                                        ${demande.statut}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <a href="${pageContext.request.contextPath}/specialiste/demandes/detail?id=${demande.id}"
                                               class="inline-flex items-center px-3 py-2 bg-black text-white text-sm font-medium rounded-lg hover:bg-gray-800">
                                                Voir détails
                                            </a>
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

</body>
</html>

