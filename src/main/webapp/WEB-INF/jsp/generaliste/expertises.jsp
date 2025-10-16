<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes Demandes d'Expertise - Télé-Expertise</title>
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
                    <h1 class="text-2xl font-bold text-gray-900">🩺 Mes Demandes d'Expertise</h1>
                    <p class="text-sm text-gray-600 mt-1">Suivi des demandes d'avis spécialiste</p>
                </div>
                <a href="${pageContext.request.contextPath}/generaliste/demander-expertise"
                   class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Nouvelle Demande
                </a>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Filters -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Rechercher</label>
                    <input type="text" placeholder="Patient, spécialiste..."
                           class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Statut</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option value="">Tous les statuts</option>
                        <option value="EN_ATTENTE">En attente</option>
                        <option value="EN_COURS">En cours</option>
                        <option value="REPONDU">Répondu</option>
                        <option value="TERMINE">Terminé</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Priorité</label>
                    <select class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                        <option value="">Toutes</option>
                        <option value="URGENTE">Urgente</option>
                        <option value="NORMALE">Normale</option>
                        <option value="NON_URGENTE">Non urgente</option>
                    </select>
                </div>
                <div class="flex items-end">
                    <button class="w-full bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg">
                        Filtrer
                    </button>
                </div>
            </div>
        </div>

        <!-- Stats -->
        <div class="grid grid-cols-1 sm:grid-cols-4 gap-6 mb-6">
            <div class="bg-gradient-to-r from-purple-500 to-purple-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-purple-100 uppercase">Total</p>
                        <p class="text-3xl font-bold mt-2">45</p>
                    </div>
                    <div class="bg-white/20 p-3 rounded-lg">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-yellow-100 uppercase">En Attente</p>
                        <p class="text-3xl font-bold mt-2">8</p>
                    </div>
                    <div class="bg-white/20 p-3 rounded-lg">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-blue-100 uppercase">Répondues</p>
                        <p class="text-3xl font-bold mt-2">32</p>
                    </div>
                    <div class="bg-white/20 p-3 rounded-lg">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                        </svg>
                    </div>
                </div>
            </div>

            <div class="bg-gradient-to-r from-green-500 to-green-600 rounded-xl shadow-lg p-6 text-white">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-green-100 uppercase">Terminées</p>
                        <p class="text-3xl font-bold mt-2">5</p>
                    </div>
                    <div class="bg-white/20 p-3 rounded-lg">
                        <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <!-- Expertises List -->
        <div class="space-y-6">
            <!-- Urgent Expertise -->
            <div class="bg-white rounded-xl shadow-sm border-l-4 border-red-500 overflow-hidden">
                <div class="p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-2">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-800">
                                    🚨 URGENTE
                                </span>
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-yellow-100 text-yellow-800">
                                    En attente de réponse
                                </span>
                            </div>
                            <h3 class="text-lg font-bold text-gray-900">Cardiologie - Dr. Karim BENJELLOUN</h3>
                            <p class="text-sm text-gray-600 mt-1">Patient: Mohammed ALAMI | Demandé le 16/10/2025 à 10:30</p>
                        </div>
                        <div class="text-right">
                            <div class="text-lg font-bold text-gray-900">300 DH</div>
                            <div class="text-xs text-gray-500">RDV: 17/10 à 14:00</div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-lg p-4 mb-4">
                        <div class="text-sm font-bold text-gray-900 mb-2">Question posée:</div>
                        <p class="text-sm text-gray-700">Patient de 40 ans présentant des douleurs thoraciques avec irradiation vers le bras gauche, essoufflement à l'effort. Antécédents familiaux cardiovasculaires + tabagisme. Nécessite avis urgent.</p>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center text-sm text-gray-600">
                            <svg class="h-5 w-5 text-yellow-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            En attente depuis 6 heures
                        </div>
                        <div class="flex space-x-2">
                            <a href="${pageContext.request.contextPath}/generaliste/expertise/1"
                               class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg text-sm">
                                Voir Détails
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Answered Expertise -->
            <div class="bg-white rounded-xl shadow-sm border-l-4 border-green-500 overflow-hidden">
                <div class="p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-2">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-yellow-100 text-yellow-800">
                                    ⚠️ NORMALE
                                </span>
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                    ✅ Répondu
                                </span>
                            </div>
                            <h3 class="text-lg font-bold text-gray-900">Dermatologie - Dr. Leila ALAOUI</h3>
                            <p class="text-sm text-gray-600 mt-1">Patient: Fatima ELMOUSSAOUI | Demandé le 15/10/2025 à 09:00</p>
                        </div>
                        <div class="text-right">
                            <div class="text-lg font-bold text-gray-900">250 DH</div>
                            <div class="text-xs text-gray-500">Répondu le 15/10</div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-lg p-4 mb-4">
                        <div class="text-sm font-bold text-gray-900 mb-2">Question posée:</div>
                        <p class="text-sm text-gray-700">Patiente de 35 ans avec lésions cutanées suspectes. Demande d'avis pour diagnostic différentiel et nécessité de biopsie.</p>
                    </div>

                    <div class="bg-green-50 border-2 border-green-200 rounded-lg p-4 mb-4">
                        <div class="flex items-center mb-2">
                            <svg class="h-5 w-5 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <div class="text-sm font-bold text-green-900">Avis du Spécialiste</div>
                        </div>
                        <p class="text-sm text-green-900">Aspect clinique évocateur d'eczéma de contact. Pas de signe de malignité. Recommande traitement topique corticoïde niveau 2 et éviction allergènes. Suivi dans 3 semaines.</p>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center text-sm text-green-600">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Répondu il y a 1 jour
                        </div>
                        <div class="flex space-x-2">
                            <a href="${pageContext.request.contextPath}/generaliste/expertise/2"
                               class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg text-sm">
                                Voir Détails
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Normal Priority Expertise -->
            <div class="bg-white rounded-xl shadow-sm border-l-4 border-blue-500 overflow-hidden">
                <div class="p-6">
                    <div class="flex items-start justify-between mb-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-3 mb-2">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                    ✅ NON URGENTE
                                </span>
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-blue-100 text-blue-800">
                                    En cours d'analyse
                                </span>
                            </div>
                            <h3 class="text-lg font-bold text-gray-900">Endocrinologie - Dr. Youssef TAZI</h3>
                            <p class="text-sm text-gray-600 mt-1">Patient: Ahmed HAFIDI | Demandé le 14/10/2025 à 14:00</p>
                        </div>
                        <div class="text-right">
                            <div class="text-lg font-bold text-gray-900">280 DH</div>
                            <div class="text-xs text-gray-500">RDV: 18/10 à 10:00</div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-lg p-4 mb-4">
                        <div class="text-sm font-bold text-gray-900 mb-2">Question posée:</div>
                        <p class="text-sm text-gray-700">Suivi diabète type 2. HbA1c à 8.5%. Demande d'avis pour ajustement thérapeutique et passage éventuel à insulinothérapie.</p>
                    </div>

                    <div class="flex items-center justify-between">
                        <div class="flex items-center text-sm text-gray-600">
                            <svg class="h-5 w-5 text-blue-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Le spécialiste a pris connaissance du dossier
                        </div>
                        <div class="flex space-x-2">
                            <a href="${pageContext.request.contextPath}/generaliste/expertise/3"
                               class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg text-sm">
                                Voir Détails
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="mt-6 bg-white rounded-xl shadow-sm border border-gray-200 px-6 py-4">
            <div class="flex items-center justify-between">
                <div class="text-sm text-gray-700">
                    Affichage de <span class="font-bold">1</span> à <span class="font-bold">10</span> sur <span class="font-bold">45</span> résultats
                </div>
                <div class="flex space-x-2">
                    <button class="px-4 py-2 border-2 border-gray-300 rounded-lg text-sm font-bold text-gray-700 hover:bg-gray-100">
                        Précédent
                    </button>
                    <button class="px-4 py-2 bg-black text-white rounded-lg text-sm font-bold">1</button>
                    <button class="px-4 py-2 border-2 border-gray-300 rounded-lg text-sm font-bold text-gray-700 hover:bg-gray-100">2</button>
                    <button class="px-4 py-2 border-2 border-gray-300 rounded-lg text-sm font-bold text-gray-700 hover:bg-gray-100">3</button>
                    <button class="px-4 py-2 border-2 border-gray-300 rounded-lg text-sm font-bold text-gray-700 hover:bg-gray-100">
                        Suivant
                    </button>
                </div>
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

