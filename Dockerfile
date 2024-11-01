# Usa una imagen base de Python 3.9
FROM python:3.9-slim

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

# Exponer el puerto 5005 para la API de Rasa
EXPOSE $PORT

# Comando para ejecutar Rasa
CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port ${PORT}"]
# CMD ["sh", "-c", "rasa run actions --port 5055" --host 0.0.0.0]
#CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port $PORT & rasa run actions --port 5055"]
# CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port $PORT & rasa run actions --actions actions"]
# CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port 5005 & rasa run actions --port 5055"]
# CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "${PORT}"]
# CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port ${PORT}"]
#CMD ["sh", "-c", "rasa run --enable-api --cors '*' --port ${PORT}"]
#CMD ["rasa", "run", "--enable-api", "--cors", "*", "rasa run actions", "--port", "5005"]