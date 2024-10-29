# Usa una imagen base de Python 3.9
FROM python:3.9.12-slim

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos requirements.txt (o pyproject.toml si usas Poetry) y de dependencias al contenedor
COPY requirements.txt ./

# Instala las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de los archivos del proyecto al contenedor
COPY . .

# Entrena el modelo Rasa
RUN rasa train

# Expón el puerto (ajústalo según el puerto en el que corre tu app)
EXPOSE 5005

# Comando para ejecutar Rasa
CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port $PORT & rasa run actions --port 5055"]