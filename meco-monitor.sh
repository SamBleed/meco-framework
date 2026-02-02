#!/bin/bash
TRAP_FILE="/home/sam/meco-framework/db_backup.sql.gz"

echo "🐝 Monitor de Respuesta Activa [ON]"
echo "🔎 Esperando intrusos en $TRAP_FILE..."

# Usamos lsof para identificar quién toca el archivo en tiempo real
inotifywait -m -e access -e open -e modify "/home/sam/meco-framework/db_backup.sql.gz" |
while read path action file; do
    # 1. Intentamos capturar el PID (si es muy rápido, lsof puede fallar)
    ATTACKER_PID=$(lsof -t "$TRAP_FILE")

    # 2. Si lsof no lo pilló, buscamos al servidor Python en el puerto 8080
    if [ -z "$ATTACKER_PID" ]; then
        ATTACKER_PID=$(lsof -t -i:8080)
    fi

    # 3. Solo ejecutamos ps si tenemos un PID válido para evitar el error de sintaxis
    if [ ! -z "$ATTACKER_PID" ]; then
        ATTACKER_NAME=$(ps -p $ATTACKER_PID -o comm=)
    else
        ATTACKER_NAME="Desconocido (Rápido)"
    fi

    echo -e "\n🚨 [ALERTA SOC] - INTRUSIÓN DETECTADA - 🚨"
    echo "🎯 PROCESO IDENTIFICADO: $ATTACKER_PID ($ATTACKER_NAME)"

    # 4. Lanzar el sniffer usando RUTA ABSOLUTA para que sudo lo encuentre
    bash /home/sam/Documentos/Projects/meco-framework/bin/meco-sniff.sh &
done
