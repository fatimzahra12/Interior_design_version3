from pydantic import BaseModel, validator
from typing import Optional
from datetime import datetime

class UserCreate(BaseModel):
    email: str
    username: str
    password: str
    
    @validator('password')
    def validate_password(cls, v):
        if len(v) < 6:
            raise ValueError('Le mot de passe doit contenir au moins 6 caractères')
        if len(v) > 72:
            raise ValueError('Le mot de passe ne peut pas dépasser 72 caractères')
        return v

class UserLogin(BaseModel):
    email: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class User(BaseModel):
    id: int
    email: str
    username: str
    created_at: datetime
    
    class Config:
        from_attributes = True

class RoomClassification(BaseModel):
    room_class: str
    confidence: float

class TransformRequest(BaseModel):
    style: str
    room_type: str