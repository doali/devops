#!/bin/bash

# ==============================================================================
# VARIABLES DE CONFIGURATION
# ==============================================================================
VSCODE_USER_DIR="$HOME/.config/Code/User"
EXT_LIST_NAME="extensions_list.txt"

# ==============================================================================
# CONTRÔLES ET ARGUMENTS
# ==============================================================================
# Vérification du passage du chemin de backup en argument
if [ -z "$1" ]; then
    echo "❌ Erreur : Aucun dossier de backup spécifié."
    echo "Usage : $0 /chemin/vers/ton_dossier_de_backup"
    exit 1
fi

BACKUP_PATH="$1"

# Vérifier si le dossier de backup existe
if [ ! -d "$BACKUP_PATH" ]; then
    echo "❌ Erreur : Le dossier de backup n'existe pas ($BACKUP_PATH)."
    exit 1
fi

# Identifier l'archive la plus récente dans le dossier
ARCHIVE_FILE=$(ls -t "$BACKUP_PATH"/vscode_backup_*.tar.gz 2>/dev/null | head -n 1)

if [ -z "$ARCHIVE_FILE" ]; then
    echo "❌ Erreur : Aucune archive .tar.gz trouvée dans $BACKUP_PATH"
    exit 1
fi

# Créer le dossier VS Code s'il n'existe pas encore
mkdir -p "$VSCODE_USER_DIR"

# ==============================================================================
# EXÉCUTION
# ==============================================================================
echo "🔄 Restauration depuis : $BACKUP_PATH"

# 1. Restauration des fichiers de configuration
echo "📂 Désarchivage de $(basename "$ARCHIVE_FILE")..."
tar -xzf "$ARCHIVE_FILE" -C "$VSCODE_USER_DIR"

# 2. Réinstallation des extensions
if [ -f "$BACKUP_PATH/$EXT_LIST_NAME" ]; then
    echo "📦 Réinstallation des extensions (cela peut prendre du temps)..."
    cat "$BACKUP_PATH/$EXT_LIST_NAME" | xargs -L 1 code --install-extension
else
    echo "⚠️ Attention : Liste d'extensions introuvable."
fi

echo "✅ Restauration terminée ! Relancez VS Code pour appliquer les changements."
