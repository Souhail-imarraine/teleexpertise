<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Créneaux - Spécialiste</title>
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
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
            <h1 class="text-2xl font-bold text-gray-900">📅 Mes Créneaux Horaires</h1>
            <p class="text-sm text-gray-600 mt-1">Gérez votre planning et vos disponibilités</p>
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

        <!-- Statistiques des créneaux -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 font-semibold">Disponibles</p>
                        <p class="text-3xl font-bold text-green-600 mt-2">${statsDisponibles != null ? statsDisponibles : 0}</p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-lg">
                        <svg class="h-8 w-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 font-semibold">Réservés</p>
                        <p class="text-3xl font-bold text-yellow-600 mt-2">${statsReserves != null ? statsReserves : 0}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-lg">
                        <svg class="h-8 w-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 font-semibold">Bloqués</p>
                        <p class="text-3xl font-bold text-red-600 mt-2">${statsBloques != null ? statsBloques : 0}</p>
                    </div>
                    <div class="bg-red-100 p-3 rounded-lg">
                        <svg class="h-8 w-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm text-gray-500 font-semibold">Passés</p>
                        <p class="text-3xl font-bold text-gray-400 mt-2">${statsPasses != null ? statsPasses : 0}</p>
                    </div>
                    <div class="bg-gray-100 p-3 rounded-lg">
                        <svg class="h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Calendrier hebdomadaire -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-lg font-bold text-gray-900">
                    Planning de la semaine du
                    <fmt:formatDate value="${dateDebut}" pattern="dd/MM/yyyy" var="dateDebutStr"/>
                    ${dateDebutStr}
                </h2>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/specialiste/creneaux?semaine=${semainePrecedente}"
                       class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-medium text-sm hover:bg-gray-200">
                        ← Semaine précédente
                    </a>
                    <a href="${pageContext.request.contextPath}/specialiste/creneaux?semaine=${semaineActuelle}"
                       class="px-4 py-2 bg-black text-white rounded-lg font-medium text-sm hover:bg-gray-800">
                        Aujourd'hui
                    </a>
                    <a href="${pageContext.request.contextPath}/specialiste/creneaux?semaine=${semaineSuivante}"
                       class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg font-medium text-sm hover:bg-gray-200">
                        Semaine suivante →
                    </a>
                </div>
            </div>

            <!-- Grille de créneaux -->
            <div class="overflow-x-auto">
                <table class="min-w-full">
                    <thead>
                        <tr class="border-b-2 border-gray-200">
                            <th class="px-4 py-3 text-left text-sm font-bold text-gray-700">Horaire</th>
                            <c:forEach var="i" begin="0" end="4">
                                <c:set var="jour" value="${dateDebut.plusDays(i)}"/>
                                <th class="px-4 py-3 text-center text-sm font-bold text-gray-700">
                                    <jsp:useBean id="jour" type="java.time.LocalDate"/>
                                    <c:choose>
                                        <c:when test="${jour.dayOfWeek.value == 1}">Lundi</c:when>
                                        <c:when test="${jour.dayOfWeek.value == 2}">Mardi</c:when>
                                        <c:when test="${jour.dayOfWeek.value == 3}">Mercredi</c:when>
                                        <c:when test="${jour.dayOfWeek.value == 4}">Jeudi</c:when>
                                        <c:when test="${jour.dayOfWeek.value == 5}">Vendredi</c:when>
                                    </c:choose>
                                    ${jour.dayOfMonth}/${jour.monthValue}
                                </th>
                            </c:forEach>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <!-- Horaires du matin -->
                        <c:forEach var="heure" items="09:00,09:30,10:00,10:30,11:00,11:30">
                            <tr class="${heure.startsWith('09:30') || heure.startsWith('10:30') || heure.startsWith('11:30') ? 'bg-gray-50' : ''}">
                                <td class="px-4 py-3 text-sm font-medium text-gray-900">${heure} - ${heure.substring(0,2)}:${Integer.parseInt(heure.substring(3)) + 30 < 60 ? heure.substring(3,5).equals("00") ? "30" : "00" : "00"}</td>

                                <c:forEach var="i" begin="0" end="4">
                                    <c:set var="jourActuel" value="${dateDebut.plusDays(i)}"/>
                                    <c:set var="jourStr" value="${jourActuel.toString()}"/>
                                    <c:set var="creneauxJour" value="${creneauxParJour[jourStr]}"/>

                                    <td class="px-4 py-3">
                                        <c:set var="creneauTrouve" value="false"/>
                                        <c:forEach var="creneau" items="${creneauxJour}">
                                            <c:if test="${creneau.dateDebut.hour == Integer.parseInt(heure.substring(0,2)) && creneau.dateDebut.minute == Integer.parseInt(heure.substring(3,5))}">
                                                <c:set var="creneauTrouve" value="true"/>
                                                <div class="flex justify-center">
                                                    <c:choose>
                                                        <c:when test="${creneau.statut == 'DISPONIBLE'}">
                                                            <span class="px-3 py-2 bg-green-100 text-green-800 text-xs font-bold rounded-lg cursor-pointer hover:bg-green-200">
                                                                ✓ Disponible
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'RESERVE'}">
                                                            <span class="px-3 py-2 bg-yellow-100 text-yellow-800 text-xs font-bold rounded-lg">
                                                                🔒 Réservé
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'BLOQUE'}">
                                                            <span class="px-3 py-2 bg-red-100 text-red-800 text-xs font-bold rounded-lg">
                                                                ✕ Bloqué
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'PASSE'}">
                                                            <span class="px-3 py-2 bg-gray-100 text-gray-500 text-xs font-bold rounded-lg">
                                                                ⏱ Passé
                                                            </span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!creneauTrouve}">
                                            <div class="flex justify-center">
                                                <span class="px-3 py-2 bg-gray-50 text-gray-400 text-xs font-bold rounded-lg">-</span>
                                            </div>
                                        </c:if>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>

                        <!-- Pause déjeuner -->
                        <tr>
                            <td colspan="6" class="px-4 py-2 text-center bg-gray-100 text-gray-500 text-sm font-medium">
                                🍽️ Pause Déjeuner (12:00 - 14:00)
                            </td>
                        </tr>

                        <!-- Horaires de l'après-midi -->
                        <c:forEach var="heure" items="14:00,14:30,15:00,15:30,16:00,16:30">
                            <tr class="${heure.startsWith('14:30') || heure.startsWith('15:30') || heure.startsWith('16:30') ? 'bg-gray-50' : ''}">
                                <td class="px-4 py-3 text-sm font-medium text-gray-900">${heure} - ${heure.substring(0,2)}:${Integer.parseInt(heure.substring(3)) + 30 < 60 ? heure.substring(3,5).equals("00") ? "30" : "00" : "00"}</td>

                                <c:forEach var="i" begin="0" end="4">
                                    <c:set var="jourActuel" value="${dateDebut.plusDays(i)}"/>
                                    <c:set var="jourStr" value="${jourActuel.toString()}"/>
                                    <c:set var="creneauxJour" value="${creneauxParJour[jourStr]}"/>

                                    <td class="px-4 py-3">
                                        <c:set var="creneauTrouve" value="false"/>
                                        <c:forEach var="creneau" items="${creneauxJour}">
                                            <c:if test="${creneau.dateDebut.hour == Integer.parseInt(heure.substring(0,2)) && creneau.dateDebut.minute == Integer.parseInt(heure.substring(3,5))}">
                                                <c:set var="creneauTrouve" value="true"/>
                                                <div class="flex justify-center">
                                                    <c:choose>
                                                        <c:when test="${creneau.statut == 'DISPONIBLE'}">
                                                            <span class="px-3 py-2 bg-green-100 text-green-800 text-xs font-bold rounded-lg cursor-pointer hover:bg-green-200">
                                                                ✓ Disponible
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'RESERVE'}">
                                                            <span class="px-3 py-2 bg-yellow-100 text-yellow-800 text-xs font-bold rounded-lg">
                                                                🔒 Réservé
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'BLOQUE'}">
                                                            <span class="px-3 py-2 bg-red-100 text-red-800 text-xs font-bold rounded-lg">
                                                                ✕ Bloqué
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${creneau.statut == 'PASSE'}">
                                                            <span class="px-3 py-2 bg-gray-100 text-gray-500 text-xs font-bold rounded-lg">
                                                                ⏱ Passé
                                                            </span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${!creneauTrouve}">
                                            <div class="flex justify-center">
                                                <span class="px-3 py-2 bg-gray-50 text-gray-400 text-xs font-bold rounded-lg">-</span>
                                            </div>
                                        </c:if>
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Légende -->
            <div class="mt-6 flex items-center justify-center gap-6 pt-6 border-t border-gray-200">
                <div class="flex items-center gap-2">
                    <span class="w-4 h-4 bg-green-100 border-2 border-green-500 rounded"></span>
                    <span class="text-sm text-gray-700">Disponible</span>
                </div>
                <div class="flex items-center gap-2">
                    <span class="w-4 h-4 bg-yellow-100 border-2 border-yellow-500 rounded"></span>
                    <span class="text-sm text-gray-700">Réservé</span>
                </div>
                <div class="flex items-center gap-2">
                    <span class="w-4 h-4 bg-red-100 border-2 border-red-500 rounded"></span>
                    <span class="text-sm text-gray-700">Bloqué</span>
                </div>
                <div class="flex items-center gap-2">
                    <span class="w-4 h-4 bg-gray-100 border-2 border-gray-400 rounded"></span>
                    <span class="text-sm text-gray-700">Passé</span>
                </div>
            </div>
        </div>
    </main>
</div>

</body>
</html>

