# backend_api/create_tables.py
from database import engine, Base
from models import User, UserProfile

# Créer toutes les tables
Base.metadata.create_all(bind=engine)
print("✅ Tables créées avec succès!")