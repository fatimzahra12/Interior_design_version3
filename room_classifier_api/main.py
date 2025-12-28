from fastapi import FastAPI, UploadFile, File
from fastapi.responses import JSONResponse
import tensorflow as tf
from PIL import Image
import numpy as np
import io
import os

app = FastAPI(title="Room Classifier API")

# Path to your model file
MODEL_PATH = os.path.join("model", "room_classifier.keras")

# Load model once on startup
model = tf.keras.models.load_model(MODEL_PATH)

# Replace with your real class names in correct order
CLASS_NAMES = ["bathroom", "bedroom", "office", "kitchen", "living room"]

IMG_SIZE = 224  # EfficientNetB0 default input size

def preprocess_image(image_bytes: bytes):
    img = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    img = img.resize((IMG_SIZE, IMG_SIZE))
    arr = np.array(img).astype(np.float32) / 255.0
    arr = np.expand_dims(arr, axis=0)
    return arr

@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    try:
        image_bytes = await file.read()
        img = preprocess_image(image_bytes)
        preds = model.predict(img)
        class_index = int(np.argmax(preds))
        confidence = float(np.max(preds))

        return JSONResponse({
            "class": CLASS_NAMES[class_index] if class_index < len(CLASS_NAMES) else str(class_index),
            "confidence": round(confidence, 4)
        })
    except Exception as e:
        return JSONResponse({"error": str(e)}, status_code=500)
