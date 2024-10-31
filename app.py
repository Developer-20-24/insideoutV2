import os
from sanic import Sanic
from sanic.response import json
from rasa import Rasa

app = Sanic(__name__)
port = int(os.environ.get("PORT", 5005))  # Cambia 5005 al puerto que estés usando

@app.route("/webhooks/rest/webhook", methods=["POST"])
async def webhook(request):
    # Maneja el webhook aquí
    return response

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=port)
