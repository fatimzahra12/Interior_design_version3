from database import engine, Base
import models

print("🔨 Création de la base de données...")

# Créer toutes les tables
Base.metadata.create_all(bind=engine)

print("✅ Base de données créée avec succès!")
print(f"📁 Fichier: interior_design.db")
print(f"📊 Tables créées: {list(Base.metadata.tables.keys())}")