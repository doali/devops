# PROCÉDURE : DOOM EMACS (INSTALLATION, SAUVEGARDE, RESTAURATION)

Ce guide concerne Doom Emacs sur AlmaLinux. La règle d'or de Doom est la séparation entre le moteur (`~/.emacs.d`) et votre configuration (`~/.doom.d`).

---

## 1. PROCESSUS D'INSTALLATION

Avant d'installer Doom, assurez-vous d'avoir Git et Emacs (version 27+) installés.

> /!\\ Sauvegarder l'ancien répertoire si présent !! `mv ~/.emacs.d ~/.emacs.d.bck`

Installer également :
- `yum install fzf`


1. Cloner le dépôt Doom Emacs :
   `git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d`

2. Lancer l'installation :
   `~/.emacs.d/bin/doom install`
   
   > (L'installateur créera votre dossier ~/.doom.d s'il n'existe pas)

3. Ajouter Doom au PATH :
   Ajoutez cette ligne à votre ~/.bashrc :
   `export PATH="$HOME/.emacs.d/bin:$PATH"`


    > Ansin que ce qui suit uniquement si installation viat Flatpak

    ```bash
    # ------------------------------------------------------------------------------
    # EMACS : Flatpak (car repo Alma uniquement en 27.2)
    # Redirection vers l'Emacs de Flatpak
    export EMACS='flatpak run org.gnu.emacs'
    alias emacs='flatpak run org.gnu.emacs'
    ```

---

## 2. PROCESSUS DE SAUVEGARDE
Pour Doom Emacs, vous ne devez sauvegarder QUE votre dossier de configuration privée. Ne sauvegardez pas ~/.emacs.d car il contient des milliers de fichiers de cache volumineux.

Variables de configuration :
- Dossier source : `~/.doom.d`
- Fichiers clés : `init.el`, `config.el`, `packages.el`

Script de sauvegarde (sauvegarde_doom.sh) :

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

echo "🚀 Archivage de la configuration Doom Emacs..."
tar -czf "$DEST_DIR/doom_config_$DATE.tar.gz" -C "$HOME" .doom.d

if [ $? -eq 0 ]; then
    echo "✅ Sauvegarde terminée : $DEST_DIR/doom_config_$DATE.tar.gz"
fi
------------------------------------------
```

## 3. PROCESSUS DE RESTAURATION
En cas de réinstallation complète, suivez cet ordre précis :

1. Restaurer d'abord votre configuration personnelle :
   `tar -xzf /chemin/de/backup/doom_config_DATE.tar.gz -C "$HOME"`

2. Cloner le moteur Doom Emacs (le dossier sera vide de config au départ) :
   `git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d`

3. Lancer la synchronisation :
   `~/.emacs.d/bin/doom sync`
   
   > (Doom verra votre dossier ~/.doom.d existant et téléchargera tous vos paquets automatiquement)

## 4. ASTUCES DE MAINTENANCE
- Appliquer des changements : Chaque fois que vous modifiez `init.el` ou `packages.el`, lancez `doom sync`.
- Diagnostic : Si Doom se comporte bizarrement, lancez `doom doctor`.
- Mise à jour : Pour mettre à jour Doom et vos paquets, lancez `doom upgrade`.
