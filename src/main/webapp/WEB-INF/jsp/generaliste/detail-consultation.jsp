<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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

            <a href="${pageContext.request.contextPath}/generaliste/consultations"
               class="bg-gray-100 text-black group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                Consultations
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

<div id="overlay" class="hidden lg:hidden fixed inset-0 bg-black bg-opacity-50 z-30 no-print"></div>

<!-- Main Content -->
<div class="lg:ml-64">
    <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20 no-print">
        <div class="px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-4">
                    <a href="${pageContext.request.contextPath}/generaliste/consultations"
                       class="text-gray-600 hover:text-black">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                        </svg>
                    </a>
                    <h1 class="text-2xl font-bold text-gray-900">Détail de la Consultation</h1>
                </div>
                <div class="flex items-center space-x-3">
                    <button onclick="window.print()" class="bg-white border-2 border-gray-300 hover:bg-gray-50 text-gray-700 font-bold px-4 py-2 rounded-lg flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                        </svg>
                        Imprimer
                    </button>
                </div>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Message d'erreur -->
        <c:if test="${not empty errorMessage}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6 rounded-lg">
                <div class="flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    <span><c:out value="${errorMessage}"/></span>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty consultation}">
            <!-- En-tête de la consultation -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <div class="flex items-center justify-between mb-4">
                    <div class="flex items-center space-x-4">
                        <div class="h-16 w-16 bg-black text-white rounded-full flex items-center justify-center font-bold text-xl">
                            ${patientInitials}
                        </div>
                        <div>
                            <h2 class="text-2xl font-bold text-gray-900">
                                <c:out value="${consultation.patient.nom} ${consultation.patient.prenom}"/>
                            </h2>
                            <p class="text-gray-600">N° Sécurité Sociale: <c:out value="${consultation.patient.numeroSecuriteSociale}"/></p>
                        </div>
                    </div>
                    <div class="text-right">
                        <div class="text-sm text-gray-600 mb-1">Date de consultation</div>
                        <div class="text-lg font-bold text-gray-900">
                            ${dateConsultation}
                        </div>
                        <div class="text-sm text-gray-600">
                            ${timeConsultation}
                        </div>
                    </div>
                </div>

                <!-- Statut -->
                <div class="flex items-center space-x-3">
                    <span class="text-sm font-bold text-gray-700">Statut:</span>
                    <c:choose>
                        <c:when test="${consultation.statut == 'EN_COURS'}">
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-bold bg-yellow-100 text-yellow-800">
                                En cours
                            </span>
                        </c:when>
                        <c:when test="${consultation.statut == 'EN_ATTENTE_AVIS_SPECIALISTE'}">
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-bold bg-purple-100 text-purple-800">
                                En attente d'avis spécialiste
                            </span>
                        </c:when>
                        <c:when test="${consultation.statut == 'TERMINEE'}">
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-bold bg-green-100 text-green-800">
                                Terminée
                            </span>
                        </c:when>
                    </c:choose>
                </div>
            </div>

            <!-- Informations du Patient -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                    Informations Patient
                </h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-1">Date de naissance</label>
                        <p class="text-gray-900">${dateNaissanceFormatted}</p>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-1">Téléphone</label>
                        <p class="text-gray-900"><c:out value="${consultation.patient.telephone}"/></p>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-1">Adresse</label>
                        <p class="text-gray-900"><c:out value="${consultation.patient.adresse}"/></p>
                    </div>
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-1">Statut</label>
                        <p class="text-gray-900"><c:out value="${consultation.patient.statut}"/></p>
                    </div>
                </div>
            </div>

            <!-- Signes Vitaux -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                    </svg>
                    Signes Vitaux
                </h3>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600 mb-1">Tension</div>
                        <div class="text-xl font-bold text-gray-900"><c:out value="${consultation.patient.tensionArterielle}"/></div>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600 mb-1">Fréquence Cardiaque</div>
                        <div class="text-xl font-bold text-gray-900"><c:out value="${consultation.patient.frequenceCardiaque}"/> bpm</div>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600 mb-1">Température</div>
                        <div class="text-xl font-bold text-gray-900"><c:out value="${consultation.patient.temperature}"/>°C</div>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <div class="text-sm text-gray-600 mb-1">Fréquence Respiratoire</div>
                        <div class="text-xl font-bold text-gray-900"><c:out value="${consultation.patient.frequenceRespiratoire}"/> /min</div>
                    </div>
                </div>
            </div>

            <!-- Antécédents et Allergies -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-3">Antécédents Médicaux</h3>
                    <p class="text-gray-700 whitespace-pre-line"><c:out value="${consultation.patient.antecedents}"/></p>
                </div>
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                    <h3 class="text-lg font-bold text-gray-900 mb-3">Allergies</h3>
                    <p class="text-gray-700 whitespace-pre-line"><c:out value="${consultation.patient.allergies}"/></p>
                </div>
            </div>

            <!-- Détails de la Consultation -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Détails de la Consultation
                </h3>

                <div class="space-y-4">
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-2">Motif de consultation</label>
                        <p class="text-gray-900 bg-gray-50 p-4 rounded-lg"><c:out value="${consultation.motif}"/></p>
                    </div>

                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-2">Observations</label>
                        <p class="text-gray-900 bg-gray-50 p-4 rounded-lg whitespace-pre-line"><c:out value="${consultation.observations}"/></p>
                    </div>

                    <c:if test="${not empty consultation.diagnostic}">
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-2">Diagnostic</label>
                        <p class="text-gray-900 bg-green-50 p-4 rounded-lg border-l-4 border-green-500"><c:out value="${consultation.diagnostic}"/></p>
                    </div>
                    </c:if>

                    <c:if test="${not empty consultation.traitement}">
                    <div>
                        <label class="block text-sm font-bold text-gray-700 mb-2">Traitement prescrit</label>
                        <p class="text-gray-900 bg-blue-50 p-4 rounded-lg border-l-4 border-blue-500 whitespace-pre-line"><c:out value="${consultation.traitement}"/></p>
                    </div>
                    </c:if>
                </div>
            </div>

            <!-- Coût de la consultation -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
                <h3 class="text-lg font-bold text-gray-900 mb-4 flex items-center">
                    <svg class="h-6 w-6 mr-2 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    Coût de la Consultation
                </h3>
                <div class="flex items-center justify-between">
                    <div>
                        <div class="text-sm text-gray-600 mb-1">Coût base</div>
                        <div class="text-3xl font-bold text-gray-900"><c:out value="${consultation.coutBase}"/> DH</div>
                    </div>
                    <div class="text-right">
                        <div class="text-sm text-gray-600 mb-1">Type</div>
                        <div class="text-lg font-semibold text-gray-700">Consultation généraliste</div>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="no-print flex items-center space-x-3">
                <c:if test="${consultation.statut == 'EN_COURS'}">
                    <a href="${pageContext.request.contextPath}/generaliste/demander-expertise?consultationId=${consultation.id}"
                       class="bg-purple-600 hover:bg-purple-700 text-white font-bold px-6 py-3 rounded-lg flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        Demander un avis spécialiste
                    </a>

                    <button onclick="cloturer()" class="bg-green-600 hover:bg-green-700 text-white font-bold px-6 py-3 rounded-lg flex items-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Clôturer la consultation
                    </button>
                </c:if>

                <a href="${pageContext.request.contextPath}/generaliste/consultations"
                   class="bg-gray-600 hover:bg-gray-700 text-white font-bold px-6 py-3 rounded-lg flex items-center">
                    <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Retour aux consultations
                </a>
            </div>
        </c:if>

        <c:if test="${empty consultation}">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-12 text-center">
                <svg class="h-16 w-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Consultation introuvable</h3>
                <p class="text-gray-600 mb-6">La consultation demandée n'existe pas ou vous n'y avez pas accès.</p>
                <a href="${pageContext.request.contextPath}/generaliste/consultations"
                   class="inline-block bg-black hover:bg-gray-800 text-white font-bold px-6 py-3 rounded-lg">
                    Retour aux consultations
                </a>
            </div>
        </c:if>
    </main>
</div>

<script>
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('overlay');

    if (mobileMenuBtn) {
        mobileMenuBtn.addEventListener('click', () => {
            sidebar.classList.toggle('-translate-x-full');
            overlay.classList.toggle('hidden');
        });
    }

    if (overlay) {
        overlay.addEventListener('click', () => {
            sidebar.classList.add('-translate-x-full');
            overlay.classList.add('hidden');
        });
    }

    function cloturer() {
        if (confirm('Êtes-vous sûr de vouloir clôturer cette consultation ?')) {
            // TODO: Appeler le servlet pour clôturer la consultation
            alert('Fonctionnalité en cours de développement');
        }
    }
</script>
</body>
</html>
