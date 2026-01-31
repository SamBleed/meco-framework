# Base de Kali Rolling
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# 1. Herramientas base + Dependencias de Firma (Añadido: gnupg, make, pinentry-curses)
RUN apt-get update && apt-get install -y \
    zsh curl wget git sudo lsd bat ripgrep htop fzf ncdu tealdeer \
    nmap iputils-ping net-tools whois gnupg make pinentry-curses \
    python3 python3-pip python3-pandas python3-gnupg python3-yaml \
    && apt-get clean

# 2. Instalación de git-secrets (Para que sea nativo en el Engine)
RUN git clone https://github.com/awslabs/git-secrets.git /tmp/git-secrets && \
    cd /tmp/git-secrets && make install && rm -rf /tmp/git-secrets

# 3. Oh My Zsh y Plugins (Manteniendo tu estilo)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 4. Configuración del .zshrc y ANCLA DE PERSISTENCIA
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)/' ~/.zshrc && \
    echo "alias ls='lsd --group-directories-first'" >> ~/.zshrc && \
    echo "alias ll='lsd -l --group-directories-first'" >> ~/.zshrc && \
    echo "alias cat='batcat --style=plain'" >> ~/.zshrc && \
    echo "alias tldr='tealdeer'" >> ~/.zshrc && \
    echo "PROMPT='%F{cyan}MECO%f:%F{yellow}%~%f %# '" >> ~/.zshrc && \
    # --- ESTA ES LA LÍNEA CLAVE ---
    echo "source /root/meco-framework/load_env.sh" >> ~/.zshrc

# 5. Banner de Bienvenida actualizado
RUN echo "echo ' 🛡️  MECO FRAMEWORK - ENGINE V1.4 (SECURE) 🛡️'" >> ~/.zshrc

WORKDIR /root/meco-framework
ENTRYPOINT ["/bin/zsh"]
