import requests
import json

url = "http://localhost:8000/api/auth/register"
data = {
    "email": "newuser@example.com",
    "username": "newuser",
    "password": "password123"
}

print("🧪 Test d'inscription...")
print(f"URL: {url}")
print(f"Data: {json.dumps(data, indent=2)}")

try:
    response = requests.post(url, json=data)
    print(f"\n📊 Status Code: {response.status_code}")
    print(f"📄 Response: {response.text}")
    
    if response.status_code == 200:
        print("\n✅ Inscription réussie!")
        token = response.json()
        print(f"🔑 Token: {token['access_token'][:50]}...")
    else:
        print(f"\n❌ Erreur: {response.text}")
except Exception as e:
    print(f"\n❌ Exception: {str(e)}")