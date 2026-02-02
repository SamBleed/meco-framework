#!/bin/bash
INTERFACE="enp7s0"
# Ruta absoluta para que funcione como root o usuario
OUTPUT_DIR="/home/sam/Documentos/Projects/meco-framework/06-evidence"
OUTPUT_FILE="$OUTPUT_DIR/capture_$(date +%H%M%S).pcap"

mkdir -p "$OUTPUT_DIR"

echo "📡 Sniffer MECO: Capturando evidencia en $INTERFACE..."
# Captura tráfico en el puerto 8080 (donde está el servidor)
sudo tcpdump -i $INTERFACE port 8080 -n -c 100 -w "$OUTPUT_FILE"
