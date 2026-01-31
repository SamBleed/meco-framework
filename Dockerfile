# Base de Kali Rolling
FROM kalilinux/kali-rolling

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalación de herramientas y librerías de Python para la V1
RUN apt-get update && apt-get install -y \
    zsh \
    nano \
    nmap \
    python3 \
    python3-pip \
    # Librerías esenciales para MECO v1.0
    python3-pandas \
    python3-openpyxl \
    python3-gnupg \
    python3-yaml \
    # Herramientas de red y sistema
    iputils-ping \
    net-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo del framework
WORKDIR /root/meco-framework

# Iniciamos directamente en ZSH
ENTRYPOINT ["/bin/zsh"]
