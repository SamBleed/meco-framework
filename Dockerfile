# Usamos la base de Kali que ya conocemos
FROM kalilinux/kali-rolling

# Instalamos lo que configuramos (ejemplo)
RUN apt-get update && apt-get install -y \
    zsh \
    nano \
    burpsuite \
    && apt-get clean

# Aquí podrías copiar tus configuraciones de ayer (.zshrc interno)
# COPY .zshrc /root/.zshrc

ENTRYPOINT ["/bin/zsh"]
