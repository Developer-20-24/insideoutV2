FROM python:3.9-slim

# Configura variables de entorno para reducir el uso de memoria
ENV PYTHONUNBUFFERED=1
ENV RASA_TELEMETRY_ENABLED=false
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TENSORFLOW_IO_ENABLE_OUTLIER_DETECTION=false

# Configura el directorio de trabajo
WORKDIR /app

# Instala solo las dependencias esenciales del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copia solo los archivos necesarios primero
COPY requirements.txt ./

# Instala las dependencias con pip
RUN pip install --no-cache-dir -r requirements.txt \
    && pip cache purge

# Copia el resto de los archivos
COPY . .

# Entrena el modelo con configuraciones optimizadas
RUN rasa train --augmentation 0 --debug

# Limpia archivos innecesarios después del entrenamiento
RUN apt-get purge -y --auto-remove build-essential python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && find . -type d -name "__pycache__" -exec rm -r {} + \
    && rm -rf /root/.cache

# Configura el puerto
ENV PORT=5005

# Expone el puerto
EXPOSE ${PORT}

# Comando para iniciar el servidor con configuraciones optimizadas
CMD rasa run \
    --enable-api \
    --cors "*" \
    --port ${PORT} \
    --no-prompt \
    --production \
    --log-level WARNING