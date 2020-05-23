#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM mcr.microsoft.com/vscode/devcontainers/base:0-debian-9

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# This Dockerfile's base image has a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=postgres

# Configure apt and install packages
RUN apt-get update \
    && apt-get install -y apt-file \
    && apt-file update

# Install some tools
RUN apt-get install -y vim

# Install C++ tools
RUN apt-get -y install build-essential cmake cppcheck valgrind \
    # Postgres specific packages
    bison flex libreadline7 libreadline-dev zlib1g-dev \
    #
    && useradd $USERNAME -m -d /home/$USERNAME \
    && echo "alias dir='ls -la'" >> /home/$USERNAME/.bashrc \
    && echo "export PATH=$PATH:/usr/local/pgsql/bin" >> /home/$USERNAME/.bashrc \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
