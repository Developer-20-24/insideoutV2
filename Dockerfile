FROM python:3.9.12-slim

WORKDIR /app
COPY . .

COPY requirements.txt ./

EXPOSE 5005

# Comando corregido usando $PORT en lugar de ${PORT}
CMD rasa run --enable-api --port 5005