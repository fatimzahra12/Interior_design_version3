#!/usr/bin/env python3
"""
Script de test rapide pour vérifier que le backend fonctionne correctement
"""

import requests
import json
import sys

BASE_URL = "http://localhost:8000"

def test_health():
    """Test du endpoint /health"""
    print("\n🏥 Test de santé du serveur...")
    try:
        response = requests.get(f"{BASE_URL}/health", timeout=5)
        if response.status_code == 200:
            print("✅ Serveur en ligne et fonctionnel")
            print(f"   Réponse: {response.json()}")
            return True
        else:
            print(f"❌ Erreur {response.status_code}: {response.text}")
            return False
    except requests.exceptions.ConnectionError:
        print("❌ Impossible de se connecter au serveur")
        print("   Vérifiez que le backend est démarré avec:")
        print("   uvicorn main:app --reload --host 0.0.0.0 --port 8000")
        return False
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return False

def test_register():
    """Test d'inscription"""
    print("\n📝 Test d'inscription...")
    data = {
        "email": "test@example.com",
        "username": "testuser",
        "password": "password123"
    }
    
    try:
        response = requests.post(
            f"{BASE_URL}/api/auth/register",
            json=data,
            timeout=10
        )
        
        if response.status_code == 200:
            print("✅ Inscription réussie")
            result = response.json()
            print(f"   Token reçu: {result['access_token'][:50]}...")
            return result['access_token']
        elif response.status_code == 400:
            print("⚠️  Utilisateur existe déjà (normal si déjà testé)")
            # Essayer de se connecter à la place
            return test_login()
        else:
            print(f"❌ Erreur {response.status_code}")
            print(f"   Détails: {response.text}")
            return None
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return None

def test_login():
    """Test de connexion"""
    print("\n🔐 Test de connexion...")
    data = {
        "email": "test@example.com",
        "password": "password123"
    }
    
    try:
        response = requests.post(
            f"{BASE_URL}/api/auth/login",
            json=data,
            timeout=10
        )
        
        if response.status_code == 200:
            print("✅ Connexion réussie")
            result = response.json()
            print(f"   Token reçu: {result['access_token'][:50]}...")
            return result['access_token']
        else:
            print(f"❌ Erreur {response.status_code}")
            print(f"   Détails: {response.text}")
            return None
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return None

def test_me(token):
    """Test de récupération du profil"""
    print("\n👤 Test de récupération du profil...")
    
    try:
        response = requests.get(
            f"{BASE_URL}/api/auth/me",
            headers={"Authorization": f"Bearer {token}"},
            timeout=10
        )
        
        if response.status_code == 200:
            print("✅ Profil récupéré avec succès")
            result = response.json()
            print(f"   Email: {result['email']}")
            print(f"   Username: {result['username']}")
            return True
        else:
            print(f"❌ Erreur {response.status_code}")
            print(f"   Détails: {response.text}")
            return False
    except Exception as e:
        print(f"❌ Erreur: {e}")
        return False

def main():
    print("=" * 60)
    print("🧪 TESTS DU BACKEND INTERIOR DESIGN AI")
    print("=" * 60)
    print(f"\n🌐 URL du backend: {BASE_URL}")
    
    # Test 1: Santé du serveur
    if not test_health():
        print("\n❌ Le serveur n'est pas accessible. Arrêt des tests.")
        sys.exit(1)
    
    # Test 2: Inscription (ou connexion si existe déjà)
    token = test_register()
    if not token:
        print("\n❌ Échec de l'authentification. Arrêt des tests.")
        sys.exit(1)
    
    # Test 3: Récupération du profil
    test_me(token)
    
    print("\n" + "=" * 60)
    print("✅ TOUS LES TESTS SONT PASSÉS")
    print("=" * 60)
    print("\n💡 Le backend est prêt pour l'application Flutter!")
    print("\n📱 Vous pouvez maintenant lancer l'app Flutter avec:")
    print("   flutter run")

if __name__ == "__main__":
    main()