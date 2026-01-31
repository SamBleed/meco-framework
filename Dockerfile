# Base de Kali Rolling
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# 1. Instalación de herramientas (Cambiamos tldr por tealdeer, que es más rápido y está en repo)
RUN apt-get update && apt-get install -y \
    zsh curl wget git sudo lsd bat ripgrep htop fzf ncdu tealdeer \
    nmap iputils-ping net-tools whois \
    python3 python3-pip python3-pandas python3-gnupg python3-yaml \
    && apt-get clean

# 2. Instalación de Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 3. Instalación de Plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 4. Configuración del .zshrc (Alias y Prompt)
RUN sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf)/' ~/.zshrc && \
    echo "alias ls='lsd --group-directories-first'" >> ~/.zshrc && \
    echo "alias ll='lsd -l --group-directories-first'" >> ~/.zshrc && \
    echo "alias cat='batcat --style=plain'" >> ~/.zshrc && \
    echo "alias grep='rg'" >> ~/.zshrc && \
    echo "alias du='ncdu --color dark -rr -x'" >> ~/.zshrc && \
    echo "alias tldr='tealdeer'" >> ~/.zshrc && \
    echo "PROMPT='%F{cyan}MECO%f:%F{yellow}%~%f %# '" >> ~/.zshrc

# 5. Banner de Bienvenida (Sintaxis limpia)
RUN echo "echo ' '" >> ~/.zshrc && \
    echo "echo '  🛡️  MECO FRAMEWORK - ENGINE V1.3  🛡️'" >> ~/.zshrc && \
    echo "echo '  [+] Host: Arch Linux | User: samuell-sr'" >> ~/.zshrc && \
    echo "echo '  [+] Status: Connected & Ready'" >> ~/.zshrc && \
    echo "echo ' '" >> ~/.zshrc

WORKDIR /root/meco-framework
ENTRYPOINT ["/bin/zsh"]
