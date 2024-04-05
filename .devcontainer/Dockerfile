FROM ubuntu:22.04
# Forcer le faite d'utiliser les miroirs français quand on utilise apt ...
COPY ./sources.list /etc/apt/sources.list

ARG USERNAME=hetic
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Setup
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \    
    && apt-get update \
    && apt-get install -y sudo \
    && apt-get install -y tzdata \
    && apt-get install -y language-pack-fr-base language-pack-fr \    
    && yes | unminimize \
    && apt-get install -y man-db \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

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