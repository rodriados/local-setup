ARG UBUNTU_VERSION=latest
FROM ubuntu:${UBUNTU_VERSION}

ARG UBUNTU_USER=rodriados

RUN apt-get update
RUN apt-get install -y sudo python3 pipx

RUN useradd -ms /bin/bash -G sudo ${UBUNTU_USER}
RUN passwd -d ${UBUNTU_USER}

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${UBUNTU_USER}
WORKDIR /home/${UBUNTU_USER}

ENV DEBIAN_FRONTEND=noninteractive

COPY --chown=${UBUNTU_USER}:${UBUNTU_USER} . .local-setup

RUN .local-setup/setup.sh minimal
