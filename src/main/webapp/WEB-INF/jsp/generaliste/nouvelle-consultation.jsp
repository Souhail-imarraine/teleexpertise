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
                    <h1 class="text-2xl font-bold text-gray-900">Nouvelle Consultation</h1>
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
                        <h2 class="text-lg font-bold text-gray-900">Patient Sélectionné</h2>
                        <p class="text-sm text-gray-600">Informations du patient pour la consultation</p>
                    </div>
                </div>

                <!-- Afficher les infos du patient avec JSTL -->
                <c:choose>
                    <c:when test="${not empty patient}">
                        <!-- Patient trouvé - Afficher ses informations -->
                        <div class="bg-green-50 border-2 border-green-500 rounded-lg p-6">
                            <div class="flex items-start">
                                <svg class="h-6 w-6 text-green-600 mr-3 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <div class="flex-1">
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">Nom Complet</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.nom}"/> <c:out value="${patient.prenom}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">Date de Naissance</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.dateNaissance != null ? patient.dateNaissance : 'N/A'}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">N° Sécurité Sociale</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.numeroSecuriteSociale}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">Téléphone</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.telephone != null ? patient.telephone : 'N/A'}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">Tension Artérielle</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.tensionArterielle != null ? patient.tensionArterielle : 'N/A'}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs font-bold text-gray-500 uppercase mb-1">Température</div>
                                            <div class="text-sm font-bold text-gray-900">
                                                <c:out value="${patient.temperature != null ? patient.temperature : 'N/A'}"/>°C
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Champ caché pour envoyer l'ID du patient -->
                        <input type="hidden" name="patientId" value="${patient.id}" />
                    </c:when>
                    <c:otherwise>
                        <!-- Aucun patient sélectionné -->
                        <div class="bg-red-50 border-2 border-red-300 rounded-lg p-6 text-center">
                            <svg class="h-12 w-12 text-red-400 mx-auto mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                            </svg>
                            <p class="text-sm font-bold text-red-900">Aucun patient sélectionné</p>
                            <p class="text-xs text-red-700 mt-1">Veuillez retourner à la liste des patients et sélectionner un patient</p>
                            <a href="${pageContext.request.contextPath}/generaliste/patients"
                               class="inline-block mt-4 bg-red-600 hover:bg-red-700 text-white font-bold px-6 py-2 rounded-lg">
                                Retour aux patients
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Step 2: Consultation Form -->
            <form id="consultationForm" action="${pageContext.request.contextPath}/generaliste/nouvelle-consultation" method="POST" class="space-y-6">
                <!-- Inclure l'ID du patient dans le formulaire -->
                <c:if test="${not empty patient}">
                    <input type="hidden" name="patientId" value="${patient.id}" />
                </c:if>

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
                    <a href="${pageContext.request.contextPath}/generaliste/patients"
                       class="flex-1 bg-white hover:bg-gray-50 border-2 border-gray-300 text-gray-900 font-bold px-6 py-3 rounded-lg text-center">
                        Annuler
                    </a>
                    <button type="submit" <c:if test="${empty patient}">disabled</c:if>
                            class="flex-1 bg-black hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg flex items-center justify-center <c:if test='${empty patient}'>opacity-50 cursor-not-allowed</c:if>">
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

