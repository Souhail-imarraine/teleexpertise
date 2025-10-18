<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Patients en Attente - Télé-Expertise</title>
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
                    <h1 class="text-2xl font-bold text-gray-900">👥 Patients en Attente</h1>
                    <p class="text-sm text-gray-600 mt-1">File d'attente des consultations</p>
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
        <!-- Filters -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="block text-sm font-bold text-gray-900 mb-2">Rechercher</label>
                    <input type="text" id="searchInput" placeholder="Nom, prénom, N° sécurité sociale..."
                           class="w-full px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-black">
                </div>
                <div class="flex items-end">
                    <button onclick="refreshList()" class="w-full bg-black hover:bg-gray-800 text-white font-bold px-6 py-2 rounded-lg flex items-center justify-center">
                        <svg class="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                        Actualiser
                    </button>
                </div>
            </div>
        </div>
        <!-- Patients List -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-gray-900 to-black">
                <h3 class="text-lg font-bold text-white flex items-center">
                    <svg class="h-6 w-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    Liste des Patients (${totalEnAttente != null ? totalEnAttente : 0} patient)
                </h3>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Position</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Patient</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Heure d'Arrivée</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Signes Vitaux</th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-900 uppercase">Temps d'Attente</th>
                            <th class="px-6 py-4 text-right text-xs font-bold text-gray-900 uppercase">Action</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <!-- Afficher les patients réels avec JSTL -->
                        <c:choose>
                            <c:when test="${empty patients}">
                                <!-- Si aucun patient -->
                                <tr>
                                    <td colspan="6" class="px-6 py-12 text-center">
                                        <div class="flex flex-col items-center justify-center">
                                            <svg class="h-16 w-16 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                                            </svg>
                                            <p class="text-lg font-semibold text-gray-900">Aucun patient en attente</p>
                                            <p class="text-sm text-gray-500 mt-1">La file d'attente est vide pour le moment</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <!-- Afficher chaque patient -->
                                <c:forEach var="patient" items="${patients}" varStatus="status">
                                    <tr class="hover:bg-gray-50">
                                        <!-- Position -->
                                        <td class="px-6 py-4">
                                            <span class="inline-flex items-center justify-center h-8 w-8 rounded-full bg-yellow-100 text-yellow-800 font-bold text-sm">
                                                ${status.index + 1}
                                            </span>
                                        </td>

                                        <!-- Patient Info -->
                                        <td class="px-6 py-4">
                                            <div class="flex items-center">
                                                <!-- Initiales du patient -->
                                                <div class="h-10 w-10 bg-black text-white rounded-full flex items-center justify-center font-bold">
                                                    ${patient.nom.substring(0,1)}${patient.prenom.substring(0,1)}
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-bold text-gray-900">
                                                        <c:out value="${patient.nom}"/> <c:out value="${patient.prenom}"/>
                                                    </div>
                                                    <div class="text-xs text-gray-500">
                                                        N° <c:out value="${patient.numeroSecuriteSociale}"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Heure d'arrivée -->
                                        <td class="px-6 py-4">
                                            <div class="flex items-center text-sm">
                                                <svg class="h-4 w-4 text-gray-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                <span class="font-semibold text-gray-900">
                                                    <c:choose>
                                                        <c:when test="${patient.heureArrivee != null}">
                                                            ${patient.heureArrivee.toLocalTime().toString().substring(0,5)}
                                                        </c:when>
                                                        <c:otherwise>--:--</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </td>

                                        <!-- Signes vitaux -->
                                        <td class="px-6 py-4">
                                            <div class="text-xs space-y-1">
                                                <div>
                                                    <span class="font-bold">TA:</span>
                                                    <c:out value="${patient.tensionArterielle != null ? patient.tensionArterielle : 'N/A'}"/>
                                                </div>
                                                <div>
                                                    <span class="font-bold">T°:</span>
                                                    <c:out value="${patient.temperature != null ? patient.temperature : 'N/A'}"/>°C
                                                </div>
                                                <div>
                                                    <span class="font-bold">FC:</span>
                                                    <c:out value="${patient.frequenceCardiaque != null ? patient.frequenceCardiaque : 'N/A'}"/> bpm
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Temps d'attente (approximatif) -->
                                        <td class="px-6 py-4">
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-yellow-100 text-yellow-800">
                                                En attente
                                            </span>
                                        </td>

                                        <!-- Action -->
                                        <td class="px-6 py-4 text-right">
                                            <a href="${pageContext.request.contextPath}/generaliste/nouvelle-consultation?patientId=${patient.id}"
                                               class="inline-block bg-black hover:bg-gray-800 text-white font-bold px-4 py-2 rounded-lg text-sm">
                                                Consulter
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
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

    function refreshList() {
        window.location.reload();
    }

    // ========================================
    // 🔍 RECHERCHE EN TEMPS RÉEL
    // ========================================

    const searchInput = document.getElementById('searchInput');
    const tableBody = document.querySelector('tbody');
    const allRows = Array.from(tableBody.querySelectorAll('tr'));

    // Fonction de recherche
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase().trim();

        // Si la recherche est vide, afficher tous les patients
        if (searchTerm === '') {
            allRows.forEach(row => {
                row.style.display = '';
            });
            updatePatientCount();
            return;
        }

        let visibleCount = 0;

        // Parcourir chaque ligne du tableau
        allRows.forEach(row => {
            // Récupérer le texte de la ligne (nom, prénom, numéro SS)
            const rowText = row.textContent.toLowerCase();

            // Vérifier si le texte contient le terme recherché
            if (rowText.includes(searchTerm)) {
                row.style.display = ''; // Afficher la ligne
                visibleCount++;

                // Mettre à jour la position
                const positionBadge = row.querySelector('td:first-child span');
                if (positionBadge) {
                    positionBadge.textContent = visibleCount;
                }
            } else {
                row.style.display = 'none'; // Cacher la ligne
            }
        });

        // Afficher un message si aucun résultat
        if (visibleCount === 0) {
            showNoResults();
        } else {
            hideNoResults();
        }

        updatePatientCount();
    });

    // Fonction pour afficher "Aucun résultat"
    function showNoResults() {
        hideNoResults(); // D'abord supprimer l'ancien message

        const noResultRow = document.createElement('tr');
        noResultRow.id = 'no-result-row';
        noResultRow.innerHTML = `
            <td colspan="6" class="px-6 py-12 text-center">
                <div class="flex flex-col items-center justify-center">
                    <svg class="h-16 w-16 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                    </svg>
                    <p class="text-lg font-semibold text-gray-900">Aucun résultat trouvé</p>
                    <p class="text-sm text-gray-500 mt-1">Essayez avec un autre nom, prénom ou numéro</p>
                </div>
            </td>
        `;
        tableBody.appendChild(noResultRow);
    }

    // Fonction pour cacher "Aucun résultat"
    function hideNoResults() {
        const existingNoResult = document.getElementById('no-result-row');
        if (existingNoResult) {
            existingNoResult.remove();
        }
    }

    // Fonction pour mettre à jour le compteur
    function updatePatientCount() {
        const visibleRows = allRows.filter(row => row.style.display !== 'none');
        const countElement = document.querySelector('.text-lg.font-bold.text-white');
        if (countElement) {
            const iconSvg = countElement.querySelector('svg').outerHTML;
            const count = visibleRows.length;
            const plural = count > 1 ? 's' : '';
            countElement.innerHTML = iconSvg + ` Liste des Patients (${count} patient${plural})`;
        }
    }

    // Ajouter un indicateur visuel sur le champ de recherche
    searchInput.addEventListener('focus', function() {
        this.parentElement.querySelector('label').classList.add('text-black');
    });

    searchInput.addEventListener('blur', function() {
        if (this.value === '') {
            this.parentElement.querySelector('label').classList.remove('text-black');
        }
    });
</script>
</body>
</html>
