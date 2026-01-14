#!/bin/bash

# ==============================================================================
# VARIABLES DE CONFIGURATION
# ==============================================================================
VSCODE_USER_DIR="$HOME/.config/Code/User"
FILES_TO_BACKUP=("settings.json" "keybindings.json" "snippets")
DATE=$(date +%Y-%m-%d_%Hh%M)
EXT_LIST_NAME="extensions_list.txt"

# ==============================================================================
# CONTRÔLES ET ARGUMENTS
# ==============================================================================

# DEBUG : Décommentez la ligne suivante si le problème persiste
# echo "Argument reçu : '$1'"

if [[ -z "$1" ]]; then
    echo "❌ Erreur : Aucun chemin de destination spécifié."
    echo "Usage : bash $0 /chemin/vers/dossier_de_backup"
    exit 1
fi

# On nettoie le chemin (enlève les slashs de fin inutiles)
DEST_DIR="${1%/}"
ARCHIVE_NAME="vscode_backup_$DATE.tar.gz"

if [ ! -d "$VSCODE_USER_DIR" ]; then
    echo "❌ Erreur : Dossier VS Code introuvable ($VSCODE_USER_DIR)."
    exit 1
fi

mkdir -p "$DEST_DIR"

# ==============================================================================
# EXÉCUTION
# ==============================================================================
echo "🚀 Démarrage de la sauvegarde dans : $DEST_DIR"

# 1. Sauvegarde des extensions
echo "📦 Extraction de la liste des extensions..."
code --list-extensions > "$DEST_DIR/$EXT_LIST_NAME" 2>/dev/null

# 2. Création de l'archive
echo "📂 Archivage des fichiers..."
tar -czf "$DEST_DIR/$ARCHIVE_NAME" -C "$VSCODE_USER_DIR" "${FILES_TO_BACKUP[@]}"

if [ $? -eq 0 ]; then
    echo "✅ Sauvegarde terminée : $DEST_DIR/$ARCHIVE_NAME"
else
    echo "❌ Erreur lors de l'archivage."
    exit 1
fi
