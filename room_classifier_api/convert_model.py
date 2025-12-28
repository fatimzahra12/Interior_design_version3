import tensorflow as tf
import json
import os

print("🔄 Conversion du modèle en format .keras...")

# Charger la configuration
with open('model/config.json', 'r') as f:
    config = json.load(f)

# Reconstruire le modèle depuis la config
model = tf.keras.models.model_from_json(json.dumps(config))

# Charger les poids
model.load_weights('model/model.weights.h5')

# Sauvegarder au format .keras
model.save('model/room_classifier.keras')

print("✅ Modèle converti avec succès!")
print(f"📁 Fichier créé: model/room_classifier.keras")
print(f"📊 Taille: {os.path.getsize('model/room_classifier.keras') / 1024 / 1024:.2f} MB")

# Vérifier le modèle
print("\n🧪 Test du modèle:")
print(f"  - Input shape: {model.input_shape}")
print(f"  - Output shape: {model.output_shape}")
print(f"  - Nombre de couches: {len(model.layers)}")