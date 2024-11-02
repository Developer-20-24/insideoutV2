FROM python:3.9-slim

# Configura variables de entorno para reducir el uso de memoria
ENV PYTHONUNBUFFERED=1
ENV RASA_TELEMETRY_ENABLED=false
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TENSORFLOW_IO_ENABLE_OUTLIER_DETECTION=false

# Configura el directorio de trabajo
WORKDIR /app

# Copia solo los archivos necesarios primero
COPY requirements.txt ./

# Instala las dependencias con pip
RUN pip install --no-cache-dir -r requirements.txt && pip cache purge

# Copia la carpeta models (con el modelo previamente entrenado)
COPY models /app/models

# Copia el resto de los archivos del proyecto
COPY . .

# Limpia archivos innecesarios después de la instalación
RUN find . -type d -name "__pycache__" -exec rm -r {} + && \
    rm -rf /root/.cache

# Configura el puerto
ENV PORT=5005

# Expone el puerto
EXPOSE 5005

# Comando CMD modificado para especificar directamente el puerto y usar el modelo previamente entrenado
CMD ["sh", "-c", "rasa run --enable-api --cors '*' --host 0.0.0.0 --port 5005"]

#CMD ["sh", "-c", "rasa", "run", "--enable-api", "--cors", "*", "--model", "/app/models", "--port", "5005"]

#CMD ["sh", "-c", "rasa run --enable-api --cors '*' --host 0.0.0.0 --port $PORT -vv & rasa run actions --port 5055 -vv"]

