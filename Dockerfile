# Base de Kali Rolling
FROM kalilinux/kali-rolling

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# 1. Instalación de Herramientas de Sistema y UX (Estilo Exegol)
RUN apt-get update && apt-get install -y \
    zsh \
    sudo \
    curl \
    wget \
    git \
    lsd \
    bat \
    ripgrep \
    htop \
    nano \
    vim \
    && apt-get clean

# 2. Instalación de Herramientas de Ciberseguridad y Red
RUN apt-get install -y \
    nmap \
    iputils-ping \
    net-tools \
    whois \
    && apt-get clean

# 3. Músculo Analítico (Python para la V1)
RUN apt-get install -y \
    python3 \
    python3-pip \
    python3-pandas \
    python3-openpyxl \
    python3-gnupg \
    python3-yaml \
    python3-requests \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configuración de Alias para UX Profesional
RUN echo "alias ls='lsd --group-directories-first'" >> /root/.zshrc && \
    echo "alias ll='lsd -l --group-directories-first'" >> /root/.zshrc && \
    echo "alias cat='batcat --style=plain'" >> /root/.zshrc && \
    echo "alias grep='rg'" >> /root/.zshrc

# Configuración de entorno
WORKDIR /root/meco-framework
ENTRYPOINT ["/bin/zsh"]
