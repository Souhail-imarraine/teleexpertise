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
                <span class="ml-3 text-white font-bold text-lg">TéléMed</span>
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
            <!-- Filters -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
                    </svg>
                    Filtrer les Patients
                </h3>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Rechercher</label>
                        <input type="text" placeholder="Nom ou N° Sécurité Sociale..."
                               class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Statut</label>
                        <select class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                            <option value="">Tous les statuts</option>
                            <option value="EN_ATTENTE">EN_ATTENTE</option>
                            <option value="EN_CONSULTATION">EN_CONSULTATION</option>
                            <option value="TERMINE">TERMINÉ</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Période</label>
                        <select class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                            <option value="">Toute la journée</option>
                            <option value="matin">Matin (08h-12h)</option>
                            <option value="apres-midi">Après-midi (12h-18h)</option>
                        </select>
                    </div>
                    <div class="flex items-end">
                        <button class="w-full bg-black hover:bg-gray-800 text-white font-bold py-3 px-6 rounded-lg shadow-lg">
                            Appliquer les Filtres
                        </button>
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
                        <div class="mt-3 sm:mt-0 flex items-center space-x-2">
                            <button class="p-2 text-white hover:bg-white/20 rounded-lg">
                                <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                </svg>
                            </button>
                            <button class="p-2 text-white hover:bg-white/20 rounded-lg">
                                <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                                </svg>
                            </button>
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
                            <!-- Patient 1 -->
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold text-base">
                                            AB
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-bold text-gray-900">Ahmed Bennani</div>
                                            <div class="text-xs font-medium text-gray-500">45 ans • N° 1234567890123</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <svg class="h-5 w-5 text-gray-900 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        <div>
                                            <div class="text-sm font-bold text-gray-900">08:30</div>
                                            <div class="text-xs font-medium text-gray-500">il y a 1h30</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="space-y-1 text-xs">
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">TA:</span>
                                            <span class="font-semibold text-gray-700">120/80 mmHg</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FC:</span>
                                            <span class="font-semibold text-gray-700">72 bpm</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">Temp:</span>
                                            <span class="font-semibold text-gray-700">37.2°C</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FR:</span>
                                            <span class="font-semibold text-gray-700">16 rpm</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border-2 border-gray-300">
                                        EN_ATTENTE
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <button class="bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                        Voir Détails
                                    </button>
                                </td>
                            </tr>

                            <!-- Patient 2 -->
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold text-base">
                                            FZ
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-bold text-gray-900">Fatima Zahrae</div>
                                            <div class="text-xs font-medium text-gray-500">32 ans • N° 2345678901234</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <svg class="h-5 w-5 text-gray-900 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        <div>
                                            <div class="text-sm font-bold text-gray-900">09:15</div>
                                            <div class="text-xs font-medium text-gray-500">il y a 45min</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="space-y-1 text-xs">
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">TA:</span>
                                            <span class="font-semibold text-gray-700">115/75 mmHg</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FC:</span>
                                            <span class="font-semibold text-gray-700">68 bpm</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">Temp:</span>
                                            <span class="font-semibold text-gray-700">36.8°C</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FR:</span>
                                            <span class="font-semibold text-gray-700">14 rpm</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border-2 border-gray-300">
                                        EN_CONSULTATION
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <button class="bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                        Voir Détails
                                    </button>
                                </td>
                            </tr>

                            <!-- Patient 3 -->
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold text-base">
                                            MK
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-bold text-gray-900">Mohamed Karim</div>
                                            <div class="text-xs font-medium text-gray-500">28 ans • N° 3456789012345</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center">
                                        <svg class="h-5 w-5 text-gray-900 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                        </svg>
                                        <div>
                                            <div class="text-sm font-bold text-gray-900">09:45</div>
                                            <div class="text-xs font-medium text-gray-500">il y a 15min</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="space-y-1 text-xs">
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">TA:</span>
                                            <span class="font-semibold text-gray-700">130/85 mmHg</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FC:</span>
                                            <span class="font-semibold text-gray-700">78 bpm</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">Temp:</span>
                                            <span class="font-semibold text-gray-700">37.5°C</span>
                                        </div>
                                        <div class="flex items-center">
                                            <span class="w-16 font-bold text-gray-900">FR:</span>
                                            <span class="font-semibold text-gray-700">18 rpm</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center px-3 py-1.5 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border-2 border-gray-300">
                                        TERMINÉ
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <button class="bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                        Voir Détails
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Mobile Cards -->
                <div class="md:hidden divide-y divide-gray-200">
                    <!-- Patient Card 1 -->
                    <div class="p-4 hover:bg-gray-50">
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex items-center">
                                <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">
                                    AB
                                </div>
                                <div class="ml-3">
                                    <div class="text-sm font-bold text-gray-900">Ahmed Bennani</div>
                                    <div class="text-xs font-medium text-gray-500">45 ans • N° 1234...</div>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border border-gray-300">
                                EN_ATTENTE
                            </span>
                        </div>
                        <div class="bg-gray-50 border-l-4 border-black p-3 mb-3">
                            <div class="flex items-center text-xs font-medium text-gray-900">
                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <span class="font-bold">Arrivée: 08:30</span>
                                <span class="ml-2 text-gray-500">(il y a 1h30)</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mb-3">
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">TA:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">120/80</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FC:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">72 bpm</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">Temp:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">37.2°C</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FR:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">16 rpm</span>
                            </div>
                        </div>
                        <button class="w-full bg-black hover:bg-gray-800 text-white font-bold py-2.5 rounded-lg text-sm shadow-lg">
                            Voir Détails Complets
                        </button>
                    </div>

                    <!-- Patient Card 2 -->
                    <div class="p-4 hover:bg-gray-50">
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex items-center">
                                <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">
                                    FZ
                                </div>
                                <div class="ml-3">
                                    <div class="text-sm font-bold text-gray-900">Fatima Zahrae</div>
                                    <div class="text-xs font-medium text-gray-500">32 ans • N° 2345...</div>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border border-gray-300">
                                EN_CONSULTATION
                            </span>
                        </div>
                        <div class="bg-gray-50 border-l-4 border-black p-3 mb-3">
                            <div class="flex items-center text-xs font-medium text-gray-900">
                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <span class="font-bold">Arrivée: 09:15</span>
                                <span class="ml-2 text-gray-500">(il y a 45min)</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mb-3">
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">TA:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">115/75</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FC:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">68 bpm</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">Temp:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">36.8°C</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FR:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">14 rpm</span>
                            </div>
                        </div>
                        <button class="w-full bg-black hover:bg-gray-800 text-white font-bold py-2.5 rounded-lg text-sm shadow-lg">
                            Voir Détails Complets
                        </button>
                    </div>

                    <!-- Patient Card 3 -->
                    <div class="p-4 hover:bg-gray-50">
                        <div class="flex items-start justify-between mb-3">
                            <div class="flex items-center">
                                <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">
                                    MK
                                </div>
                                <div class="ml-3">
                                    <div class="text-sm font-bold text-gray-900">Mohamed Karim</div>
                                    <div class="text-xs font-medium text-gray-500">28 ans • N° 3456...</div>
                                </div>
                            </div>
                            <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-bold bg-gray-200 text-gray-900 border border-gray-300">
                                TERMINÉ
                            </span>
                        </div>
                        <div class="bg-gray-50 border-l-4 border-black p-3 mb-3">
                            <div class="flex items-center text-xs font-medium text-gray-900">
                                <svg class="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <span class="font-bold">Arrivée: 09:45</span>
                                <span class="ml-2 text-gray-500">(il y a 15min)</span>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mb-3">
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">TA:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">130/85</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FC:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">78 bpm</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">Temp:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">37.5°C</span>
                            </div>
                            <div class="bg-gray-50 p-2.5 rounded-lg border border-gray-200">
                                <span class="text-xs font-bold text-gray-900">FR:</span>
                                <span class="text-xs font-semibold text-gray-700 ml-1">18 rpm</span>
                            </div>
                        </div>
                        <button class="w-full bg-black hover:bg-gray-800 text-white font-bold py-2.5 rounded-lg text-sm shadow-lg">
                            Voir Détails Complets
                        </button>
                    </div>
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
        document.getElementById('current-date').textContent = new Date().toLocaleDateString('fr-FR', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    </script>
</body>
</html>
