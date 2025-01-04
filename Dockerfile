# Використовуємо офіційний образ Python
FROM python:3.12-slim

# Встановлюємо залежності системи
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libssl-dev libpq-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Встановлюємо робочий каталог
WORKDIR /app

# Встановлюємо Python-залежності
COPY simpleapi/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Копіюємо файли проекту в контейнер
COPY simpleapi/ /app/

# Відкриваємо порт для uWSGI
EXPOSE 8000

# Команда для запуску uWSGI
CMD ["uwsgi", "--http", "0.0.0.0:8000", "--module", "simpleapi.wsgi:application", "--master", "--processes", "2", "--threads", "2"]
