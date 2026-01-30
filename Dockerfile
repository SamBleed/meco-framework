# Base de Kali Rolling
FROM kalilinux/kali-rolling

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Solo herramientas esenciales de red y sistema
RUN apt-get update && apt-get install -y \
    zsh \
    nano \
    nmap \
    python3 \
    python3-pip \
    iputils-ping \
    net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo del framework
WORKDIR /root/meco-framework

# Iniciamos directamente en ZSH
ENTRYPOINT ["/bin/zsh"]