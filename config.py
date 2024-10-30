import os

class Config:
    """Configuraciones para la aplicación."""
    
    # URL del webhook de Rasa
    RASA_WEBHOOK_URL = os.getenv("RASA_WEBHOOK_URL", "https://chatbotinsideout.onrender.com/webhooks/rest/webhook")

  
    PORT = int(os.getenv("PORT", 5005))  
    DEBUG = os.getenv("DEBUG", "False") == "True" 


config = Config()

