# PROCÉDURE : SAUVEGARDE ET RESTAURATION VS CODE

Cette procédure permet de mettre à l'abri votre configuration (settings, raccourcis, snippets) et votre liste d'extensions sur AlmaLinux.

## 1. LE SCRIPT DE SAUVEGARDE

Créez un fichier nommé `sauvegarde_conf_vscode.sh` :

```bash
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
```

## 2. LE SCRIPT DE RESTAURATION

Créez un fichier nommé `restaure_conf_vscode.sh` :

```bash
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
```

## 3. MODE D'EMPLOI

### Préparation

Rendre les deux scripts exécutables sur votre système :

```bash
chmod +x sauvegarde_conf_vscode.sh restaure_conf_vscode.sh
```

#### Exécuter une sauvegarde

Vous devez fournir le dossier de destination (local, disque externe ou dossier synchronisé) :

```bash
./sauvegarde_conf_vscode.sh ~/Documents/Backups/VSCode
```

#### Exécuter une restauration

Indiquez le dossier contenant vos sauvegardes. Le script sélectionnera automatiquement la plus récente :

```bash
./restaure_conf_vscode.sh ~/Documents/Backups/VSCode
```