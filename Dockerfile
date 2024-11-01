# Usa una imagen base de Python 3.9
FROM python:3.9-slim

# Instala dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Configura el directorio de trabajo
WORKDIR /app

# Copia los archivos de requerimientos
COPY requirements.txt ./

# Instala las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de los archivos
COPY . .

# Entrena el modelo
RUN rasa train

# Configura variables de entorno por defecto
ENV PORT=5005
ENV WORKERS=1

# Expone el puerto
EXPOSE ${PORT}

# Comando para iniciar el servidor
CMD rasa run \
    --enable-api \
    --cors "*" \
    --port ${PORT} \
    --workers ${WORKERS} \
    --auth none