<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil Patient - Télé-Expertise Médicale</title>
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
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                </svg>
                Accueil Patient
            </a>

            <a href="${pageContext.request.contextPath}/infirmier/patients"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
            <h1 class="text-xl sm:text-2xl font-bold text-gray-900">Accueillir un Patient</h1>
        </div>
    </header>

    <!-- Content -->
    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Tabs -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 mb-6">
            <div class="border-b border-gray-200">
                <nav class="flex -mb-px">
                    <button onclick="showTab('search')" id="tab-search"
                            class="flex-1 py-4 px-4 text-center border-b-2 border-black text-black font-semibold text-sm sm:text-base">
                        <div class="flex items-center justify-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                            </svg>
                            <span class="hidden sm:inline"></span>Patient Existant
                        </div>
                    </button>
                    <button onclick="showTab('create')" id="tab-create"
                            class="flex-1 py-4 px-4 text-center border-b-2 border-transparent text-gray-500 hover:text-gray-900 hover:border-gray-300 font-semibold text-sm sm:text-base">
                        <div class="flex items-center justify-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                            </svg>
                            <span class="hidden sm:inline"></span>Nouveau Patient
                        </div>
                    </button>
                </nav>
            </div>
        </div>

        <!-- Scénario A : Rechercher Patient Existant -->
        <div id="search-tab" class="tab-content">
            <div class="bg-gradient-to-r from-gray-900 to-black rounded-xl shadow-lg p-6 mb-6">
                <div class="flex items-center mb-2">
                    <div class="bg-white p-2 rounded-lg">
                        <svg class="h-6 w-6 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                    </div>
                    <h2 class="text-white text-xl font-bold ml-3">Rechercher un Patient Existant</h2>
                </div>
                <p class="text-gray-300 text-sm">Recherchez par numéro de sécurité sociale ou nom, puis ajoutez les nouveaux signes vitaux</p>
            </div>

            <!-- Messages -->
            <c:if test="${not empty infoMessage}">
                <div class="bg-blue-50 border-l-4 border-blue-500 p-4 mb-6 rounded-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-blue-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-sm font-medium text-blue-800">${infoMessage}</p>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty searchErrorMessage}">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-lg">
                    <div class="flex items-center">
                        <svg class="h-5 w-5 text-red-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-sm font-medium text-red-800">${searchErrorMessage}</p>
                    </div>
                </div>
            </c:if>

            <!-- Search Form -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                    <span class="bg-black text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm font-bold">1</span>
                    Rechercher le Patient
                </h3>
                <form action="${pageContext.request.contextPath}/infirmier/rechercher-patient" method="post" class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Numéro de Sécurité Sociale</label>
                            <input type="text" name="numeroSecuriteSociale" placeholder="Exemple : 1234567890123"
                                   value="${param.numeroSecuriteSociale}"
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Ou Rechercher par Nom</label>
                            <input type="text" name="searchTerm" placeholder="Nom ou prénom du patient"
                                   value="${param.searchTerm}"
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                    </div>
                    <button type="submit"
                            class="bg-black hover:bg-gray-800 text-white font-bold py-3 px-8 rounded-lg flex items-center justify-center shadow-lg">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                        </svg>
                        Rechercher le Patient
                    </button>
                </form>
            </div>

            <!-- Multiple Patients Result (Show when multiple patients found) -->
            <c:if test="${not empty patientsRecherche && multiplePatients}">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                        <svg class="h-6 w-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                        Sélectionnez le Patient
                    </h3>
                    <div class="grid grid-cols-1 gap-4">
                        <c:forEach var="p" items="${patientsRecherche}">
                            <a href="${pageContext.request.contextPath}/infirmier/rechercher-patient?patientId=${p.id}"
                               class="block bg-gray-50 hover:bg-gray-100 border-2 border-gray-300 hover:border-black rounded-lg p-4 transition-all">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold text-base">
                                            ${p.nom.substring(0,1).toUpperCase()}${p.prenom.substring(0,1).toUpperCase()}
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-base font-bold text-gray-900">
                                                <c:out value="${p.prenom}"/> <c:out value="${p.nom}"/>
                                            </div>
                                            <div class="text-sm text-gray-600 mt-1">
                                                <span class="font-semibold">N° SS:</span> <c:out value="${p.numeroSecuriteSociale}"/>
                                            </div>
                                            <c:if test="${not empty p.dateNaissance}">
                                                <div class="text-xs text-gray-500 mt-1">
                                                    <span class="font-semibold">Né(e) le:</span> <c:out value="${p.dateNaissance}"/>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                    <svg class="h-6 w-6 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Patient Info (Show when patient found) -->
            <c:if test="${not empty patient && patientExistant}">
                <div id="patient-info" class="space-y-6">
                    <!-- Patient Info Display -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                        <div class="flex items-center mb-6 pb-4 border-b border-gray-200">
                            <div class="bg-black text-white p-3 rounded-lg">
                                <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                            </div>
                            <div class="ml-4">
                                <h3 class="text-lg font-bold text-gray-900">✅ Patient Trouvé</h3>
                                <p class="text-sm text-gray-600">Informations du dossier médical</p>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                            <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                <p class="text-xs font-semibold text-gray-500 mb-1 uppercase">Nom Complet</p>
                                <p class="text-base font-bold text-gray-900">
                                    <c:out value="${patient.prenom}"/> <c:out value="${patient.nom}"/>
                                </p>
                            </div>
                            <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                <p class="text-xs font-semibold text-gray-500 mb-1 uppercase">Date de Naissance</p>
                                <p class="text-base font-bold text-gray-900">
                                    <c:choose>
                                        <c:when test="${not empty patient.dateNaissance}">
                                            <c:out value="${patient.dateNaissance}"/>
                                        </c:when>
                                        <c:otherwise>Non renseignée</c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                <p class="text-xs font-semibold text-gray-500 mb-1 uppercase">N° Sécurité Sociale</p>
                                <p class="text-base font-bold text-gray-900"><c:out value="${patient.numeroSecuriteSociale}"/></p>
                            </div>
                        </div>

                        <c:if test="${not empty patient.telephone || not empty patient.adresse}">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
                                <c:if test="${not empty patient.telephone}">
                                    <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                        <p class="text-xs font-semibold text-gray-500 mb-1 uppercase">Téléphone</p>
                                        <p class="text-base font-bold text-gray-900"><c:out value="${patient.telephone}"/></p>
                                    </div>
                                </c:if>
                                <c:if test="${not empty patient.adresse}">
                                    <div class="bg-gray-50 p-4 rounded-lg border border-gray-200">
                                        <p class="text-xs font-semibold text-gray-500 mb-1 uppercase">Adresse</p>
                                        <p class="text-base font-bold text-gray-900"><c:out value="${patient.adresse}"/></p>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>

                        <div class="space-y-3">
                            <c:if test="${not empty patient.antecedents}">
                                <div class="bg-gray-50 border-l-4 border-gray-900 p-4 rounded">
                                    <h4 class="text-sm font-bold text-gray-900 mb-2 flex items-center">
                                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                                        </svg>
                                        Antécédents Médicaux
                                    </h4>
                                    <p class="text-sm text-gray-700 font-medium"><c:out value="${patient.antecedents}"/></p>
                                </div>
                            </c:if>

                            <c:if test="${not empty patient.allergies}">
                                <div class="bg-red-50 border-l-4 border-red-500 p-4 rounded">
                                    <h4 class="text-sm font-bold text-gray-900 mb-2 flex items-center">
                                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                        </svg>
                                        ⚠️ Allergies Connues
                                    </h4>
                                    <p class="text-sm text-red-800 font-bold"><c:out value="${patient.allergies}"/></p>
                                </div>
                            </c:if>

                            <c:if test="${not empty patient.traitementsEnCours}">
                                <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded">
                                    <h4 class="text-sm font-bold text-gray-900 mb-2 flex items-center">
                                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                                        </svg>
                                        Traitements en Cours
                                    </h4>
                                    <p class="text-sm text-gray-700 font-medium"><c:out value="${patient.traitementsEnCours}"/></p>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Add Vital Signs Form -->
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                        <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                            <span class="bg-black text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm font-bold">2</span>
                            Ajouter les Nouveaux Signes Vitaux
                        </h3>
                        <form action="${pageContext.request.contextPath}/infirmier/mettre-a-jour-patient" method="post" class="space-y-6">
                            <input type="hidden" name="patientId" value="${patient.id}"/>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                                <!-- TA -->
                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Tension Artérielle
                                    </label>
                                    <input type="text" name="tensionArterielle" placeholder="120/80"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">Format: 120/80 mmHg</p>
                                </div>

                                <!-- FC -->
                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Fréquence Cardiaque
                                    </label>
                                    <input type="number" name="frequenceCardiaque" placeholder="75" min="40" max="200"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">battements/min</p>
                                </div>

                                <!-- Temp -->
                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Température
                                    </label>
                                    <input type="number" name="temperature" step="0.1" placeholder="37.2" min="35" max="42"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">°C</p>
                                </div>

                                <!-- FR -->
                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Fréq. Respiratoire
                                    </label>
                                    <input type="number" name="frequenceRespiratoire" placeholder="16" min="10" max="40"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">respirations/min</p>
                                </div>
                            </div>

                            <!-- Optional -->
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Poids (optionnel)
                                    </label>
                                    <input type="number" name="poids" step="0.1" placeholder="70.5" min="1" max="300"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">kg</p>
                                </div>

                                <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                                    <label class="block text-sm font-bold text-gray-900 mb-2">
                                        Taille (optionnel)
                                    </label>
                                    <input type="number" name="taille" placeholder="175" min="50" max="250"
                                           class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                                    <p class="text-xs text-gray-600 mt-2 font-semibold">cm</p>
                                </div>
                            </div>

                            <!-- Submit -->
                            <div class="bg-gray-50 border-l-4 border-black p-5 rounded-lg">
                                <p class="text-sm text-gray-700 mb-4 font-medium">
                                    ✅ Le patient sera ajouté à la file d'attente avec le statut <span class="bg-gray-200 text-gray-900 px-2 py-1 rounded font-bold">EN_ATTENTE</span>
                                </p>
                                <div class="flex gap-3">
                                    <a href="${pageContext.request.contextPath}/infirmier/accueil"
                                       class="flex-1 bg-white border-2 border-gray-300 hover:border-gray-900 text-gray-900 font-bold py-3 px-6 rounded-lg flex items-center justify-center">
                                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                        </svg>
                                        Nouvelle Recherche
                                    </a>
                                    <button type="submit"
                                            class="flex-1 bg-black hover:bg-gray-800 text-white font-bold py-3 px-8 rounded-lg flex items-center justify-center shadow-lg">
                                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                        </svg>
                                        Enregistrer et Ajouter à la File d'Attente
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Scénario B : Nouveau Patient -->
        <div id="create-tab" class="tab-content hidden">
            <div class="bg-gradient-to-r from-gray-900 to-black rounded-xl shadow-lg p-6 mb-6">
                <div class="flex items-center mb-2">
                    <div class="bg-white p-2 rounded-lg">
                        <svg class="h-6 w-6 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                        </svg>
                    </div>
                    <h2 class="text-white text-xl font-bold ml-3">Créer un Nouveau Dossier Patient</h2>
                </div>
                <p class="text-gray-300 text-sm">Complétez toutes les informations administratives, médicales et les signes vitaux</p>
            </div>

            <!-- Messages -->
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6 rounded-lg">
                    <div class="flex">
                        <svg class="h-5 w-5 text-red-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <p class="text-sm font-medium text-red-800">${errorMessage}</p>
                    </div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/infirmier/ajouter-patient" method="post" class="space-y-6">
                <!-- Données Administratives -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-5 flex items-center pb-3 border-b border-gray-200">
                        <span class="bg-black text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm font-bold">1</span>
                        Données Administratives
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Nom <span class="text-black">*</span></label>
                            <input type="text" name="nom" required placeholder="Exemple : Bennani" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Prénom <span class="text-black">*</span></label>
                            <input type="text" name="prenom" required placeholder="Exemple : Ahmed" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Date de Naissance <span class="text-black">*</span></label>
                            <input type="date" name="dateNaissance" required class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">N° Sécurité Sociale <span class="text-black">*</span></label>
                            <input type="text" name="numeroSecuriteSociale" required placeholder="13 chiffres" maxlength="13" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Téléphone</label>
                            <input type="tel" name="telephone" placeholder="Exemple : 0612345678" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">Adresse Complète</label>
                            <input type="text" name="adresse" placeholder="Exemple : 123 Rue Mohammed V, Casablanca" class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                        </div>
                    </div>
                </div>

                <!-- Données Médicales -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-5 flex items-center pb-3 border-b border-gray-200">
                        <span class="bg-black text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm font-bold">2</span>
                        Données Médicales
                    </h3>
                    <div class="space-y-4">
                        <div class="bg-gray-50 p-4 rounded-lg border-2 border-gray-300">
                            <label class="block text-sm font-bold text-gray-900 mb-2 flex items-center">
                                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                            </label>
                            <textarea name="antecedents" rows="3" placeholder="Maladies passées, opérations, hospitalisations..." class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium resize-none"></textarea>
                        </div>

                        <div class="bg-gray-50 p-4 rounded-lg border-2 border-gray-300">
                            <label class="block text-sm font-bold text-gray-900 mb-2 flex items-center">
                                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                            </label>
                            <textarea name="allergies" rows="2" placeholder="Médicaments, aliments, autres allergies..." class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium resize-none"></textarea>
                        </div>

                        <div class="bg-gray-50 p-4 rounded-lg border-2 border-gray-300">
                            <label class="block text-sm font-bold text-gray-900 mb-2 flex items-center">
                                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                            </label>
                            <textarea name="traitementsEnCours" rows="2" placeholder="Médicaments actuels avec posologie..." class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium resize-none"></textarea>
                        </div>
                    </div>
                </div>

                <!-- Signes Vitaux -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-5 flex items-center pb-3 border-b border-gray-200">
                        <span class="bg-black text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 text-sm font-bold">3</span>
                        Signes Vitaux
                    </h3>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                        <!-- Tension Artérielle -->
                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Tension Artérielle
                            </label>
                            <input type="text" name="tensionArterielle" placeholder="120/80" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">Format: 120/80 mmHg</p>
                        </div>

                        <!-- Fréquence Cardiaque -->
                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Fréquence Cardiaque
                            </label>
                            <input type="number" name="frequenceCardiaque" placeholder="75" min="40" max="200" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">battements/min</p>
                        </div>

                        <!-- Température -->
                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Température
                            </label>
                            <input type="number" name="temperature" step="0.1" placeholder="37.2" min="35" max="42" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">°C</p>
                        </div>

                        <!-- Fréquence Respiratoire -->
                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Fréq. Respiratoire
                            </label>
                            <input type="number" name="frequenceRespiratoire" placeholder="16" min="10" max="40" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">respirations/min</p>
                        </div>
                    </div>

                    <!-- Poids et Taille (Optionnels) -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Poids (optionnel)
                            </label>
                            <input type="number" name="poids" step="0.1" placeholder="70.5" min="1" max="300" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">kg</p>
                        </div>

                        <div class="bg-white p-4 rounded-lg border-2 border-gray-300 hover:border-gray-900">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Taille (optionnel)
                            </label>
                            <input type="number" name="taille" placeholder="175" min="50" max="250" class="w-full px-3 py-2 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-semibold">
                            <p class="text-xs text-gray-600 mt-2 font-semibold">cm</p>
                        </div>
                    </div>
                </div>

                <!-- Information et Submit -->
                <div class="bg-gray-50 border-l-4 border-black rounded-lg p-6">
                    <div class="flex items-start mb-5">
                        <svg class="h-6 w-6 text-black mr-3 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <div>
                            <h4 class="text-sm font-bold text-gray-900 mb-2">Information Importante</h4>
                            <p class="text-sm text-gray-700 font-medium">
                                ✅ Le dossier patient sera créé et le patient sera <strong>automatiquement ajouté à la file d'attente</strong> avec le statut <span class="bg-gray-200 text-gray-900 px-2 py-1 rounded font-bold">EN_ATTENTE</span>
                            </p>
                        </div>
                    </div>

                    <div class="flex flex-col sm:flex-row gap-3">
                        <button type="button" onclick="showTab('search')"
                                class="flex-1 bg-white border-2 border-gray-300 hover:border-gray-900 text-gray-900 font-bold py-3 px-6 rounded-lg flex items-center justify-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                            Annuler
                        </button>
                        <button type="submit"
                                class="flex-1 bg-black hover:bg-gray-800 text-white font-bold py-3 px-6 rounded-lg flex items-center justify-center shadow-lg">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                            </svg>
                            Créer le Dossier et Ajouter à la File
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </main>
</div>

<script>
    // Mobile menu toggle
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

    // Tab switching
    function showTab(tab) {
        const searchTab = document.getElementById('search-tab');
        const createTab = document.getElementById('create-tab');
        const searchBtn = document.getElementById('tab-search');
        const createBtn = document.getElementById('tab-create');

        if (tab === 'search') {
            searchTab.classList.remove('hidden');
            createTab.classList.add('hidden');
            searchBtn.classList.add('border-black', 'text-black');
            searchBtn.classList.remove('border-transparent', 'text-gray-500');
            createBtn.classList.remove('border-black', 'text-black');
            createBtn.classList.add('border-transparent', 'text-gray-500');
        } else {
            searchTab.classList.add('hidden');
            createTab.classList.remove('hidden');
            createBtn.classList.add('border-black', 'text-black');
            createBtn.classList.remove('border-transparent', 'text-gray-500');
            searchBtn.classList.remove('border-black', 'text-black');
            searchBtn.classList.add('border-transparent', 'text-gray-500');
        }
    }

    // Show patient info (for demo)
    function showPatientInfo() {
        document.getElementById('patient-info').classList.remove('hidden');
        // Smooth scroll to the patient info section
        setTimeout(() => {
            document.getElementById('patient-info').scrollIntoView({ behavior: 'smooth', block: 'start' });
        }, 100);
    }
</script>
</body>
</html>

