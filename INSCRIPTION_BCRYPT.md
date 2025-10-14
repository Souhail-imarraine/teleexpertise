# Guide d'Inscription avec BCrypt

## ✅ Modifications effectuées

### 1. Dépendance BCrypt ajoutée
- Ajouté `jbcrypt 0.4` dans `pom.xml`

### 2. Classe PasswordUtil créée
- `hashPassword()` : Hache le mot de passe avec BCrypt (12 rounds)
- `checkPassword()` : Vérifie un mot de passe contre un hash

### 3. AuthService mis à jour
- Le mot de passe est maintenant haché avec BCrypt avant sauvegarde
- Signature corrigée : `register(nom, prenom, email, motDePasse, role)`

### 4. UtilisateurDAO mis à jour
- L'authentification utilise maintenant BCrypt pour vérifier les mots de passe
- Compatible avec les anciens mots de passe en clair ET les nouveaux hashés

### 5. Page register.jsp modernisée
- Utilise JSTL au lieu de scriptlets Java
- Affichage des erreurs avec `<c:if>` et `<c:out>`
- Conservation des valeurs avec `${...}`
- Message indiquant le cryptage BCrypt

## 📋 Comment tester

### Étape 1 : Redémarrer le serveur
1. Dans IntelliJ, arrêtez Tomcat (bouton Stop)
2. IntelliJ va automatiquement télécharger la dépendance BCrypt
3. Redémarrez Tomcat (bouton Run)

### Étape 2 : Accéder à l'inscription
```
http://localhost:8080/teleexpertise/register
```

### Étape 3 : Remplir le formulaire
- **Prénom** : Ahmed
- **Nom** : Bennani
- **Email** : ahmed.bennani@example.com
- **Mot de passe** : password123
- **Confirmation** : password123
- **Rôle** : Médecin Généraliste

### Étape 4 : Vérifier dans la console
Vous devriez voir :
```
✅ Utilisateur enregistré avec mot de passe haché : ahmed.bennani@example.com
✅ Utilisateur sauvegardé avec succès dans la BD
✅ Inscription réussie pour : ahmed.bennani@example.com
```

### Étape 5 : Vérifier dans la base de données
```sql
SELECT email, motDePasse FROM utilisateur WHERE email = 'ahmed.bennani@example.com';
```

Le mot de passe sera haché et ressemblera à :
```
$2a$12$KIXQwH8Vq3jZ9X5h4YnZ3OqGY7L8Qw9X5h4YnZ3OqGY7L8Qw9X5h4Y
```

### Étape 6 : Tester la connexion
1. Retournez sur `http://localhost:8080/teleexpertise/`
2. Connectez-vous avec :
   - **Email** : ahmed.bennani@example.com
   - **Mot de passe** : password123

## 🔐 Sécurité BCrypt

### Avantages
- ✅ **Salt automatique** : Chaque hash est unique
- ✅ **Lent par design** : Protège contre le brute-force
- ✅ **Évolutif** : Le nombre de rounds peut être augmenté
- ✅ **Standard industriel** : Utilisé par les grandes entreprises

### Format du hash
```
$2a$12$KIXQwH8Vq3jZ9X5h4YnZ3OqGY7L8Qw9X5h4YnZ3OqGY7L8Qw9X5h4Y
 |  |  |                                                        |
 |  |  |                                                        +-- Hash (31 chars)
 |  |  +-- Salt (22 chars)
 |  +-- Cost factor (nombre de rounds : 2^12 = 4096 itérations)
 +-- Algorithme (2a = BCrypt)
```

## 🎯 Points clés

1. **Mot de passe en clair** : Jamais stocké, seulement utilisé temporairement
2. **Hachage** : Fait dans `AuthService.register()` avec `PasswordUtil.hashPassword()`
3. **Vérification** : Fait dans `UtilisateurDAO.authenticate()` avec `PasswordUtil.checkPassword()`
4. **JSTL** : Utilisé dans `register.jsp` pour un code plus propre et sécurisé

## 🚨 Tests de validation

### Test 1 : Mots de passe différents
- **Mot de passe** : test123
- **Confirmation** : test456
- **Résultat attendu** : "Les mots de passe ne correspondent pas"

### Test 2 : Email invalide
- **Email** : testexample.com (sans @)
- **Résultat attendu** : "Email invalide"

### Test 3 : Email déjà utilisé
- Créer un compte avec un email
- Essayer de créer un autre compte avec le même email
- **Résultat attendu** : "Email déjà utilisé"

### Test 4 : Mot de passe trop court
- **Mot de passe** : test
- **Résultat attendu** : "Le mot de passe doit contenir au moins 6 caractères"

## 📊 Structure JSTL utilisée

```jsp
<!-- Condition -->
<c:if test="${not empty error}">
    <c:out value="${error}"/>
</c:if>

<!-- Valeur avec fallback -->
value="${not empty prenom ? prenom : ''}"

<!-- Sélection conditionnelle -->
<option value="GENERALISTE" ${role == 'GENERALISTE' ? 'selected' : ''}>
```

## 💡 Conseils

1. **Pour réinitialiser un mot de passe** : Exécuter en SQL
```sql
UPDATE utilisateur 
SET motDePasse = '$2a$12$...' 
WHERE email = 'user@example.com';
```

2. **Pour vérifier un hash BCrypt** : Utiliser un outil en ligne comme bcrypt-generator.com

3. **Pour augmenter la sécurité** : Modifier `BCRYPT_ROUNDS` dans `PasswordUtil.java` (12-14 recommandé)

