#!/bin/bash

# Define el puerto directamente
PORT=5005  # Cambia este número al puerto que desees

# Inicia el servidor de Rasa
rasa run --enable-api --cors "*" --port "$PORT"