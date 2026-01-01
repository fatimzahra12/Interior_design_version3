# backend_api/routers/profile.py

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from typing import Optional
from datetime import datetime
import shutil
import os
from pathlib import Path

# Imports depuis votre projet
import database
import models
import auth
from pydantic import BaseModel

router = APIRouter(prefix="/profile", tags=["Profile"])

# Schémas Pydantic
class ProfileUpdate(BaseModel):
    bio: Optional[str] = None
    phone: Optional[str] = None
    favorite_style: Optional[str] = None

class ProfileResponse(BaseModel):
    id: int
    user_id: int
    bio: Optional[str]
    phone: Optional[str]
    favorite_style: Optional[str]
    profile_picture: Optional[str]
    email: str
    username: str
    total_designs: int
    
    class Config:
        from_attributes = True


# GET - Récupérer le profil de l'utilisateur
@router.get("/me", response_model=ProfileResponse)
async def get_my_profile(
    token: str = Depends(auth.oauth2_scheme),
    db: Session = Depends(database.get_db)
):
    """Récupère le profil de l'utilisateur connecté"""
    
    # Vérifier le token et récupérer l'email
    email = auth.verify_token(token)
    
    # Récupérer l'utilisateur
    from crud import get_user_by_email
    current_user = get_user_by_email(db, email=email)
    
    if not current_user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    
    # Récupérer ou créer le profil
    profile = db.query(models.UserProfile).filter(
        models.UserProfile.user_id == current_user.id
    ).first()
    
    if not profile:
        # Créer un profil par défaut si inexistant
        profile = models.UserProfile(user_id=current_user.id)
        db.add(profile)
        db.commit()
        db.refresh(profile)
    
    # Compter le nombre total de designs (pour l'instant 0)
    total_designs = 0
    
    return {
        "id": profile.id,
        "user_id": current_user.id,
        "bio": profile.bio,
        "phone": profile.phone,
        "favorite_style": profile.favorite_style,
        "profile_picture": profile.profile_picture,
        "email": current_user.email,
        "username": current_user.username,
        "total_designs": total_designs
    }


# PUT - Mettre à jour le profil
@router.put("/update")
async def update_profile(
    profile_data: ProfileUpdate,
    token: str = Depends(auth.oauth2_scheme),
    db: Session = Depends(database.get_db)
):
    """Met à jour le profil de l'utilisateur"""
    
    # Vérifier le token et récupérer l'email
    email = auth.verify_token(token)
    
    # Récupérer l'utilisateur
    from crud import get_user_by_email
    current_user = get_user_by_email(db, email=email)
    
    if not current_user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    
    profile = db.query(models.UserProfile).filter(
        models.UserProfile.user_id == current_user.id
    ).first()
    
    if not profile:
        profile = models.UserProfile(user_id=current_user.id)
        db.add(profile)
    
    # Mettre à jour uniquement les champs fournis
    # Mettre à jour uniquement les champs fournis
    if profile_data.bio is not None:
        profile.bio = profile_data.bio
    if profile_data.phone is not None:
        profile.phone = profile_data.phone
    if profile_data.favorite_style is not None:
        profile.favorite_style = profile_data.favorite_style

    # CORRECTION ICI :
    profile.updated_at = datetime.utcnow()  # datetime avec un 'd' minuscule

    db.commit()
    db.refresh(profile)
    return {"message": "Profile updated successfully", "profile": profile}


# POST - Upload photo de profil
@router.post("/upload-picture")
async def upload_profile_picture(
    file: UploadFile = File(...),
    token: str = Depends(auth.oauth2_scheme),
    db: Session = Depends(database.get_db)
):
    """Upload une photo de profil"""
    
    # Vérifier le token et récupérer l'email
    email = auth.verify_token(token)
    
    # Récupérer l'utilisateur
    from crud import get_user_by_email
    current_user = get_user_by_email(db, email=email)
    
    if not current_user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    
    # Vérifier le type de fichier
    allowed_types = ["image/jpeg", "image/png", "image/jpg"]
    if file.content_type not in allowed_types:
        raise HTTPException(
            status_code=400,
            detail="Only JPEG and PNG images are allowed"
        )
    
    # Créer le dossier pour les photos de profil
    upload_dir = Path("uploads/profile_pictures")
    upload_dir.mkdir(parents=True, exist_ok=True)
    
    # Générer un nom de fichier unique
    file_extension = file.filename.split(".")[-1]
    filename = f"user_{current_user.id}_{int(datetime.utcnow().timestamp())}.{file_extension}"
    file_path = upload_dir / filename
    
    # Sauvegarder le fichier
    with file_path.open("wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    # Mettre à jour le profil
    profile = db.query(models.UserProfile).filter(
        models.UserProfile.user_id == current_user.id
    ).first()
    
    if not profile:
        profile = models.UserProfile(user_id=current_user.id)
        db.add(profile)
    
    # Supprimer l'ancienne photo si elle existe
    if profile.profile_picture and os.path.exists(profile.profile_picture):
        try:
            os.remove(profile.profile_picture)
        except:
            pass
    
    profile.profile_picture = str(file_path)
    profile.updated_at = datetime.utcnow()
    
    db.commit()
    db.refresh(profile)
    
    return {
        "message": "Profile picture uploaded successfully",
        "file_path": str(file_path)
    }


# PUT - Changer le mot de passe
@router.put("/change-password")
async def change_password(
    old_password: str,
    new_password: str,
    token: str = Depends(auth.oauth2_scheme),
    db: Session = Depends(database.get_db)
):
    """Change le mot de passe de l'utilisateur"""
    
    from passlib.context import CryptContext
    pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
    
    # Vérifier le token et récupérer l'email
    email = auth.verify_token(token)
    
    # Récupérer l'utilisateur
    from crud import get_user_by_email
    current_user = get_user_by_email(db, email=email)
    
    if not current_user:
        raise HTTPException(status_code=404, detail="Utilisateur non trouvé")
    
    # Vérifier l'ancien mot de passe
    if not pwd_context.verify(old_password, current_user.hashed_password):
        raise HTTPException(
            status_code=400,
            detail="Incorrect old password"
        )
    
    # Hasher et sauvegarder le nouveau mot de passe
    current_user.hashed_password = pwd_context.hash(new_password)
    db.commit()
    
    return {"message": "Password changed successfully"}