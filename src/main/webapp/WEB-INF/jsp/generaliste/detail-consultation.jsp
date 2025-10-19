<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détail Consultation - Télé-Expertise</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        input:focus, textarea:focus, button:focus, select:focus { outline: none !important; }
        * { transition: all 0.2s ease; }
        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

<!-- Mobile Menu Button -->
<div class="lg:hidden fixed top-4 left-4 z-50 no-print">
    <button id="mobile-menu-btn" class="bg-white p-2 rounded-lg shadow-lg hover:bg-gray-100">
        <svg class="h-6 w-6 text-gray-800" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
        </svg>
    </button>
</div>

<!-- Sidebar -->
<div id="sidebar" class="no-print fixed inset-y-0 left-0 z-40 w-64 bg-white shadow-xl transform -translate-x-full lg:translate-x-0 transition-transform duration-300 border-r border-gray-200">
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

<div id="overlay" class="no-print hidden lg:hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

<!-- Main Content -->
<div class="lg:ml-64">
    <header class="no-print bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20">
        <div class="px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-bold text-gray-900">📋 Consultation #12345</h1>
                    <p class="text-sm text-gray-600 mt-1">Détails de la consultation</p>
                </div>
                <div class="flex space-x-3">
                    <button onclick="window.print()" class="bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-2 rounded-lg flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                        </svg>
                        Imprimer
                    </button>
                    <a href="${pageContext.request.contextPath}/generaliste/consultations"
                       class="bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-2 rounded-lg flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                        </svg>
                        Retour
                    </a>
                </div>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <div class="max-w-5xl mx-auto space-y-6">
            <!-- Status and Quick Actions -->
            <div class="no-print bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-4">
                        <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-bold bg-purple-100 text-purple-800">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            En attente d'avis spécialiste
                        </span>
                        <div class="text-sm text-gray-600">
                            Créée le <span class="font-bold">16/10/2025 à 09:30</span>
                        </div>
                    </div>
                    <div class="flex space-x-2">
                        <a href="${pageContext.request.contextPath}/generaliste/demander-expertise?consultationId=1"
                           class="bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg flex items-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                            Demander Avis
                        </a>
                        <button onclick="completeConsultation()" class="bg-green-600 hover:bg-green-700 text-white font-bold px-6 py-2 rounded-lg flex items-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Clôturer
                        </button>
                    </div>
                </div>
            </div>

            <!-- Patient Info -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    Informations Patient
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Nom Complet</label>
                        <p class="text-sm font-bold text-gray-900">Mohammed ALAMI</p>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Date de Naissance</label>
                        <p class="text-sm font-bold text-gray-900">15/03/1985 (40 ans)</p>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">N° Sécurité Sociale</label>
                        <p class="text-sm font-bold text-gray-900">1234567890123</p>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Téléphone</label>
                        <p class="text-sm font-bold text-gray-900">+212 6 12 34 56 78</p>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Mutuelle</label>
                        <p class="text-sm font-bold text-gray-900">CNSS</p>
                    </div>
                    <div>
                        <label class="block text-xs font-bold text-gray-500 uppercase mb-1">Groupe Sanguin</label>
                        <p class="text-sm font-bold text-gray-900">A+</p>
                    </div>
                </div>

                <!-- Vital Signs -->
                <div class="mt-6 pt-6 border-t border-gray-200">
                    <h3 class="text-sm font-bold text-gray-900 mb-3">Signes Vitaux</h3>
                    <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
                        <div class="bg-gray-50 rounded-lg p-3">
                            <div class="text-xs text-gray-500 font-bold">Tension Artérielle</div>
                            <div class="text-lg font-bold text-gray-900">120/80 mmHg</div>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-3">
                            <div class="text-xs text-gray-500 font-bold">Fréquence Cardiaque</div>
                            <div class="text-lg font-bold text-gray-900">72 bpm</div>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-3">
                            <div class="text-xs text-gray-500 font-bold">Température</div>
                            <div class="text-lg font-bold text-gray-900">37.2°C</div>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-3">
                            <div class="text-xs text-gray-500 font-bold">Saturation O₂</div>
                            <div class="text-lg font-bold text-gray-900">98%</div>
                        </div>
                        <div class="bg-gray-50 rounded-lg p-3">
                            <div class="text-xs text-gray-500 font-bold">Poids</div>
                            <div class="text-lg font-bold text-gray-900">75 kg</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Consultation Details -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Détails de la Consultation
                </h2>

                <div class="space-y-6">
                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Motif de Consultation</label>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-gray-900">Douleurs thoraciques récurrentes depuis 3 jours</p>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Symptômes</label>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <ul class="list-disc list-inside text-gray-900 space-y-1">
                                <li>Douleurs au niveau du thorax, irradiant vers le bras gauche</li>
                                <li>Essoufflement à l'effort</li>
                                <li>Sensation de fatigue inhabituelle</li>
                                <li>Légers vertiges occasionnels</li>
                            </ul>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Examen Clinique</label>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-gray-900 whitespace-pre-line">Inspection: Patient conscient, légèrement anxieux
Auscultation cardiaque: Rythme régulier, pas de souffle audible
Auscultation pulmonaire: Murmure vésiculaire normal
Palpation: Sensibilité au niveau du sternum
Examen neurologique: Normal</p>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Observations</label>
                        <div class="bg-gray-50 rounded-lg p-4">
                            <p class="text-gray-900">Patient avec antécédents familiaux de maladies cardiovasculaires. Tabagisme actif (10 cigarettes/jour depuis 15 ans). Stress professionnel important.</p>
                        </div>
                    </div>

                    <div id="diagnosticSection">
                        <label class="block text-sm font-bold text-gray-900 mb-2">Diagnostic</label>
                        <div class="bg-yellow-50 border-2 border-yellow-300 rounded-lg p-4">
                            <p class="text-yellow-800 flex items-center">
                                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                                </svg>
                                En attente de l'avis du cardiologue
                            </p>
                        </div>
                    </div>

                    <div id="treatmentSection">
                        <label class="block text-sm font-bold text-gray-900 mb-2">Prescription / Traitement</label>
                        <div class="bg-yellow-50 border-2 border-yellow-300 rounded-lg p-4">
                            <p class="text-yellow-800">Prescription en attente de validation après avis spécialiste</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Medical Acts -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                    </svg>
                    Actes Techniques Médicaux
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="bg-blue-50 border-2 border-blue-200 rounded-lg p-4">
                        <div class="flex items-center">
                            <svg class="h-6 w-6 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <div>
                                <div class="text-sm font-bold text-gray-900">Électrocardiogramme (ECG)</div>
                                <div class="text-xs text-gray-600">Prescrit - En attente</div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-blue-50 border-2 border-blue-200 rounded-lg p-4">
                        <div class="flex items-center">
                            <svg class="h-6 w-6 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <div>
                                <div class="text-sm font-bold text-gray-900">Analyse de sang</div>
                                <div class="text-xs text-gray-600">Prescrit - En attente</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Expertise Request -->
            <div class="bg-purple-50 border-2 border-purple-300 rounded-xl shadow-sm p-6">
                <h2 class="text-xl font-bold text-purple-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                    </svg>
                    Demande d'Expertise - Cardiologue
                </h2>
                <div class="space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-xs font-bold text-purple-900 uppercase mb-1">Spécialiste</label>
                            <p class="text-sm font-bold text-purple-900">Dr. Karim BENJELLOUN - Cardiologue</p>
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-purple-900 uppercase mb-1">Rendez-vous</label>
                            <p class="text-sm font-bold text-purple-900">17/10/2025 à 14:00</p>
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-purple-900 uppercase mb-1">Priorité</label>
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-800">
                                URGENTE
                            </span>
                        </div>
                        <div>
                            <label class="block text-xs font-bold text-purple-900 uppercase mb-1">Tarif</label>
                            <p class="text-sm font-bold text-purple-900">300 DH</p>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-purple-900 mb-2">Question posée au spécialiste</label>
                        <div class="bg-white rounded-lg p-4">
                            <p class="text-gray-900">Patient de 40 ans présentant des douleurs thoraciques avec irradiation vers le bras gauche, essoufflement à l'effort. Antécédents familiaux cardiovasculaires + tabagisme. ECG et analyses prescrits. Nécessite avis cardiologique urgent pour éliminer syndrome coronarien aigu et orienter prise en charge.</p>
                        </div>
                    </div>
                    <div class="bg-yellow-100 border border-yellow-400 rounded-lg p-4">
                        <p class="text-sm text-yellow-800 flex items-center">
                            <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            En attente de la réponse du spécialiste
                        </p>
                    </div>
                </div>
            </div>

            <!-- Cost Summary -->
            <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
                <h2 class="text-lg font-bold mb-4">Coût Total de la Consultation</h2>
                <div class="space-y-3">
                    <div class="flex justify-between items-center pb-2">
                        <span class="text-blue-100">Consultation Généraliste</span>
                        <span class="font-bold">150 DH</span>
                    </div>
                    <div class="flex justify-between items-center pb-2">
                        <span class="text-blue-100">Expertise Cardiologue</span>
                        <span class="font-bold">300 DH</span>
                    </div>
                    <div class="flex justify-between items-center pb-2 border-b border-blue-400">
                        <span class="text-blue-100">Actes techniques (ECG + Analyses)</span>
                        <span class="font-bold">200 DH</span>
                    </div>
                    <div class="flex justify-between items-center text-xl pt-2">
                        <span class="font-bold">TOTAL</span>
                        <span class="font-bold">650 DH</span>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="no-print flex items-center justify-between gap-4">
                <a href="${pageContext.request.contextPath}/generaliste/consultations"
                   class="flex-1 bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-3 rounded-lg text-center">
                    Retour à la liste
                </a>
                <button onclick="editConsultation()" class="flex-1 bg-gray-700 hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                    Modifier
                </button>
                <button onclick="completeConsultation()" class="flex-1 bg-green-600 hover:bg-green-700 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    Clôturer la Consultation
                </button>
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

    function editConsultation() {
        alert('Fonction de modification - À implémenter');
    }

    function completeConsultation() {
        if (confirm('Êtes-vous sûr de vouloir clôturer cette consultation ?')) {
            alert('Consultation clôturée avec succès !');
            window.location.href = '${pageContext.request.contextPath}/generaliste/consultations';
        }
    }
</script>
</body>
</html>

