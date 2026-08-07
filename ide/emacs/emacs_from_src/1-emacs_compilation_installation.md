# Guide de compilation : Emacs 30.2 (Wayland / PGTK) sur AlmaLinux 9

Ce guide prépare le système avec tous les dépôts nécessaires (EPEL, CRB), installe les dépendances graphiques et de compilation native (libgccjit), puis compile Emacs 30.2 optimisé pour Wayland et Doom Emacs.

---

## Étape 1 : Activation des dépôts système
Préréquis indispensable sous AlmaLinux 9. Activer le dépôt CRB (Code Ready Builder) et EPEL pour accéder aux paquets de développement (libgccjit-devel, gnutls-devel, etc.).

# Activation du dépôt CRB (anciennement PowerTools)
sudo dnf config-manager --set-enabled crb

# Installation du dépôt EPEL
sudo dnf install -y epel-release

# Rafraîchissement des métadonnées DNF
sudo dnf makecache

---

## Étape 2 : Installation des dépendances de compilation
Installe l'environnement de compilation (gcc, make), les en-têtes Wayland/GTK3, les outils requis par Doom Emacs (ripgrep, fd), ainsi que les dépendances système (GnuTLS, libgccjit, ncurses).

# 1. Outils de build de base
sudo dnf install -y gcc make pkgconfig wget

# 2. Support de la compilation native (AOT/JIT)
sudo dnf install -y libgccjit-devel

# 3. Interfaces graphiques PGTK / Wayland & moteur de rendu SVG/Cairo
sudo dnf install -y gtk3-devel glib2-devel cairo-devel librsvg2-devel

# 4. Sécurité, terminal et formats d'images (GnuTLS obligatoire pour ELPA/MELPA)
sudo dnf install -y gnutls-devel ncurses-devel giflib-devel libxml2-devel gpm-devel

# 5. Outils essentiels pour Doom Emacs (recherche rapide de fichiers et texte)
sudo dnf install -y ripgrep fd-find fzf

---

## Étape 3 : Téléchargement et extraction des sources Emacs 30.2
Télécharge l'archive officielle des sources d'Emacs 30.2 et extrait le dossier de travail.

# Téléchargement de l'archive officielle
wget https://ftp.gnu.org/gnu/emacs/emacs-30.2.tar.gz

# Extraction de l'archive
tar -xvf emacs-30.2.tar.gz

# Se placer dans le répertoire des sources
cd emacs-30.2

---

## Étape 4 : Configuration du build (Script ./configure optimisé PGTK)
Exécution du `./configure` avec le support Pure GTK (Wayland natif) et compilation native d'Emacs Lisp (aot).

./configure \
  --with-pgtk \
  --with-cairo \
  --with-rsvg \
  --with-native-compilation=aot \
  --with-tree-sitter=ifavailable \
  --with-xml2 \
  --with-modules \
  --with-threads \
  --with-gpm

* Notes sur les options retenues :
  - --with-pgtk : Support Pure GTK pour Wayland natif (évite XWayland).
  - --with-native-compilation=aot : Compile les paquets Elisp en binaire natif au préalable pour des performances maximales.
  - --with-tree-sitter=ifavailable : Permet la coloration syntaxique basée sur AST sans bloquer si la lib système est absente.

---

## Étape 5 : Compilation et installation
Lance la compilation multi-cœur puis installe les binaires dans /usr/local/bin.

# Compilation parallèle utilisant l'ensemble des cœurs processeur
make -j$(nproc)

# Installation sur le système
sudo make install

# Vérification de la version installée
emacs --version

---

## Post-Installation : Déploiement de Doom Emacs

Une fois Emacs 30.2 installé, exécute la séquence classique pour installer Doom :

# 1. Nettoyage d'éventuelles anciennes configurations
rm -rf ~/.config/emacs ~/.emacs.d ~/.doom.d

# 2. Clonage du dépôt Doom Emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs

# 3. Lancement du script d'installation de Doom
~/.config/emacs/bin/doom install

# 4. Ajout de Doom au PATH dans votre shell
echo 'export PATH="$HOME/.config/emacs/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

