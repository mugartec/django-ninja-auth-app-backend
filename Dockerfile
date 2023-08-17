FROM python:3.11-slim-buster

# Ensures our console output looks familiar and is not buffered by Docker, which we don’t want.
ENV PYTHONUNBUFFERED 1
# Will not get prompted for input
ARG DEBIAN_FRONTEND=noninteractive

# Update repos and upgrade packages
RUN apt-get update -qq
RUN apt-get upgrade -yq

# Install apt-utils so debian will not complain about delaying configurations
RUN apt-get install -yq --no-install-recommends apt-utils gettext

# Required for building psycopg2
RUN apt-get install -yq gcc python3-dev libpq-dev postgresql-client

# Required for i18n
# RUN apt-get install -yq gettext

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

#Set working directory
RUN mkdir -p /app/devops

RUN pip install poetry
RUN poetry config virtualenvs.create false

# Copy poetry files first and install dependencies
# This is done earlier to avoid repeating when building the image
RUN mkdir /src
COPY ./src/poetry.lock /src/poetry.lock
COPY ./src/pyproject.toml /src/pyproject.toml
WORKDIR /src
RUN poetry install --no-dev

# Finally copy the app and do everything app-related
COPY ./src /src
COPY ./devops /devops

# Expose Gunicorn Port
EXPOSE 8000

# Run the entrypoint. This will run gunicorn inside supervisord.
# Note that in dev it runs as sudo, and in prod runs as django.
ENTRYPOINT [ "/devops/entrypoint.sh" ]
