#!/bin/bash
# 🛡️ Activador de entorno MECO-Framework
# Uso: source load_env.sh

export MECO_PATH=$(pwd)

alias meco-kali='docker run --rm -it --hostname kali-meco --name kali-meco \
  --tmpfs /tmp:rw,noexec,nosuid,size=2g \
  -v "$MECO_PATH":/root/meco-framework \
  registry.gitlab.com/sambleed/meco-framework:latest'

echo "---------------------------------------------------"
echo "✅ Entorno MECO cargado correctamente."
echo "🚀 Usa 'meco-kali' para iniciar el laboratorio."
echo "---------------------------------------------------"
