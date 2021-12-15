# For a reasoning on Debian slim pre-built Python image over using Alpine look here:
# https://pythonspeed.com/articles/alpine-docker-python/
# tl;dr -> alpine's use of the musl instead of glibc makes for headaches trying to work with
#          python, especially some popular (and C-heavy) libraries.
FROM python:3.9-slim

WORKDIR /app

# copying in and applying the project requirements.
COPY ["requirements.txt", "requirements.txt"]
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install -r requirements.txt
