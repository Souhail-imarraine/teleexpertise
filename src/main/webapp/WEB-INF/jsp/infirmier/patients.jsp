<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Patients du Jour - Télé-Expertise Médicale</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Remove outline on all inputs and buttons */
        input:focus, textarea:focus, button:focus, select:focus {
            outline: none !important;
        }

        /* Smooth transitions */
        * {
            transition: all 0.2s ease;
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
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
        <!-- Logo -->
        <div class="flex items-center h-16 px-6 bg-black border-b border-gray-800">
            <div class="flex items-center">
                <div class="bg-white p-2 rounded-lg">
                    <svg class="h-5 w-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <span class="ml-3 text-white font-bold text-lg">teleexpertise</span>
            </div>
        </div>

        <!-- Navigation -->
        <nav class="mt-6 px-3">
            <div class="space-y-1">
                <a href="${pageContext.request.contextPath}/infirmier/dashboard"
                   class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                    <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                    Dashboard
                </a>

                <a href="${pageContext.request.contextPath}/infirmier/accueil"
                   class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                    <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                    Accueil Patient
                </a>

                <a href="${pageContext.request.contextPath}/infirmier/patients"
                   class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                    <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    Patients du Jour
                </a>
            </div>
        </nav>

        <!-- User Info -->
        <div class="absolute bottom-0 w-full p-4 border-t border-gray-200 bg-white">
            <div class="flex items-center mb-3">
                <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-semibold text-sm">
                    <c:out value="${sessionScope.userName.substring(0,1).toUpperCase()}"/>
                </div>
                <div class="ml-3">
                    <p class="text-sm font-medium text-gray-900"><c:out value="${sessionScope.userName}"/></p>
                    <p class="text-xs text-gray-500">Infirmier(ère)</p>
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

    <!-- Overlay -->
    <div id="overlay" class="hidden lg:hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

    <!-- Main Content -->
    <div class="lg:ml-64">
        <!-- Top Bar -->
        <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20">
            <div class="px-4 sm:px-6 lg:px-8 py-4">
                <h1 class="text-xl sm:text-2xl font-bold text-gray-900">Patients du Jour</h1>
                <p class="text-sm text-gray-600 mt-1">Liste complète des patients enregistrés, triés par heure d'arrivée</p>
            </div>
        </header>

        <!-- Content -->
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

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-red-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-sm font-medium text-red-800">${errorMessage}</p>
                    </div>
                </div>
            </c:if>

            <!-- Stats Card -->
            <div class="bg-gradient-to-r from-gray-900 to-black rounded-xl shadow-lg p-6 mb-6">
                <div class="flex items-center justify-between text-white">
                    <div>
                        <h3 class="text-sm font-semibold text-gray-300 uppercase">Patients Enregistrés Aujourd'hui</h3>
                        <p class="text-4xl font-bold mt-2">${nombrePatients != null ? nombrePatients : 0}</p>
                    </div>
                    <div class="bg-white/20 p-4 rounded-lg">
                        <svg class="h-10 w-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <!-- Patients List -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-gray-900 to-black">
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between">
                        <div>
                            <h3 class="text-lg font-bold text-white">Liste des Patients Enregistrés</h3>
                            <p class="text-sm text-gray-300 mt-1">Date : <span id="current-date"></span></p>
                        </div>
                        <div class="mt-3 sm:mt-0">
                            <a href="${pageContext.request.contextPath}/infirmier/accueil"
                               class="inline-flex items-center bg-white text-black hover:bg-gray-100 font-bold py-2 px-4 rounded-lg text-sm">
                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                                </svg>
                                Ajouter Patient
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Desktop Table -->
                <div class="hidden md:block overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase tracking-wider">
                                    Patient
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase tracking-wider">
                                    <div class="flex items-center">
                                        Heure d'Arrivée
                                        <svg class="ml-1 h-4 w-4 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4h13M3 8h9m-9 4h6m4 0l4-4m0 0l4 4m-4-4v12"/>
                                        </svg>
                                    </div>
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase tracking-wider">
                                    Signes Vitaux
                                </th>
                                <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase tracking-wider">
                                    Statut
                                </th>
                                <th class="px-6 py-4 text-right text-xs font-bold text-gray-900 uppercase tracking-wider">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:choose>
                                <c:when test="${empty patients}">
                                    <!-- No patients -->
                                    <tr>
                                        <td colspan="5" class="px-6 py-12 text-center">
                                            <div class="flex flex-col items-center justify-center">
                                                <svg class="h-16 w-16 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                                </svg>
                                                <h3 class="text-lg font-bold text-gray-900 mb-2">Aucun patient enregistré aujourd'hui</h3>
                                                <p class="text-sm text-gray-600 mb-4">Commencez par ajouter un nouveau patient</p>
                                                <a href="${pageContext.request.contextPath}/infirmier/accueil"
                                                   class="bg-black hover:bg-gray-800 text-white font-bold py-3 px-6 rounded-lg">
                                                    Ajouter un Patient
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <!-- Display patients -->
                                    <c:forEach var="patient" items="${patients}">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4">
                                                <div class="flex items-center">
                                                    <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold text-base">
                                                        ${patient.nom.substring(0,1).toUpperCase()}${patient.prenom.substring(0,1).toUpperCase()
                                                        }
                                                    </div>
                                                    <div class="ml-4">
                                                        <div class="text-sm font-bold text-gray-900">
                                                            <c:out value="${patient.prenom}"/> <c:out value="${patient.nom}"/>
                                                        </div>
                                                        <div class="text-xs font-medium text-gray-500">
                                                            ${ageMap[patient.id]} • N° <c:out value="${patient.numeroSecuriteSociale}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex items-center">
                                                    <svg class="h-5 w-5 text-gray-900 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                    </svg>
                                                    <div>
                                                        <div class="text-sm font-bold text-gray-900">
                                                            <c:if test="${not empty patient.heureArrivee}">
                                                                ${patient.heureArrivee.hour}:${patient.heureArrivee.minute < 10 ? '0' : ''}${patient.heureArrivee.minute}
                                                            </c:if>
                                                        </div>
                                                        <div class="text-xs font-medium text-gray-500">
                                                            <c:out value="${patient.dateEnregistrement}"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="space-y-1 text-xs">
                                                    <c:if test="${not empty patient.tensionArterielle}">
                                                        <div class="flex items-center">
                                                            <span class="w-16 font-bold text-gray-900">TA:</span>
                                                            <span class="font-semibold text-gray-700"><c:out value="${patient.tensionArterielle}"/> mmHg</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${not empty patient.frequenceCardiaque}">
                                                        <div class="flex items-center">
                                                            <span class="w-16 font-bold text-gray-900">FC:</span>
                                                            <span class="font-semibold text-gray-700"><c:out value="${patient.frequenceCardiaque}"/> bpm</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${not empty patient.temperature}">
                                                        <div class="flex items-center">
                                                            <span class="w-16 font-bold text-gray-900">Temp:</span>
                                                            <span class="font-semibold text-gray-700"><c:out value="${patient.temperature}"/>°C</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${not empty patient.frequenceRespiratoire}">
                                                        <div class="flex items-center">
                                                            <span class="w-16 font-bold text-gray-900">FR:</span>
                                                            <span class="font-semibold text-gray-700"><c:out value="${patient.frequenceRespiratoire}"/> rpm</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${empty patient.tensionArterielle && empty patient.frequenceCardiaque && empty patient.temperature && empty patient.frequenceRespiratoire}">
                                                        <span class="text-gray-500 italic">Non renseignés</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4">
                                                <c:choose>
                                                    <c:when test="${patient.statut == 'EN_ATTENTE'}">
                                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-yellow-100 text-yellow-800 border-2 border-yellow-300">
                                                            🕐 EN_ATTENTE
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${patient.statut == 'EN_CONSULTATION'}">
                                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-blue-100 text-blue-800 border-2 border-blue-300">
                                                            👨‍⚕️ EN_CONSULTATION
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${patient.statut == 'TERMINE'}">
                                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-green-100 text-green-800 border-2 border-green-300">
                                                            ✓ TERMINÉ
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border-2 border-gray-300">
                                                            <c:out value="${patient.statut}"/>
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-6 py-4 text-right">
                                                <button onclick="viewPatientDetails(${patient.id})"
                                                        class="bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                                    Voir Détails
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Mobile Cards -->
                <div class="md:hidden divide-y divide-gray-200">
                    <c:choose>
                        <c:when test="${empty patients}">
                            <!-- No patients -->
                            <div class="p-8 text-center">
                                <svg class="h-16 w-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                </svg>
                                <h3 class="text-base font-bold text-gray-900 mb-2">Aucun patient</h3>
                                <p class="text-sm text-gray-600 mb-4">Ajoutez votre premier patient</p>
                                <a href="${pageContext.request.contextPath}/infirmier/accueil"
                                   class="inline-block bg-black hover:bg-gray-800 text-white font-bold py-2 px-6 rounded-lg text-sm">
                                    Ajouter un Patient
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Patient Cards -->
                            <c:forEach var="patient" items="${patients}">
                                <div class="p-4 hover:bg-gray-50">
                                    <div class="flex items-start justify-between mb-3">
                                        <div class="flex items-center">
                                            <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">
                                                ${patient.nom.substring(0,1).toUpperCase()}${patient.prenom.substring(0,1).toUpperCase()}
                                            </div>
                                            <div class="ml-3">
                                                <div class="text-sm font-bold text-gray-900">
                                                    <c:out value="${patient.prenom}"/> <c:out value="${patient.nom}"/>
                                                </div>
                                                <div class="text-xs font-medium text-gray-500">
                                                    N° <c:out value="${patient.numeroSecuriteSociale.substring(0,7)}"/>...
                                                </div>
                                            </div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${patient.statut == 'EN_ATTENTE'}">
                                                <span class="inline-flex items-center px-2 py-1 rounded-lg text-xs font-bold bg-yellow-100 text-yellow-800 border border-yellow-300">
                                                    EN_ATTENTE
                                                </span>
                                            </c:when>
                                            <c:when test="${patient.statut == 'EN_CONSULTATION'}">
                                                <span class="inline-flex items-center px-2 py-1 rounded-lg text-xs font-bold bg-blue-100 text-blue-800 border border-blue-300">
                                                    EN_CONSULTATION
                                                </span>
                                            </c:when>
                                            <c:when test="${patient.statut == 'TERMINE'}">
                                                <span class="inline-flex items-center px-2 py-1 rounded-lg text-xs font-bold bg-green-100 text-green-800 border border-green-300">
                                                    TERMINÉ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center px-2 py-1 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border border-gray-300">
                                                    <c:out value="${patient.statut}"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="bg-gray-50 border-l-4 border-black p-3 mb-3">
                                        <div class="flex items-center text-xs font-medium text-gray-900 mb-2">
                                            <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                            Arrivée:
                                            <c:if test="${not empty patient.heureArrivee}">
                                                ${patient.heureArrivee.hour}:${patient.heureArrivee.minute < 10 ? '0' : ''}${patient.heureArrivee.minute}
                                            </c:if>
                                        </div>

                                        <div class="grid grid-cols-2 gap-2 text-xs">
                                            <c:if test="${not empty patient.tensionArterielle}">
                                                <div>
                                                    <span class="font-bold text-gray-900">TA:</span>
                                                    <span class="text-gray-700"> <c:out value="${patient.tensionArterielle}"/></span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty patient.frequenceCardiaque}">
                                                <div>
                                                    <span class="font-bold text-gray-900">FC:</span>
                                                    <span class="text-gray-700"> <c:out value="${patient.frequenceCardiaque}"/> bpm</span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty patient.temperature}">
                                                <div>
                                                    <span class="font-bold text-gray-900">Temp:</span>
                                                    <span class="text-gray-700"> <c:out value="${patient.temperature}"/>°C</span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty patient.frequenceRespiratoire}">
                                                <div>
                                                    <span class="font-bold text-gray-900">FR:</span>
                                                    <span class="text-gray-700"> <c:out value="${patient.frequenceRespiratoire}"/> rpm</span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <button onclick="viewPatientDetails(${patient.id})"
                                            class="w-full bg-black hover:bg-gray-800 text-white font-bold py-2 px-4 rounded-lg text-sm">
                                        Voir Détails Complets
                                    </button>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Mobile menu
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

        // Display current date
        const dateElement = document.getElementById('current-date');
        if (dateElement) {
            const today = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            dateElement.textContent = today.toLocaleDateString('fr-FR', options);
        }

        // View patient details
        function viewPatientDetails(patientId) {
            // TODO: Implement patient details modal or redirect
            alert('Détails du patient #' + patientId + ' - À implémenter');
        }
    </script>
</body>
</html>
