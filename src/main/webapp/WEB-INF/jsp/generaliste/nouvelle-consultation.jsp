<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Nouvelle Consultation - Télé-Expertise</title>
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
               class="bg-black text-white group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-white mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                Mes Consultations
            </a>

            <a href="${pageContext.request.contextPath}/generaliste/expertises"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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
                    <h1 class="text-2xl font-bold text-gray-900">📋 Nouvelle Consultation</h1>
                    <p class="text-sm text-gray-600 mt-1">Créer une consultation pour un patient</p>
                </div>
                <a href="${pageContext.request.contextPath}/generaliste/dashboard"
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
            <!-- Step 1: Select Patient -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <div class="flex items-center mb-6">
                    <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">1</div>
                    <div>
                        <h2 class="text-lg font-bold text-gray-900">Sélectionner un Patient</h2>
                        <p class="text-sm text-gray-600">Recherchez et sélectionnez le patient</p>
                    </div>
                </div>

                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-bold text-gray-900 mb-2">Rechercher un patient</label>
                        <input type="text" id="patientSearch" placeholder="Nom, prénom ou N° sécurité sociale..."
                               class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black">
                    </div>

                    <!-- Patient Selection Results -->
                    <div id="patientResults" class="hidden">
                        <div class="border-2 border-gray-200 rounded-lg divide-y divide-gray-200">
                            <div class="p-4 hover:bg-gray-50 cursor-pointer" onclick="selectPatient(1)">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center">
                                        <div class="h-12 w-12 bg-black text-white rounded-full flex items-center justify-center font-bold">MA</div>
                                        <div class="ml-4">
                                            <div class="text-sm font-bold text-gray-900">Mohammed ALAMI</div>
                                            <div class="text-xs text-gray-500">N° 1234567890123 | Né le 15/03/1985</div>
                                        </div>
                                    </div>
                                    <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Selected Patient Display -->
                    <div id="selectedPatient" class="hidden">
                        <div class="bg-gray-50 border-2 border-green-500 rounded-lg p-4">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center">
                                    <svg class="h-6 w-6 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                    </svg>
                                    <div>
                                        <div class="text-sm font-bold text-gray-900">Patient sélectionné: <span id="patientName">Mohammed ALAMI</span></div>
                                        <div class="text-xs text-gray-500">N° <span id="patientNSS">1234567890123</span></div>
                                    </div>
                                </div>
                                <button onclick="clearPatient()" class="text-red-600 hover:text-red-800 font-bold text-sm">
                                    Changer
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Step 2: Consultation Form -->
            <form id="consultationForm" class="space-y-6">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">2</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Informations de la Consultation</h2>
                            <p class="text-sm text-gray-600">Remplissez les détails de la consultation</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Motif de Consultation <span class="text-red-600">*</span>
                            </label>
                            <input type="text" name="motif" required
                                   placeholder="Ex: Douleurs abdominales, Fièvre, Fatigue..."
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black">
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Symptômes <span class="text-red-600">*</span>
                            </label>
                            <textarea name="symptomes" rows="4" required
                                      placeholder="Décrivez les symptômes du patient..."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black"></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Examen Clinique
                            </label>
                            <textarea name="examen" rows="4"
                                      placeholder="Notes de l'examen physique (inspection, palpation, auscultation...)..."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black"></textarea>
                        </div>

                        <div class="md:col-span-2">
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Observations Générales
                            </label>
                            <textarea name="observations" rows="4"
                                      placeholder="Autres observations médicales..."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black"></textarea>
                        </div>
                    </div>
                </div>

                <!-- Step 3: Diagnostic & Treatment (Optional) -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">3</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Diagnostic et Traitement (Optionnel)</h2>
                            <p class="text-sm text-gray-600">Vous pouvez compléter ces informations plus tard</p>
                        </div>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Diagnostic
                            </label>
                            <input type="text" name="diagnostic"
                                   placeholder="Maladie ou condition identifiée..."
                                   class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black">
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-900 mb-2">
                                Prescription / Traitement
                            </label>
                            <textarea name="traitement" rows="6"
                                      placeholder="Liste des médicaments prescrits avec posologie&#10;Ex:&#10;- Paracétamol 1g, 3 fois/jour pendant 5 jours&#10;- Amoxicilline 500mg, 2 fois/jour pendant 7 jours"
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-black"></textarea>
                        </div>
                    </div>
                </div>

                <!-- Step 4: Medical Acts -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <div class="flex items-center mb-6">
                        <div class="bg-black text-white rounded-full h-10 w-10 flex items-center justify-center font-bold mr-4">4</div>
                        <div>
                            <h2 class="text-lg font-bold text-gray-900">Actes Techniques Médicaux (Optionnel)</h2>
                            <p class="text-sm text-gray-600">Sélectionnez les actes à réaliser</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="RADIOGRAPHIE" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Radiographie</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="ECHOGRAPHIE" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Échographie</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="IRM" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">IRM</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="ECG" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Électrocardiogramme (ECG)</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="ANALYSE_SANG" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Analyse de sang</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="ANALYSE_URINE" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Analyse d'urine</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="FOND_OEIL" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Fond d'œil</span>
                        </label>

                        <label class="flex items-center p-4 border-2 border-gray-300 rounded-lg hover:bg-gray-50 cursor-pointer">
                            <input type="checkbox" name="actes" value="LASER" class="h-5 w-5 text-black border-gray-300 rounded">
                            <span class="ml-3 text-sm font-medium text-gray-900">Dermatologique (Laser)</span>
                        </label>
                    </div>
                </div>

                <!-- Cost Summary -->
                <div class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-sm font-semibold text-blue-100 uppercase">Coût de la Consultation</p>
                            <p class="text-4xl font-bold mt-2">150 DH</p>
                            <p class="text-xs text-blue-100 mt-1">Tarif fixe généraliste</p>
                        </div>
                        <div class="bg-white/20 p-4 rounded-lg">
                            <svg class="h-12 w-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>

                <!-- Actions -->
                <div class="flex items-center justify-between gap-4">
                    <a href="${pageContext.request.contextPath}/generaliste/dashboard"
                       class="flex-1 bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-3 rounded-lg text-center">
                        Annuler
                    </a>
                    <button type="button" onclick="saveDraft()"
                            class="flex-1 bg-gray-700 hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3 3m0 0l-3-3m3 3V4"/>
                        </svg>
                        Sauvegarder Brouillon
                    </button>
                    <button type="submit"
                            class="flex-1 bg-black hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Créer la Consultation
                    </button>
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

    // Patient search simulation
    const patientSearch = document.getElementById('patientSearch');
    patientSearch.addEventListener('input', (e) => {
        if (e.target.value.length > 2) {
            document.getElementById('patientResults').classList.remove('hidden');
        } else {
            document.getElementById('patientResults').classList.add('hidden');
        }
    });

    function selectPatient(id) {
        document.getElementById('patientResults').classList.add('hidden');
        document.getElementById('selectedPatient').classList.remove('hidden');
    }

    function clearPatient() {
        document.getElementById('selectedPatient').classList.add('hidden');
        document.getElementById('patientSearch').value = '';
    }

    function saveDraft() {
        alert('Consultation sauvegardée en brouillon');
    }

    document.getElementById('consultationForm').addEventListener('submit', (e) => {
        e.preventDefault();
        if (confirm('Êtes-vous sûr de vouloir créer cette consultation ?')) {
            alert('Consultation créée avec succès !');
            window.location.href = '${pageContext.request.contextPath}/generaliste/dashboard';
        }
    });
</script>
</body>
</html>

