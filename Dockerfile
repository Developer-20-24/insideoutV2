FROM python:3.9.12-slim

WORKDIR /app
COPY . .

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--port", "5005"]