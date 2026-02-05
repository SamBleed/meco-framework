#!/bin/bash
# 🛡️ MECO-Engine: Restauración de Entorno Táctico (v3.0-SSH-GPG)

echo "[*] Configurando identidad MECO en modo Criptográfico..."

# 1. Restaurar GPG (Importar llaves desde el Vault y el Root)
if [ -f "/root/meco-framework/05-vault/meco_private.asc" ]; then
    gpg --import /root/meco-framework/05-vault/meco_private.asc 2>/dev/null
    echo "[+] Llaves GPG privadas inyectadas."
fi
if [ -f "/root/meco-framework/sambleed.pub" ]; then
    gpg --import /root/meco-framework/sambleed.pub 2>/dev/null
    echo "[+] Identidad pública vinculada."
fi

# 2. Configuración de Git (Persistencia y Seguridad)
git config --global user.name "Samuel Salinas"
git config --global user.email "samuell.secure@gmail.com"
git config --global user.signingkey 422655E8A5A6B377
git config --global commit.gpgsign true  # <--- Obligar a firmar siempre
git config --global --add safe.directory /root/meco-framework

# FORZAR REMOTO SSH (Para evitar el error 403 del Token HTTPS)
git remote set-url origin git@gitlab.com:SamBleed/meco-framework.git

export GPG_TTY=$(tty)

# 3. Asegurar Git-Secrets
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
    echo "[+] Llave SSH ED25519 inyectada."
fi

# Configuración de confianza SSH
echo -e "Host gitlab.com\n\tStrictHostKeyChecking no\n\tIdentityFile /root/.ssh/id_ed25519\n" > /root/.ssh/config

# === MOTOR DE SINCRONIZACIÓN MECO ===
meco-sync() {
    echo "[*] Aplicando capas de seguridad..."
    git secrets --scan
    if [ $? -eq 0 ]; then
        echo "[+] Escaneo limpio. Preparando commit firmado criptográficamente..."
        git add .
        # El flag -S usa la llave definida en user.signingkey
        git commit -S -m "sync: actualización de laboratorio $(date +'%Y-%m-%d %H:%M')"

        echo "[*] Subiendo cambios a GitLab vía SSH..."
        git push origin main
        echo "[+] Sincronización blindada completada con éxito. 🛡️"
    else
        echo "[!] ERROR: Se detectaron posibles secretos. Commit abortado."
    fi
}

echo "[+] Entorno blindado y listo para el despliegue táctico."
