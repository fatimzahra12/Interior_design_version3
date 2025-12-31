# 🏠 Interior Design AI

Une application mobile Flutter avec IA pour la classification et la transformation de pièces d'intérieur.

## ✨ Fonctionnalités

- 🔐 **Authentification complète** : Inscription, connexion, gestion de profil
- 📸 **Classification de pièces** : Identifiez automatiquement le type de pièce (chambre, salon, cuisine, etc.)
- 🎨 **Transformation AI** : Transformez vos pièces avec différents styles de design
- 📷 **Support caméra** : Prenez des photos directement depuis l'app
- 🌐 **Backend FastAPI** : API REST robuste avec modèle de deep learning

## 🛠️ Technologies utilisées

### Frontend (Flutter)
- **Framework** : Flutter 3.x
- **Langage** : Dart
- **Architecture** : Clean Architecture
- **State Management** : Provider / Riverpod
- **Design** : Material Design avec thème personnalisé

### Backend (Python)
- **Framework** : FastAPI
- **ML/AI** : TensorFlow / PyTorch
- **Base de données** : SQLite
- **Authentification** : JWT (JSON Web Tokens)
- **Hash de mots de passe** : Bcrypt

## 📋 Prérequis

### Pour le Frontend
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- Émulateur Android ou appareil physique

### Pour le Backend
- Python 3.10+
- pip (gestionnaire de packages Python)

## 🚀 Installation

### 1. Cloner le repository

```bash
git clone https://github.com/VOTRE_USERNAME/interior_design.git
cd interior_design
```

### 2. Configuration du Backend

```bash
# Aller dans le dossier backend
cd backend_api

# Créer un environnement virtuel
python -m venv venv

# Activer l'environnement virtuel
# Windows :
venv\Scripts\activate
# Mac/Linux :
source venv/bin/activate

# Installer les dépendances
pip install -r requirements.txt

# Initialiser la base de données
python init_db.py

# Lancer le serveur
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Le backend sera accessible sur `http://localhost:8000`

### 3. Configuration du Frontend

```bash
# Retour au dossier racine
cd ..

# Installer les dépendances Flutter
flutter pub get

# Lancer l'application
flutter run
```

## 📱 Utilisation

1. **Inscription** : Créez un compte avec email, nom d'utilisateur et mot de passe
2. **Connexion** : Connectez-vous avec vos identifiants
3. **Classification** :
   - Prenez une photo ou choisissez depuis la galerie
   - Cliquez sur "Classify Room with AI"
   - Obtenez le type de pièce et le niveau de confiance
4. **Transformation** : (À venir) Transformez votre pièce avec différents styles

## 🏗️ Structure du projet

```
interior_design/
├── lib/                          # Code source Flutter
│   ├── core/                     # Fonctionnalités communes
│   │   ├── config/              # Configuration (API, thème)
│   │   ├── services/            # Services (API, auth)
│   │   └── widgets/             # Widgets réutilisables
│   ├── features/                # Fonctionnalités principales
│   │   ├── auth/                # Authentification
│   │   ├── home/                # Page d'accueil
│   │   ├── upload/              # Classification de pièces
│   │   └── transform/           # Transformation (à venir)
│   └── main.dart                # Point d'entrée
│
├── backend_api/                  # Backend FastAPI
│   ├── main.py                  # Application principale
│   ├── auth.py                  # Logique d'authentification
│   ├── database.py              # Configuration BDD
│   ├── models.py                # Modèles de données
│   ├── requirements.txt         # Dépendances Python
│   └── models/                  # Modèles ML (non inclus)
│
├── android/                      # Configuration Android
├── ios/                          # Configuration iOS
└── README.md                     # Ce fichier
```

## 🔧 Configuration

### Variables d'environnement

Créez un fichier `.env` dans `backend_api/` :

```env
SECRET_KEY=your_secret_key_here
DATABASE_URL=sqlite:///./interior_design.db
```

### Configuration de l'API dans Flutter

Modifiez `lib/core/config/api_config.dart` selon votre environnement :

```dart
static const String baseUrl = kIsWeb 
    ? 'http://localhost:8000'      // Pour web
    : 'http://10.0.2.2:8000';      // Pour émulateur Android
```

## 🐛 Dépannage

### Problème : "Impossible de se connecter au serveur"
- Vérifiez que le backend est lancé sur `http://localhost:8000`
- Sur émulateur Android, utilisez `10.0.2.2:8000` au lieu de `localhost:8000`
- Vérifiez les paramètres CORS dans `backend_api/main.py`

### Problème : Erreur bcrypt
```bash
pip uninstall -y bcrypt passlib
pip install bcrypt==4.1.2 passlib==1.7.4
```

### Problème : Base de données corrompue
```bash
cd backend_api
del interior_design.db  # Windows
# ou
rm interior_design.db   # Mac/Linux
python init_db.py
```

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez une branche (`git checkout -b feature/amelioration`)
3. Committez vos changements (`git commit -m 'Ajout fonctionnalité'`)
4. Push vers la branche (`git push origin feature/amelioration`)
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 👥 Auteurs

- **BABA ABHANI ELHADI** - Développeur principal

## 📞 Contact

Pour toute question ou suggestion, contactez-nous à : [votre.email@example.com]

## 🎯 Roadmap

- [x] Authentification utilisateur
- [x] Classification de pièces
- [x] Support caméra
- [ ] Transformation de pièces avec AI
- [ ] Galerie de designs
- [ ] Partage sur réseaux sociaux
- [ ] Mode hors ligne
- [ ] Application iOS

---

⭐ Si ce projet vous plaît, n'hésitez pas à lui donner une étoile sur GitHub !
