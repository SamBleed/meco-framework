# 🛡️ MECO-ENGINE V1.4.1 (SECURE & PERSISTENT)
# Base de Kali Rolling
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# 1. Herramientas base + Firma + Edición + Python
# Se añade 'nano' y 'pinentry-curses' para que GPG funcione correctamente
RUN apt-get update && apt-get install -y \
    zsh curl wget git sudo lsd bat ripgrep htop fzf ncdu tealdeer \
    nmap iputils-ping net-tools whois gnupg make pinentry-curses \
    nano \
    python3 python3-pip python3-pandas python3-gnupg python3-yaml \
    && apt-get clean

# 2. Instalación de git-secrets (Prevención de fugas DLP)
RUN git clone https://github.com/awslabs/git-secrets.git /tmp/git-secrets && \
    cd /tmp/git-secrets && make install && rm -rf /tmp/git-secrets

# 3. Oh My Zsh y Plugins (Zsh-Autosuggestions & Syntax Highlighting)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 4. Configuración del .zshrc (Alias, Plugins y Ancla de Persistencia)
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)/' ~/.zshrc && \
    echo "alias ls='lsd --group-directories-first'" >> ~/.zshrc && \
    echo "alias ll='lsd -l --group-directories-first'" >> ~/.zshrc && \
    echo "alias cat='batcat --style=plain'" >> ~/.zshrc && \
    echo "alias tldr='tealdeer'" >> ~/.zshrc && \
    echo "PROMPT='%F{cyan}MECO%f:%F{yellow}%~%f %# '" >> ~/.zshrc && \
    # --- ESTA ES LA LÍNEA CLAVE DE PERSISTENCIA ---
    echo "source /root/meco-framework/load_env.sh" >> ~/.zshrc

# 5. Fix de Hostname y Banner de Bienvenida
# Evita el error "unable to resolve host" inyectando el host al iniciar cada sesión
RUN echo "echo '127.0.0.1 kali' >> /etc/hosts 2>/dev/null" >> ~/.zshrc && \
    echo "echo ' '" >> ~/.zshrc && \
    echo "echo ' 🛡️  MECO FRAMEWORK - ENGINE V1.4.1 (SECURE) 🛡️'" >> ~/.zshrc && \
    echo "echo ' [+] Status: Identity & Vault Loaded'" >> ~/.zshrc

WORKDIR /root/meco-framework
ENTRYPOINT ["/bin/zsh"]
