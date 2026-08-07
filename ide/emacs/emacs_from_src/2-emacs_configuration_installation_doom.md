# Post-Installation : Déploiement et configuration de Doom Emacs (~/.emacs.d)

Une fois Emacs 30.2 compilé et installé, exécutez ces étapes pour installer Doom Emacs dans le répertoire classique ~/.emacs.d.

---

## Étape 1 : Nettoyage préalable
Suppression de toute ancienne configuration pour repartir sur une base propre.

rm -rf ~/.emacs.d ~/.doom.d

---

## Étape 2 : Clonage du dépôt Doom Emacs
Clonage directement dans le répertoire traditionnel ~/.emacs.d.

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

---

## Étape 3 : Installation interactive de Doom
Exécution du script d'installation depuis ~/.emacs.d.

~/.emacs.d/bin/doom install

---

## Étape 4 : Vérification de l'installation et du diagnostic
Vérification que la version d'Emacs est bien la 30.2 et contrôle des dépendances.

# 1. Vérifier la version d'Emacs
emacs --version

# 2. Lancer le diagnostic Doom (vérifie que l'environnement est optimal)
~/.emacs.d/bin/doom doctor

