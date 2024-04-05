FROM ubuntu:22.04
# Forcer le faite d'utiliser les miroirs français quand on utilise apt ...
# COPY ./.devcontainer/sources.list /etc/apt/sources.list

# Setup
RUN apt-get update \
  && rm /var/lib/dpkg/info/libc-bin.* \
  && apt-get clean \
  && apt-get update \
  && apt install -y libc-bin \
  && apt-get install -y sudo \
  && apt-get install -y less \
  && apt-get install -y tzdata \
  && apt-get install -y language-pack-fr-base language-pack-fr \    
  && yes | unminimize \
  && apt-get install -y man-db

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Set the time-zone of the container
ENV TZ Europe/Paris

# Set the default shell interpreter
ENV SHELL /bin/bash

# Set the language
ENV LANG fr_FR.UTF-8  
ENV LANGUAGE fr_FR:fr  
ENV LC_ALL fr_FR.UTF-8    

# Set the default home directory
WORKDIR /home/hetic
RUN /bin/bash