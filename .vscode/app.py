from sanic import Sanic
from sanic.response import json
from sanic.exceptions import NotFound
import requests
from config import config  # Importa la configuración

app = Sanic(__name__)

# Usa la URL del webhook definida en config.py
WEBHOOK_URL = config.RASA_WEBHOOK_URL

@app.route("/webhooks/rest/webhook", methods=["POST"])
async def webhook(request):
    user_message = request.json.get("message")

    if not user_message:
        return json({"error": "No message provided"}, status=400)

    # Envía el mensaje al webhook de Rasa
    response = requests.post(WEBHOOK_URL, json={"sender": "user", "message": user_message})

    if response.status_code != 200:
        return json({"error": "Failed to get response from Rasa"}, status=response.status_code)

    return json(response.json())

# Manejo de rutas no encontradas
@app.exception(NotFound)
async def handle_not_found(request):
    return json({"error": "Not Found"}, status=404)

if __name__ == "__main__":
    # Usa el puerto definido en config.py
    app.run(host="0.0.0.0", port=config.PORT)
