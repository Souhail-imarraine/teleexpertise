<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Demander un Avis Spécialiste - Télé-Expertise</title>
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

            <a href="${pageContext.request.contextPath}/generaliste/consultations"
               class="text-gray-700 hover:text-black hover:bg-gray-100 group flex items-center px-3 py-2.5 text-sm font-medium rounded-lg">
                <svg class="text-gray-400 group-hover:text-black mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
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

<div id="overlay" class="hidden lg:hidden fixed inset-0 bg-black bg-opacity-50 z-30"></div>

<!-- Main Content -->
<div class="lg:ml-64">
    <header class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-20">
        <div class="px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-4">
                    <a href="${pageContext.request.contextPath}/generaliste/consultations"
                       class="text-gray-600 hover:text-black">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                        </svg>
                    </a>
                    <h1 class="text-2xl font-bold text-gray-900">Demander un Avis Spécialiste</h1>
                </div>
            </div>
        </div>
    </header>

    <main class="p-4 sm:p-6 lg:p-8">
        <!-- Messages -->
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

        <c:if test="${not empty consultation}">
            <!-- Info Consultation -->
            <div class="bg-gradient-to-r from-purple-600 to-purple-800 rounded-xl shadow-lg p-6 mb-6 text-white">
                <div class="flex items-center justify-between">
                    <div class="flex items-center space-x-4">
                        <div class="h-16 w-16 bg-white text-purple-800 rounded-full flex items-center justify-center font-bold text-xl">
                            ${patientInitials}
                        </div>
                        <div>
                            <h2 class="text-2xl font-bold">
                                <c:out value="${consultation.patient.nom} ${consultation.patient.prenom}"/>
                            </h2>
                            <p class="text-purple-100 mt-1">
                                Consultation du ${dateConsultation} à ${timeConsultation}
                            </p>
                        </div>
                    </div>
                    <div class="text-right">
                        <div class="text-sm font-semibold text-purple-200">Motif</div>
                        <div class="text-lg font-bold"><c:out value="${consultation.motif}"/></div>
                    </div>
                </div>
            </div>

            <!-- Formulaire -->
            <form method="post" action="${pageContext.request.contextPath}/generaliste/demander-expertise" id="expertiseForm">
                <input type="hidden" name="consultationId" value="${consultationId}">

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <!-- Colonne gauche : Sélection -->
                    <div class="lg:col-span-1 space-y-6">
                        <!-- Étape 1 : Spécialité -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <div class="flex items-center mb-4">
                                <div class="bg-black text-white rounded-full h-8 w-8 flex items-center justify-center font-bold text-sm mr-3">1</div>
                                <h3 class="text-lg font-bold text-gray-900">Choisir la Spécialité</h3>
                            </div>
                            <select id="specialite" name="specialite" required
                                    class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                                <option value="">-- Sélectionner --</option>
                                <c:forEach var="spec" items="${specialites}">
                                    <option value="${spec}">${spec}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Étape 2 : Spécialiste -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <div class="flex items-center mb-4">
                                <div class="bg-black text-white rounded-full h-8 w-8 flex items-center justify-center font-bold text-sm mr-3">2</div>
                                <h3 class="text-lg font-bold text-gray-900">Choisir le Spécialiste</h3>
                            </div>
                            <div id="specialistes-container">
                                <p class="text-sm text-gray-500 italic">Veuillez d'abord sélectionner une spécialité</p>
                            </div>
                        </div>

                        <!-- Étape 3 : Créneau -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <div class="flex items-center mb-4">
                                <div class="bg-black text-white rounded-full h-8 w-8 flex items-center justify-center font-bold text-sm mr-3">3</div>
                                <h3 class="text-lg font-bold text-gray-900">Choisir un Créneau</h3>
                            </div>
                            <div id="creneaux-container">
                                <p class="text-sm text-gray-500 italic">Veuillez d'abord sélectionner un spécialiste</p>
                            </div>
                        </div>
                    </div>

                    <!-- Colonne droite : Détails -->
                    <div class="lg:col-span-2 space-y-6">
                        <!-- Priorité et Mode -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <h3 class="text-lg font-bold text-gray-900 mb-4">Détails de la Demande</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-2">
                                        Priorité <span class="text-red-500">*</span>
                                    </label>
                                    <select name="priorite" required
                                            class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                                        <option value="">-- Sélectionner --</option>
                                        <option value="URGENTE">🔴 Urgente</option>
                                        <option value="NORMALE" selected>🟡 Normale</option>
                                        <option value="NON_URGENTE">🟢 Non urgente</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-bold text-gray-700 mb-2">
                                        Mode d'Expertise
                                    </label>
                                    <select name="modeExpertise"
                                            class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">
                                        <option value="">-- Sélectionner --</option>
                                        <option value="SYNCHRONE">📞 Synchrone (Temps réel)</option>
                                        <option value="ASYNCHRONE" selected>📧 Asynchrone (Différé)</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Question -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <label class="block text-sm font-bold text-gray-700 mb-2">
                                Question au Spécialiste <span class="text-red-500">*</span>
                            </label>
                            <textarea name="question" rows="5" required placeholder="Décrivez la raison de votre demande d'avis..."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium resize-none"></textarea>
                            <p class="text-xs text-gray-500 mt-2">Soyez précis dans votre question pour obtenir un avis pertinent</p>
                        </div>

                        <!-- Données et Analyses -->
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
                            <label class="block text-sm font-bold text-gray-700 mb-2">
                                Données et Analyses Complémentaires
                            </label>
                            <textarea name="donneesAnalyses" rows="4" placeholder="Résultats d'examens, analyses biologiques, imagerie, etc."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium resize-none"></textarea>
                            <p class="text-xs text-gray-500 mt-2">Ajoutez toute information médicale pertinente (optionnel)</p>
                        </div>

                        <!-- Actions -->
                        <div class="flex items-center justify-end space-x-3">
                            <a href="${pageContext.request.contextPath}/generaliste/consultations"
                               class="bg-gray-200 hover:bg-gray-300 text-gray-900 font-bold px-6 py-3 rounded-lg">
                                Annuler
                            </a>
                            <button type="submit"
                                    class="bg-purple-600 hover:bg-purple-700 text-white font-bold px-8 py-3 rounded-lg flex items-center">
                                <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
                                </svg>
                                Envoyer la Demande
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>

        <c:if test="${empty consultation}">
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-12 text-center">
                <svg class="h-16 w-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Consultation introuvable</h3>
                <p class="text-gray-600 mb-6">Impossible de charger les informations de la consultation.</p>
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

    // Gestion de la sélection de spécialité
    const specialiteSelect = document.getElementById('specialite');
    if (specialiteSelect) {
        specialiteSelect.addEventListener('change', function() {
            const specialite = this.value;
            if (!specialite) {
                document.getElementById('specialistes-container').innerHTML =
                    '<p class="text-sm text-gray-500 italic">Veuillez d\'abord sélectionner une spécialité</p>';
                document.getElementById('creneaux-container').innerHTML =
                    '<p class="text-sm text-gray-500 italic">Veuillez d\'abord sélectionner un spécialiste</p>';
                return;
            }

            // Charger les spécialistes
            fetch('${pageContext.request.contextPath}/api/specialistes?specialite=' + specialite)
                .then(response => response.json())
                .then(data => {
                    if (data.length === 0) {
                        document.getElementById('specialistes-container').innerHTML =
                            '<p class="text-sm text-red-500">Aucun spécialiste disponible pour cette spécialité</p>';
                        return;
                    }

                    let html = '<select id="specialiste" name="specialiste" required class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg hover:border-gray-400 focus:border-black text-gray-900 font-medium">';
                    html += '<option value="">-- Sélectionner --</option>';
                    data.forEach(spec => {
                        html += `<option value="${spec.id}">Dr. ${spec.nom} ${spec.prenom} - ${spec.tarif} DH</option>`;
                    });
                    html += '</select>';

                    document.getElementById('specialistes-container').innerHTML = html;

                    // Ajouter un listener pour le changement de spécialiste
                    document.getElementById('specialiste').addEventListener('change', chargerCreneaux);
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    document.getElementById('specialistes-container').innerHTML =
                        '<p class="text-sm text-red-500">Erreur lors du chargement des spécialistes</p>';
                });
        });
    }

    function chargerCreneaux() {
        const specialisteId = document.getElementById('specialiste').value;
        if (!specialisteId) {
            document.getElementById('creneaux-container').innerHTML =
                '<p class="text-sm text-gray-500 italic">Veuillez d\'abord sélectionner un spécialiste</p>';
            return;
        }

        // Charger les créneaux
        fetch('${pageContext.request.contextPath}/api/creneaux?specialisteId=' + specialisteId)
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    document.getElementById('creneaux-container').innerHTML =
                        '<p class="text-sm text-red-500">Aucun créneau disponible pour ce spécialiste</p>';
                    return;
                }

                let html = '<div class="space-y-2">';
                data.forEach(creneau => {
                    html += `
                        <label class="flex items-center p-3 border-2 border-gray-300 rounded-lg hover:border-black cursor-pointer">
                            <input type="radio" name="creneau" value="${creneau.id}" required class="mr-3">
                            <div class="flex-1">
                                <div class="text-sm font-bold text-gray-900">${creneau.dateDebut}</div>
                                <div class="text-xs text-gray-500">${creneau.duree} minutes</div>
                            </div>
                            <span class="inline-flex items-center px-2 py-1 rounded text-xs font-bold bg-green-100 text-green-800">
                                Disponible
                            </span>
                        </label>
                    `;
                });
                html += '</div>';

                document.getElementById('creneaux-container').innerHTML = html;
            })
            .catch(error => {
                console.error('Erreur:', error);
                document.getElementById('creneaux-container').innerHTML =
                    '<p class="text-sm text-red-500">Erreur lors du chargement des créneaux</p>';
            });
    }
</script>
</body>
</html>

