<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Demander Expertise - Télé-Expertise</title>
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

            <a href="${pageContext.request.contextPath}/generaliste/patients"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                </svg>
                Patients en Attente
            </a>

            <a href="${pageContext.request.contextPath}/generaliste/consultations"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                Mes Consultations
            </a>

            <a href="${pageContext.request.contextPath}/generaliste/expertises"
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
                Demandes d'Expertise
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
                    <h1 class="text-2xl font-bold text-gray-900">🩺 Demander un Avis Spécialiste</h1>
                    <p class="text-sm text-gray-600 mt-1">Télé-expertise avec un médecin spécialiste</p>
                </div>
                <a href="${pageContext.request.contextPath}/generaliste/consultations"
                   class="bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-2 rounded-lg flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Retour
                </a>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <div class="max-w-4xl mx-auto">
            <form id="expertiseForm" class="space-y-6">
                <!-- Step 1: Select Specialty -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">1</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Choisir la Spécialité</h2>
                            <p class="text-sm text-gray-600">Sélectionnez le type de spécialiste requis</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="CARDIOLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-red-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Cardiologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="PNEUMOLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-blue-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Pneumologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="NEUROLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-purple-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Neurologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="DERMATOLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-pink-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-pink-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Dermatologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="GASTRO_ENTEROLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-yellow-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Gastro-entérologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="ENDOCRINOLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-green-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Endocrinologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="RHUMATOLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-orange-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Rhumatologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="PSYCHIATRIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-indigo-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Psychiatrie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="NEPHROLOGIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-teal-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-teal-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Néphrologie</span>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialite" value="ORTHOPEDIE" class="sr-only" onchange="loadSpecialists(this.value)">
                            <div class="flex items-center w-full">
                                <div class="bg-gray-100 p-3 rounded-lg mr-3">
                                    <svg class="h-6 w-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                                    </svg>
                                </div>
                                <span class="font-bold text-gray-900">Orthopédie</span>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Step 2: Select Specialist -->
                <div id="specialistSection" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">2</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Sélectionner un Spécialiste</h2>
                            <p class="text-sm text-gray-600">Choisissez parmi les spécialistes disponibles</p>
                        </div>
                    </div>

                    <div id="specialistsList" class="space-y-4">
                        <!-- Example specialists - will be loaded dynamically -->
                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialiste" value="1" class="sr-only" onchange="loadCreneaux(this.value)">
                            <div class="flex items-center justify-between w-full">
                                <div class="flex items-center">
                                    <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">KB</div>
                                    <div class="ml-4">
                                        <div class="text-sm font-bold text-gray-900">Dr. Karim BENJELLOUN</div>
                                        <div class="text-xs text-gray-500">Cardiologue | 15 ans d'expérience</div>
                                        <div class="flex items-center mt-1">
                                            <svg class="h-4 w-4 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                                <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                            </svg>
                                            <span class="text-xs text-gray-600 ml-1">4.8/5 (120 avis)</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <div class="text-lg font-bold text-gray-900">300 DH</div>
                                    <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                        Disponible
                                    </span>
                                </div>
                            </div>
                        </label>

                        <label class="relative flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer has-[:checked]:border-black has-[:checked]:bg-gray-50">
                            <input type="radio" name="specialiste" value="2" class="sr-only" onchange="loadCreneaux(this.value)">
                            <div class="flex items-center justify-between w-full">
                                <div class="flex items-center">
                                    <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">SE</div>
                                    <div class="ml-4">
                                        <div class="text-sm font-bold text-gray-900">Dr. Samira ELMALKI</div>
                                        <div class="text-xs text-gray-500">Cardiologue | 20 ans d'expérience</div>
                                        <div class="flex items-center mt-1">
                                            <svg class="h-4 w-4 text-yellow-400 fill-current" viewBox="0 0 20 20">
                                                <path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/>
                                            </svg>
                                            <span class="text-xs text-gray-600 ml-1">4.9/5 (200 avis)</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <div class="text-lg font-bold text-gray-900">350 DH</div>
                                    <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                        Disponible
                                    </span>
                                </div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Step 3: Select Time Slot -->
                <div id="creneauSection" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">3</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Choisir un Créneau</h2>
                            <p class="text-sm text-gray-600">Sélectionnez la date et l'heure du rendez-vous</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
                        <!-- Example time slots -->
                        <label class="relative">
                            <input type="radio" name="creneau" value="1" class="sr-only peer">
                            <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-black peer-checked:bg-gray-50">
                                <div class="text-xs text-gray-500 font-bold">17 Oct 2025</div>
                                <div class="text-sm font-bold text-gray-900 mt-1">09:00 - 09:30</div>
                                <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800 mt-2">
                                    Disponible
                                </span>
                            </div>
                        </label>

                        <label class="relative">
                            <input type="radio" name="creneau" value="2" class="sr-only peer">
                            <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-black peer-checked:bg-gray-50">
                                <div class="text-xs text-gray-500 font-bold">17 Oct 2025</div>
                                <div class="text-sm font-bold text-gray-900 mt-1">09:30 - 10:00</div>
                                <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800 mt-2">
                                    Disponible
                                </span>
                            </div>
                        </label>

                        <label class="relative">
                            <input type="radio" name="creneau" value="3" class="sr-only peer">
                            <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-black peer-checked:bg-gray-50">
                                <div class="text-xs text-gray-500 font-bold">17 Oct 2025</div>
                                <div class="text-sm font-bold text-gray-900 mt-1">14:00 - 14:30</div>
                                <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800 mt-2">
                                    Disponible
                                </span>
                            </div>
                        </label>

                        <div class="p-4 border-2 border-gray-200 rounded-lg text-center bg-gray-100 opacity-50">
                            <div class="text-xs text-gray-400 font-bold">17 Oct 2025</div>
                            <div class="text-sm font-bold text-gray-400 mt-1">14:30 - 15:00</div>
                            <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-bold bg-red-100 text-red-800 mt-2">
                                Réservé
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Step 4: Request Details -->
                <div id="detailsSection" class="hidden bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">4</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Détails de la Demande</h2>
                            <p class="text-sm text-gray-600">Décrivez votre demande d'expertise</p>
                        </div>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Priorité <span class="text-red-600">*</span>
                            </label>
                            <div class="grid grid-cols-3 gap-4">
                                <label class="relative">
                                    <input type="radio" name="priorite" value="URGENTE" class="sr-only peer" required>
                                    <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-red-500 peer-checked:bg-red-50">
                                        <div class="text-sm font-bold text-gray-900">🚨 Urgente</div>
                                    </div>
                                </label>
                                <label class="relative">
                                    <input type="radio" name="priorite" value="NORMALE" class="sr-only peer">
                                    <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-yellow-500 peer-checked:bg-yellow-50">
                                        <div class="text-sm font-bold text-gray-900">⚠️ Normale</div>
                                    </div>
                                </label>
                                <label class="relative">
                                    <input type="radio" name="priorite" value="NON_URGENTE" class="sr-only peer">
                                    <div class="p-4 border-2 border-gray-300 rounded-lg text-center cursor-pointer hover:bg-gray-50 peer-checked:border-green-500 peer-checked:bg-green-50">
                                        <div class="text-sm font-bold text-gray-900">✅ Non urgente</div>
                                    </div>
                                </label>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Question posée au spécialiste <span class="text-red-600">*</span>
                            </label>
                            <textarea name="question" rows="6" required
                                      placeholder="Décrivez clairement votre question et ce que vous attendez du spécialiste...&#10;&#10;Ex: Patient de 40 ans avec douleurs thoraciques. Besoin d'avis sur diagnostic différentiel et prise en charge appropriée."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black"></textarea>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Documents et analyses à partager
                            </label>
                            <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center hover:bg-gray-50 cursor-pointer">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                                </svg>
                                <p class="mt-2 text-sm text-gray-600">
                                    <span class="font-bold text-black">Cliquez pour uploader</span> ou glissez-déposez
                                </p>
                                <p class="text-xs text-gray-500 mt-1">PDF, JPG, PNG jusqu'à 10MB</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Summary & Submit -->
                <div id="summarySection" class="hidden">
                    <div class="bg-gradient-to-r from-purple-500 to-purple-600 rounded-xl shadow-lg p-6 text-white mb-6">
                        <h2 class="text-lg font-bold mb-4">Récapitulatif de la Demande</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                            <div>
                                <div class="text-purple-100 text-xs uppercase font-bold">Spécialité</div>
                                <div class="font-bold mt-1">Cardiologie</div>
                            </div>
                            <div>
                                <div class="text-purple-100 text-xs uppercase font-bold">Spécialiste</div>
                                <div class="font-bold mt-1">Dr. Karim BENJELLOUN</div>
                            </div>
                            <div>
                                <div class="text-purple-100 text-xs uppercase font-bold">Date & Heure</div>
                                <div class="font-bold mt-1">17 Oct 2025 - 14:00</div>
                            </div>
                            <div>
                                <div class="text-purple-100 text-xs uppercase font-bold">Coût</div>
                                <div class="font-bold mt-1">300 DH</div>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between gap-4">
                        <a href="${pageContext.request.contextPath}/generaliste/consultations"
                           class="flex-1 bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-3 rounded-lg text-center">
                            Annuler
                        </a>
                        <button type="submit"
                                class="flex-1 bg-black hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Envoyer la Demande
                        </button>
                    </div>
                </div>
            </form>
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

    function loadSpecialists(specialite) {
        document.getElementById('specialistSection').classList.remove('hidden');
        document.getElementById('creneauSection').classList.add('hidden');
        document.getElementById('detailsSection').classList.add('hidden');
        document.getElementById('summarySection').classList.add('hidden');
    }

    function loadCreneaux(specialisteId) {
        document.getElementById('creneauSection').classList.remove('hidden');
        document.getElementById('detailsSection').classList.add('hidden');
        document.getElementById('summarySection').classList.add('hidden');
    }

    // Listen to creneau selection
    document.addEventListener('change', (e) => {
        if (e.target.name === 'creneau') {
            document.getElementById('detailsSection').classList.remove('hidden');
            document.getElementById('summarySection').classList.remove('hidden');
        }
    });

    document.getElementById('expertiseForm').addEventListener('submit', (e) => {
        e.preventDefault();
        if (confirm('Êtes-vous sûr de vouloir envoyer cette demande d\'expertise ?')) {
            alert('Demande envoyée avec succès ! Le spécialiste a été notifié.');
            window.location.href = '${pageContext.request.contextPath}/generaliste/expertises';
        }
    });
</script>
</body>
</html>

