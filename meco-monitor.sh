#!/bin/bash
TRAP_FILE="$HOME/meco-framework/db_backup.sql.gz"

echo "🐝 HoneyPot IPS Activo: Vigilando y Protegiendo..."

inotifywait -m -e access -e open "$TRAP_FILE" |
while read path action file; do
    echo -e "\n🚨 [CRÍTICO] - ACCESO DETECTADO - BLOQUEANDO..."

    # Simulación de bloqueo: Aquí podrías poner 'sudo ufw deny from IP'
    # Por ahora, cerramos el acceso al archivo para todos como medida de emergencia
    chmod 000 "$TRAP_FILE"

    echo "🔒 Hardening de emergencia aplicado: Permisos de $file revocados (000)."
    notify-send "🚫 ATAQUE DETECTADO" "Acceso a HoneyPot. Archivo bloqueado automáticamente."

    # Guardar en log para tu reporte de SENATI
    echo "$(date) - ACCESO DETECTADO - ACCIÓN: BLOQUEO DE ARCHIVO" >> ~/Documentos/CyberBrain/incidentes_meco.log
done
