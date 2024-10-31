from sanic import Sanic
from sanic.response import json
from rasa import Rasa

app = Sanic(__name__)

# Inicializa Rasa (asegúrate de tener la instancia de Rasa configurada)
rasa_app = Rasa()

@app.route('/webhooks/rest/webhook', methods=['POST'])
async def webhook(request):
    payload = request.json
    # Aquí puedes llamar a tu lógica de Rasa para procesar el mensaje
    response = await rasa_app.handle_message(payload)
    return json(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5005)
