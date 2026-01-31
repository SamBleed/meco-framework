#!/bin/bash
# MECO Vault - Sistema de Cifrado Táctico
FILE=$1
RECIPIENT="Samuel Salinas (validacion)"

if [ -f "$FILE" ]; then
    echo "[*] Cifrando archivo sensible: $FILE"
    gpg --encrypt --recipient "$RECIPIENT" "$FILE"
    echo "[+] ÉXITO: Archivo cifrado generado como $FILE.gpg"
    echo "[!] Tip: Ahora puedes borrar el original con 'rm $FILE'"
else
    echo "[-] ERROR: El archivo '$FILE' no existe en esta ruta."
fi
