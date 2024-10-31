#!/bin/sh

# Inicia Rasa con la API habilitada y el CORS e Inicia el servidor de acciones
rasa run --enable-api --cors '*' --port 5005 & rasa run actions --port 5055

