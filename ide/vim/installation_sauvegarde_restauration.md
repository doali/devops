# PROCÉDURE : VIM (INSTALLATION, SAUVEGARDE, RESTAURATION)

Vim est souvent déjà installé sur AlmaLinux, mais cette procédure assure une configuration complète avec gestion des plugins.

---

## 1. PROCESSUS D'INSTALLATION
Pour une expérience optimale, nous installons Vim et un gestionnaire de plugins (Vim-Plug).

1. Installer Vim (si absent) :
   `sudo dnf install vim -y`

2. Installer Vim-Plug (Gestionnaire de plugins) :

   ```bash
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

---

## 2. PROCESSUS DE SAUVEGARDE
La configuration de Vim repose sur deux éléments principaux : le fichier de réglages et le dossier des données.

Fichiers à sauvegarder :
- Fichier source : `~/.vimrc` (contient vos réglages et la liste des plugins)
- Dossier source : `~/.vim` (contient les plugins, les thèmes et l'autoload)

Script de sauvegarde (`sauvegarde_vim.sh`) :

```bash
------------------------------------------
#!/bin/bash
if [[ -z "$1" ]]; then
    echo "❌ Erreur : Chemin de destination manquant."
    echo "Usage : bash $0 /chemin/de/backup"
    exit 1
fi
DEST_DIR="${1%/}"
DATE=$(date +%Y-%m-%d)
mkdir -p "$DEST_DIR"

echo "🚀 Archivage de la configuration Vim..."
# Sauvegarde du fichier .vimrc et du dossier .vim
tar -czf "$DEST_DIR/vim_config_$DATE.tar.gz" -C "$HOME" .vimrc .vim 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Sauvegarde terminée : $DEST_DIR/vim_config_$DATE.tar.gz"
else
    echo "⚠️ Certains fichiers étaient absents, archive créée avec les éléments trouvés."
fi
------------------------------------------
```

## 3. PROCESSUS DE RESTAURATION

Pour retrouver votre environnement Vim sur une nouvelle machine :

1. Restaurer les fichiers de configuration :

   `tar -xzf /chemin/de/backup/vim_config_DATE.tar.gz -C "$HOME"`

2. Installer les plugins répertoriés dans le .vimrc :

   Ouvrez Vim : `vim` \
   Puis tapez la commande suivante à l'intérieur de Vim : `:PlugInstall`

## 4. ASTUCES DE MAINTENANCE
- Modifier la config : Après avoir ajouté un plugin dans le `.vimrc`, relancez `:PlugInstall`.
- Nettoyer les plugins : Si vous retirez un plugin du `.vimrc`, lancez `:PlugClean` dans Vim pour supprimer les fichiers inutiles.
- Aide : Utilisez `:help` suivi d'un sujet pour accéder à la documentation interne de Vim.