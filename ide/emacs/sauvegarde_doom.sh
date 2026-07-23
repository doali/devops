#!/bin/bash
# ------------------------------------------------------------
# Sauvegarde des trois fichiers de configuration de Doom Emacs
# - config.el
# (- custom.el)
# - init.el
# - packages.el
# présents dans le répertoire ~/.doom.d/
# Thu 23 Jul 06:41:06 CEST 2026
# ------------------------------------------------------------

if [[ -z "$1" ]]; then
    echo "❌ Erreur : Chemin de destination manquant."
    echo "Usage : bash $0 /chemin/de/backup"
    exit 1
fi
DEST_DIR="${1%/}"
DATE=$(date +%Y-%m-%d)
mkdir -p "$DEST_DIR"

echo "🚀 Archivage de la configuration Doom Emacs..."
tar -czf "$DEST_DIR/doom_config_$DATE.tar.gz" -C "$HOME" .doom.d

if [ $? -eq 0 ]; then
    echo "✅ Sauvegarde terminée : $DEST_DIR/doom_config_$DATE.tar.gz"
fi
