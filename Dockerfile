ARG PYTHON_IMAGE="python:3.12-slim"
FROM ${PYTHON_IMAGE} AS buildbase

# Install apt packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libssl-dev libpq-dev gcc curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working dir
WORKDIR /app

# Open port uWSGI
EXPOSE 8000

# Install Python-dependecies
COPY simpleapi/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

CMD python3 manage.py runserver 0.0.0.0:8000

FROM buildbase AS buildcode

# Copy project's files
COPY simpleapi/ /app/

# Start command
CMD ["uwsgi", "--http", "0.0.0.0:8000", "--module", "simpleapi.wsgi:application", "--master", "--processes", "2", "--threads", "2"]
