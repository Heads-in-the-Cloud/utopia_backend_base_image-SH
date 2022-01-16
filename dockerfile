# For a reasoning on Debian slim pre-built Python image over using Alpine look here:
# https://pythonspeed.com/articles/alpine-docker-python/
#
# tl;dr:
#   Alpine's use of the musl instead of glibc makes for headaches trying to work with
#   python, especially some popular (and C-heavy) libraries.

# syntax=docker/dockerfile:1
FROM python:3.9.9-slim

MAINTAINER Sean Horner "sean.horner@smoothstack.com"
LABEL project="utopia_airlines"

RUN useradd utopian

WORKDIR /home/utopian

# Copying in and applying the project requirements.
COPY ["requirements.txt", "requirements.txt"]
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

# Uvicorn is installed in its own, non-version-specific command to ensure the most up-to-date version since webserver
# security is always enhancing and adapting to threats. Also, Uvicorn is highly unlikely to ever introduce
# code-breaking changes since it will always adhere to the WSGI/ASGI standards.
RUN pip install uvicorn
RUN apt-get update
RUN apt-get -y install default-libmysqlclient-dev
RUN apt-get -y install build-essential
RUN pip install mysqlclient
