#!/bin/bash
# 🛡️ MECO-Engine: Restauración de Entorno Táctico

echo "[*] Configurando identidad MECO..."

# 1. Restaurar GPG (Desde el SSD al llavero de Root)
if [ -f "/root/meco-framework/05-vault/meco_private.asc" ]; then
    gpg --import /root/meco-framework/05-vault/meco_private.asc 2>/dev/null
    echo "[+] Llaves GPG inyectadas desde el Vault."
fi

# 2. Configuración de Git (Persistencia de identidad)
git config --global user.name "Samuel Salinas"
git config --global user.email "samuell.secure@gmail.com"
git config --global user.signingkey 5AB6C4A2855F8A2B
git config --global --add safe.directory /root/meco-framework
export GPG_TTY=$(tty)

# 3. Asegurar Git-Secrets (Por si la imagen es nueva)
if ! command -v git-secrets &> /dev/null; then
    echo "[!] Re-instalando git-secrets..."
    git clone https://github.com/awslabs/git-secrets.git /tmp/git-secrets &>/dev/null
    cd /tmp/git-secrets && make install &>/dev/null
    cd /root/meco-framework
    git secrets --install -f &>/dev/null
fi

# 4. Configuración de SSH para GitLab
mkdir -p /root/.ssh
if [ -f "/root/meco-framework/05-vault/id_ed25519" ]; then
    cp /root/meco-framework/05-vault/id_ed25519 /root/.ssh/id_ed25519
    chmod 600 /root/.ssh/id_ed25519
    echo "[+] Llave SSH inyectada correctamente."
fi

# Evitar que pregunte por la autenticidad de GitLab cada vez
echo -e "Host gitlab.com\n\tStrictHostKeyChecking no\n" > /root/.ssh/config

echo "[+] Entorno blindado y listo para firmar commits."
