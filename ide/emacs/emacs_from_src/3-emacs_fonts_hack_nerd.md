# Installation des polices et icônes pour Doom Emacs (Nerd Fonts)

Si vous observez des caractères bizarres ou des icônes manquantes dans Doom Emacs (flèches de la barre d'état, symboles Git, arborescence de fichiers), cela signifie que la police d'icônes n'est pas installée sur le système.

Doom Emacs utilise désormais `nerd-icons` (basé sur Nerd Fonts) par défaut.

---

## Méthode 1 : Automatique depuis Doom Emacs (Recommandée)

C'est la méthode la plus simple si vous êtes dans l'interface d'Emacs.

### 1. Télécharger et installer la police d'icônes
1. Lancez Doom Emacs.
2. Ouvrez le prompt de commandes avec `SPC :` (en mode Evil) ou `M-x`.
3. Exécutez la commande suivante :
   nerd-icons-install-fonts
4. Appuyez sur `Entrée` pour valider l'emplacement d'installation par défaut.

### 2. Appliquer les changements
Pour recharger la police sans redémarrer Emacs :
1. Tapez `SPC :` ou `M-x`.
2. Exécutez :
   doom/reload-font

---

## Méthode 2 : Manuelle via le Terminal (Hack Nerd Font)

Si vous souhaitez installer la police Hack Nerd Font (qui contient à la fois les caractères monospace de code et les icônes) directement depuis la ligne de commande système :

### 1. Téléchargement et extraction

# 1. Créer le dossier de destination des polices utilisateur
mkdir -p ~/.local/share/fonts/HackNerd

# 2. Se placer dans /tmp pour le téléchargement
cd /tmp

# 3. Télécharger la dernière version de Hack Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip

# 4. Décompresser dans le dossier dédié
unzip -o Hack.zip -d ~/.local/share/fonts/HackNerd

# 5. Mettre à jour le cache des polices du système
fc-cache -fv

### 2. (Optionnel) Définir la police dans la configuration Doom
Pour forcer Doom Emacs à utiliser cette police spécifique, ajoutez ceci dans votre fichier `~/.doom.d/config.el` (ou `~/.config/doom/config.el`) :

(setq doom-font (font-spec :family "Hack Nerd Font" :size 14 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 14))

Puis appliquez dans Doom Emacs via `M-x doom/reload-font` ou exécutez `doom sync` dans votre terminal.

