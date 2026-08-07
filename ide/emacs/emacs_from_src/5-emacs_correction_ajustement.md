# 5. Corrections, Ajustements et Retours d'Expèrience

Ce document récapitule les problèmes rencontrés lors de l'installation et de la configuration de Doom Emacs (sous AlmaLinux / RHEL), ainsi que les solutions définitives apportées.

---

## 1. Résolution des problèmes de polices (Symbola & Icônes)

### Problème
Certains caractères spéciaux ou symboles graphiques ne s'affichaient pas correctement dans Emacs ou Treemacs.

### Solution
1. **Installation de la police Symbola :**
   * Télécharger : `https://github.com/zhm/symbola/blob/master/fonts/Symbola.ttf`
   * Têlécharger et placer le fichier `Symbola.ttf` dans `~/.local/share/fonts/`.
2. **Mise à jour du cache Fontconfig :**
   ```bash
   fc-cache -fv
   ```
3. **Vérification dans le terminal :**
   ```bash
   fc-list | grep -i symbola
   ```
4. **Intégration Doom Emacs :** La police est automatiquement dêtectée par Doom (`Found Symbols Nerd Font Mono` / Symbola) lors du diagnostic `doom doctor`.

> Par ailleurs la police HackNerd est à privilégier. La police Symbola est la police utilisée en secours par Doom.

---

## 2. Recompilation intempestive de `vterm` (`SPC o T`)

### Problème
A chaque ouverture du terminal `vterm` via `SPC o T`, Doom Emacs demandait de recompiler le module dynamique (`vterm-module.so`).

### Cause
Emacs était lancé dans un environnement shell dont les variables (`PATH`, compilateurs C, etc.) différaient de l'environnement de compilation initial. Doom ne trouvait pas le binaire `.so` généré.

### Solution
Synchroniser l'environnement du shell dans Doom Emacs :
```bash
doom sync -e
```

> Note : La commande `doom sync -e` (ou `doom sync --env`) capture les variables d'environnement actives pour qu'Emacs les réutilise à chaque démarrage.*

---

## 3. Gestion multi-environnements & Proxys (EDF / Thales / Perso)

### Configuration
Usage de la variable d'environnement `EMACS_ENV` associée à un bloc `pcase` au début du `config.el` pour configurer dynamiquement :
 "L'identité utilisateur (`user-full-name`, `user-mail-address`).
  Les proys HTTP/HTTPS pour Emacs (`url-proxy-services`) et pour les sous-processus (`HTTP_PROXY`, `HTTPS_PROXY`).
  Les exceptions de proxy (`NO_PROXY`i/ `no_proxy` et `url-gateway-local-host-regexp` pour préserver Ollama/local).
  Les certificats SSL (`NODE_EXTRA_CA_CERTS`) et la désactivation du contrôle strict GnuTLS sous proxy d'entreprise.

### Basculement d'environnement
Pour changer d'entreprise ou passer en mode perso :
```bash
# Exemple pour EDF
export EMACS_ENV="edf"
doom sync -e

# Exemple pour Thales
export EMACS_ENV="thales"
doom sync -e
```

---

## 4. Structuration des raccourcis d'ouverture (`SPC e ...`)

### Problème de conflit de clés
Le sous-menu Thales a été assigné à la touche ``h`` (`SPC e h ...`) au lieu de ``t`` afin d'éviter tout conflit avec le préfixe natif ``t`` dédié à `vterm` dans Doom Emacs.

### Arborescence finale dess raccourcis
* **`SPC e e ...` :** Outils & Portails EDF (Gemini CLI, Gitlab, Outlook, Copilot, etc.)
*`**`SPC e h ...` :** Outils & Portails Thales (Portail, Outlook)

---

## 5. Isolation des sessions Web (Double compte Outlook EDF / Thales)

### Problème
L'ouverture simultanée de deux sessions Microsoft 365 (EDF et Thales) via `browse-url` provoquait des conflits de cookies dans Firefox.

### Solution
 * **EDF :** Ouverture standard via le navigateur par défaut (gbrowse-url).
 * **Thales :** Lancement de Firefox en mode fenêtre privée via `call-process` :
   ``celisp
   (call-process "firefox" nil 0 nil "--private-window" "https://...")
   ``
---

## 7. Commandes de maintenance essentielles
* **Vérifier l'etat de santé de l'installation :**
   ```bash
   doom doctor
   ```
 * **Recompiler/Synchroniser après modification du `config.el` ou changement d'environnement :**
   ```bash
   doom sync -e
   ```
* **Purger un build de paquet défectueux (ex: `vterm`) :**
   ```bash
   rm -rf ~/.config/emacs/.local/straight/build-*/vterm
   doom sync -e
   ```
