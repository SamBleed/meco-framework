# 1. BASE: Usamos tu imagen de 19.5GB (Mantenemos todos los músculos)
FROM meco-engine:v2.5-god
LABEL maintainer="SamBleed <@SamBleed>"

# 2. VARIABLES DE ENTORNO
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/usr/local/go/bin:/root/go/bin"
ENV LANG="es_ES.UTF-8"
ENV COLORTERM=truecolor
ENV MECO_ENV="CONTAINER"

ARG GITLAB_TOKEN

# 3. LIMPIEZA QUIRÚRGICA
RUN rm -rf /root/.zshrc /root/.zshrc.bak /root/.zshrc.tmp /root/dotfiles /root/.zsh_history

# 3.5. INSTALACIÓN DE PLUGINS (Para el autocompletado y colores)
RUN apt-get update && apt-get install -y \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    && apt-get clean

# 4. IDENTIDAD GLOBAL (El nuevo Cerebro v10 desde GitLab)
RUN git clone https://oauth2:${GITLAB_TOKEN}@gitlab.com/SamBleed/dotfiles.git /root/dotfiles && \
    cd /root/dotfiles && \
    chmod +x install.sh && \
    ./install.sh && \
    rm -rf /root/dotfiles

# 5. CONFIGURACIÓN DE PORTABILIDAD
RUN echo "# --- SAMBLEED PORTABLE OVERRIDE ---" > /root/.zshrc.local && \
    echo "export MECO_ENV='CONTAINER'" >> /root/.zshrc.local && \
    echo "export LOCAL_IP=\$(hostname -i 2>/dev/null | awk '{print \$1}')" >> /root/.zshrc.local && \
    echo "export SECRET_KEY_BASE=$(openssl rand -hex 64)" >> /root/.zshrc.local && \
    echo "alias db-up='sudo service postgresql start && msfdb init'" >> /root/.zshrc.local && \
    echo "alias msf='msfconsole -q'" >> /root/.zshrc.local && \
    echo "alias meco-go='cd /root/meco-framework'" >> /root/.zshrc.local

# 6. EL FRAMEWORK (Tu Proyecto de Mejora - Tesis)
WORKDIR /root
RUN rm -rf /root/meco-framework && \
    git clone https://oauth2:${GITLAB_TOKEN}@gitlab.com/SamBleed/meco-framework.git /root/meco-framework

# 7. NORMALIZACIÓN DE HERRAMIENTAS
RUN ln -sf $(which fdfind) /usr/local/bin/fd && \
    if [ -f /usr/bin/batcat ]; then ln -sf /usr/bin/batcat /usr/local/bin/bat; fi

# 8. MANTENIMIENTO SSD
RUN rm -rf /tmp/* /var/lib/apt/lists/*

# 9. PUNTO DE ENTRADA
WORKDIR /root/meco-framework
ENTRYPOINT ["/bin/zsh"]
