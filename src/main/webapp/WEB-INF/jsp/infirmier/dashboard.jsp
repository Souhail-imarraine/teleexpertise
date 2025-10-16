<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Infirmier - Télé-Expertise Médicale</title>
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
                   class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                    <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">Dashboard Infirmier</h1>
                        <p class="text-sm text-gray-600 mt-1">Vue d'ensemble de l'activité quotidienne</p>
                    </div>
                    <div class="hidden sm:flex items-center space-x-2 text-sm font-medium text-gray-900">
                        <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        <span id="current-date"></span>
                    </div>
                </div>
            </div>
        </header>

        <!-- Content -->
        <main class="p-4 sm:p-6 lg:p-8">
            <!-- Quick Actions -->
            <div class="mb-8">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                    </svg>
                    Actions Rapides
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Action 1: US1 - Accueil Patient -->
                    <a href="${pageContext.request.contextPath}/infirmier/accueil"
                       class="group bg-white border-2 border-gray-300 rounded-xl p-6 hover:shadow-xl hover:border-black transition-all duration-200">
                        <div class="flex items-start space-x-4">
                            <div class="flex-shrink-0">
                                <div class="bg-black rounded-lg p-3 group-hover:scale-110 transition-transform">
                                    <svg class="h-8 w-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                                    </svg>
                                </div>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between mb-2">
                                    <h4 class="text-lg font-bold text-gray-900">Accueillir un Patient</h4>
                                    <span class="text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">US1</span>
                                </div>
                                <p class="text-sm text-gray-600 mb-3 font-medium">Rechercher ou créer un nouveau dossier patient</p>
                                <div class="flex items-center text-black text-sm font-bold">
                                    <span>Commencer</span>
                                    <svg class="h-4 w-4 ml-1 group-hover:translate-x-2 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </a>

                    <!-- Action 2: US2 - Liste Patients -->
                    <a href="${pageContext.request.contextPath}/infirmier/patients"
                       class="group bg-white border-2 border-gray-300 rounded-xl p-6 hover:shadow-xl hover:border-black transition-all duration-200">
                        <div class="flex items-start space-x-4">
                            <div class="flex-shrink-0">
                                <div class="bg-black rounded-lg p-3 group-hover:scale-110 transition-transform">
                                    <svg class="h-8 w-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                    </svg>
                                </div>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between mb-2">
                                    <h4 class="text-lg font-bold text-gray-900">Patients du Jour</h4>
                                    <span class="text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">US2</span>
                                </div>
                                <p class="text-sm text-gray-600 mb-3 font-medium">Liste complète triée par heure d'arrivée</p>
                                <div class="flex items-center text-black text-sm font-bold">
                                    <span>Voir la liste</span>
                                    <svg class="h-4 w-4 ml-1 group-hover:translate-x-2 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="mb-8">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-bold text-gray-900 flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Derniers Enregistrements
                    </h3>
                    <a href="${pageContext.request.contextPath}/infirmier/patients" class="text-sm text-black hover:text-gray-700 font-bold flex items-center">
                        <span>Voir Tout</span>
                        <svg class="h-4 w-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </a>
                </div>

                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="divide-y divide-gray-200">
                        <!-- Patient 1 -->
                        <div class="p-4 hover:bg-gray-50 transition-colors cursor-pointer">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <div class="relative">
                                        <div class="bg-black text-white rounded-full h-12 w-12 flex items-center justify-center font-bold text-base">
                                            AB
                                        </div>
                                        <span class="absolute -bottom-1 -right-1 bg-gray-900 border-2 border-white rounded-full h-4 w-4"></span>
                                    </div>
                                    <div class="ml-4 flex-1">
                                        <div class="flex items-center">
                                            <h4 class="text-sm font-bold text-gray-900">Ahmed Bennani</h4>
                                            <span class="ml-2 text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">
                                                Enregistré
                                            </span>
                                        </div>
                                        <div class="flex items-center mt-1 space-x-3 text-xs font-medium text-gray-600">
                                            <span class="flex items-center">
                                                <svg class="h-3.5 w-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                Il y a 5 minutes
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">TA:</span>
                                                <span class="ml-1">120/80 mmHg</span>
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">FC:</span>
                                                <span class="ml-1">72 bpm</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <svg class="h-5 w-5 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Patient 2 -->
                        <div class="p-4 hover:bg-gray-50 transition-colors cursor-pointer">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <div class="relative">
                                        <div class="bg-black text-white rounded-full h-12 w-12 flex items-center justify-center font-bold text-base">
                                            FZ
                                        </div>
                                        <span class="absolute -bottom-1 -right-1 bg-gray-500 border-2 border-white rounded-full h-4 w-4"></span>
                                    </div>
                                    <div class="ml-4 flex-1">
                                        <div class="flex items-center">
                                            <h4 class="text-sm font-bold text-gray-900">Fatima Zahrae</h4>
                                            <span class="ml-2 text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">
                                                En attente
                                            </span>
                                        </div>
                                        <div class="flex items-center mt-1 space-x-3 text-xs font-medium text-gray-600">
                                            <span class="flex items-center">
                                                <svg class="h-3.5 w-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                Il y a 12 minutes
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">TA:</span>
                                                <span class="ml-1">115/75 mmHg</span>
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">FC:</span>
                                                <span class="ml-1">68 bpm</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <svg class="h-5 w-5 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Patient 3 -->
                        <div class="p-4 hover:bg-gray-50 transition-colors cursor-pointer">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <div class="relative">
                                        <div class="bg-black text-white rounded-full h-12 w-12 flex items-center justify-center font-bold text-base">
                                            MK
                                        </div>
                                        <span class="absolute -bottom-1 -right-1 bg-gray-700 border-2 border-white rounded-full h-4 w-4"></span>
                                    </div>
                                    <div class="ml-4 flex-1">
                                        <div class="flex items-center">
                                            <h4 class="text-sm font-bold text-gray-900">Mohamed Karim</h4>
                                            <span class="ml-2 text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">
                                                Consulté
                                            </span>
                                        </div>
                                        <div class="flex items-center mt-1 space-x-3 text-xs font-medium text-gray-600">
                                            <span class="flex items-center">
                                                <svg class="h-3.5 w-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                Il y a 25 minutes
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">TA:</span>
                                                <span class="ml-1">130/85 mmHg</span>
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">FC:</span>
                                                <span class="ml-1">78 bpm</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <svg class="h-5 w-5 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Patient 4 -->
                        <div class="p-4 hover:bg-gray-50 transition-colors cursor-pointer">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <div class="relative">
                                        <div class="bg-black text-white rounded-full h-12 w-12 flex items-center justify-center font-bold text-base">
                                            SA
                                        </div>
                                        <span class="absolute -bottom-1 -right-1 bg-gray-900 border-2 border-white rounded-full h-4 w-4"></span>
                                    </div>
                                    <div class="ml-4 flex-1">
                                        <div class="flex items-center">
                                            <h4 class="text-sm font-bold text-gray-900">Sara Alami</h4>
                                            <span class="ml-2 text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">
                                                Enregistré
                                            </span>
                                        </div>
                                        <div class="flex items-center mt-1 space-x-3 text-xs font-medium text-gray-600">
                                            <span class="flex items-center">
                                                <svg class="h-3.5 w-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                Il y a 35 minutes
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">TA:</span>
                                                <span class="ml-1">118/76 mmHg</span>
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">FC:</span>
                                                <span class="ml-1">70 bpm</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <svg class="h-5 w-5 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Patient 5 -->
                        <div class="p-4 hover:bg-gray-50 transition-colors cursor-pointer">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center flex-1">
                                    <div class="relative">
                                        <div class="bg-black text-white rounded-full h-12 w-12 flex items-center justify-center font-bold text-base">
                                            YM
                                        </div>
                                        <span class="absolute -bottom-1 -right-1 bg-gray-700 border-2 border-white rounded-full h-4 w-4"></span>
                                    </div>
                                    <div class="ml-4 flex-1">
                                        <div class="flex items-center">
                                            <h4 class="text-sm font-bold text-gray-900">Youssef Mansouri</h4>
                                            <span class="ml-2 text-xs bg-gray-200 text-gray-900 px-2.5 py-1 rounded-lg font-bold border border-gray-300">
                                                Consulté
                                            </span>
                                        </div>
                                        <div class="flex items-center mt-1 space-x-3 text-xs font-medium text-gray-600">
                                            <span class="flex items-center">
                                                <svg class="h-3.5 w-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                Il y a 48 minutes
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">TA:</span>
                                                <span class="ml-1">125/82 mmHg</span>
                                            </span>
                                            <span class="flex items-center">
                                                <span class="font-bold text-gray-900">FC:</span>
                                                <span class="ml-1">75 bpm</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <svg class="h-5 w-5 text-gray-900" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>
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
