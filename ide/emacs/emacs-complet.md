
# Emacs & Doom Emacs — Synthèse complète (vanilla + Doom)

Cette synthèse reprend l’équivalent Emacs/Doom des usages que nous avons vus pour Vim : navigation, édition, buffers/fenêtres, Dired (explorateur), recherche par contenu, recherche par nom de fichier, listes de résultats (compilation/grep/xref ≈ quickfix), extraction/filtrage, registres/kill-ring, macros, et configuration de base. Les raccourcis **Doom Emacs** (leader `SPC`) sont indiqués lorsque pertinents.

> Notation : `C-` = Ctrl, `M-` = Alt/Meta, `S-` = Shift. Sur Mac : `M-` = Option par défaut.

---

## 1) Navigation & déplacements

- **Déplacements basiques** : `C-f` (→), `C-b` (←), `C-n` (↓), `C-p` (↑), `C-a` (début ligne), `C-e` (fin ligne)
- **Mots** : `M-f` (mot suivant), `M-b` (mot précédent)
- **Pages** : `C-v` (page ↓), `M-v` (page ↑)
- **Début/fin buffer** : `M-<` / `M->`
- **Parenthèses appariées (prog)** : `C-M-f` / `C-M-b` (forward/backward-sexp)

**Doom** : `SPC j j` (avy/jump à char/ligne), `SPC s s` (consult-line/affichage interactif), `SPC :` (M-x)

---

## 2) Édition structurée

- **Kill/Yank** : `C-k` (tuer jusqu’à fin de ligne), `M-d` (tuer mot), `C-w` (couper région), `M-w` (copier), `C-y` (coller/yank), `M-y` (cycle du kill-ring)
- **Changements** : `C-d` (suppr char), `M-\` (suppr espaces), `M-^` (joindre lignes), `C-t`/`M-t` (transpose)
- **Répéter** : `C-x z` puis `z z …` (repeat), `C-/` ou `C-_` (undo), `C-g` (annuler la commande en cours)
- **Rectangles (équiv. Visual Block)** : `C-x r k`/`y`/`t`/`o` (rectangle kill/copy/string/open), `C-x r`…

**Doom** : `SPC u` (préfixe universel), `SPC v` (expand-region si activé), `SPC x` (text objects, si modules)

---

## 3) Buffers, fenêtres (windows) et frames

- **Buffers** : `C-x C-b` (liste avec *ibuffer*), `C-x b` (switch-to-buffer), `C-x k` (kill-buffer)
- **Fenêtres (splits)** : `C-x 2` (split horizontal), `C-x 3` (vertical), `C-x 0` (fermer), `C-x 1` (garder celle-ci)
- **Changer de fenêtre** : `C-x o`, redimensionner : `C-x ^`, `C-x {`, `C-x }`
- **Frames (onglets OS)** : `C-x 5 2` (nouvelle frame), `C-x 5 0` (fermer la frame)

**Doom** : `SPC b b` (switch buffer), `SPC b d` (kill), `SPC w /` (split vert), `SPC w -` (split horiz), `SPC w w` (autres fenêtres), `SPC TAB` (alternate buffer)

---

## 4) Dired (équiv. `:Explore`)

- **Ouvrir Dired** : `C-x d` puis entrer un chemin (ou `M-x dired`)
- **Ouvrir un fichier/dossier** : `RET` (entre dans le répertoire), `^` (remonter)
- **Création répertoire/fichier** : `+` (mkdir), `C-x C-f` (créer/visiter fichier)
- **Marquage** : `m` (marquer), `u` (démarquer), `% m` (marquer par motif)
- **Opérations** : `C` (copier), `R` (renommer/déplacer), `D` (supprimer), `Y` (lien symbolique), `Z` (compresser)
- **Lots de fichiers** : marquer avec `m` puis `C`/`R` → choisir la destination (créée si besoin)
- **Affichage** : `(` (toggle détails), `s` (tri), `o` (ouvrir dans autre fenêtre)

**Doom** : `SPC .` (ouvrir Dired du répertoire courant), `SPC f f` (trouver fichier via consult/vertico)

---

## 5) Recherche & substitution

### Recherche incrémentale (buffer)
- **Isearch** : `C-s` (avant), `C-r` (arrière), `M-s .` (mot sous curseur), `M-s o` (occur pour lister résultats)

### Remplacement
- **Query replace** : `M-%` → motif puis remplacement → `y`/`n`/`!`/`.`
- **Regex** : `C-M-%` (query-replace-regexp)

### Recherche projet / multi-fichiers (≈ quickfix feed)
- **Grep/rg** : `M-x rgrep` (grep récursif), `M-x grep` ; `M-x consult-ripgrep` (Doom)
- **Résultats** : *compilation buffer* ou *xref* ; navigation avec `next-error`/`previous-error` (`M-g n` / `M-g p`) ; `RET` pour ouvrir l’occurrence

**Doom** : `SPC /` (ripgrep projet), `SPC s p` (search projet), `SPC s b` (dans buffer), `SPC s l` (consult-line)

---

## 6) “Quickfix” à la Emacs : Compilation/Grep/Xref/Occur

- **Lister des occurrences** :
  - `M-x occur` (dans le buffer courant)
  - `M-x multi-occur-in-matching-buffers` (plusieurs buffers)
  - `M-x grep` / `rgrep` / `consult-ripgrep` (projet)
- **Fenêtre des résultats** : navigation via `M-g n` / `M-g p`, `RET` ouvre le résultat, `q` ferme
- **Recompilation rapide** : `M-x recompile` (réutilise la dernière commande)

**Doom** : `SPC c c` (compile), `SPC c r` (recompile), navigation erreurs `] e` / `[ e` (selon modules)

---

## 7) Extraction/filtrage (équiv. `:global`, `:redir`)

- **Occur (filtrer lignes par regex)** : `M-s o` (occur) en partant d’Isearch, ou `M-x occur` et saisir la regex
  - Le buffer *Occur* listant les lignes correspondantes peut être sauvegardé ou copié ailleurs
- **Narrow/Widen** : `C-x n n` (narrow to region) pour ne travailler que sur un sous‑ensemble, `C-x n w` pour rétablir
- **Keyboard macros** : `C-x (` commence, `C-x )` termine, `C-x e` rejoue (répéter avec `e e …`)

**Doom** : `SPC s o` (occur), `SPC n n` (narrow) si activé, macros : `SPC m k` (selon module :editor macros)

---

## 8) Registres, kill-ring & presse-papiers

- **Kill-ring** : historique des kills/copiers → `M-y` pour parcourir après un `C-y`
- **Registers** : `C-x r s a` (sauver région dans registre `a`), `C-x r i a` (insérer), `C-x r SPC a` (marque position)
- **Système** : sous Linux, `xclip`/`wl-clipboard` ; sur Windows/macOS, l’intégration est native via GUI ou en terminal selon build

**Doom** : `SPC "` (show-kill-ring via consult/vertico), intégration presse‑papiers native

---

## 9) Recherche par **nom de fichier**

- **Ivy/Vertico/Consult/Projectile** (selon config) :
  - `C-x C-f` (find-file) avec complétion évoluée
  - **Doom** : `SPC f f` (find file dans le projet), `SPC f r` (récents), `SPC p p` (switch project), `SPC p f` (fichiers du projet)

---

## 10) Doom Emacs : rappels utiles (leader `SPC`)

- **Fichiers/Projets** : `SPC f f` (fichier), `SPC p p` (projet), `SPC p f` (fichiers projet)
- **Recherche** : `SPC /` (rg projet), `SPC s b` (buffer), `SPC s l` (ligne)
- **Buffers** : `SPC b b` (changer), `SPC b d` (fermer), `SPC TAB` (alternatif)
- **Fenêtres** : `SPC w /` (split V), `SPC w -` (split H), `SPC w w` (autres), `SPC w m` (maximize)
- **Dired** : `SPC .` ; marquer `m`, copier `C`, déplacer `R`, supprimer `D`, créer `+`
- **Compil/Erreurs** : `SPC c c`, `SPC c r`, `] e` / `[ e`

---

## 11) Configuration minimale conseillée (init personnelle)

```elisp
;; --------- UI & confort ---------
(menu-bar-mode -1) (tool-bar-mode -1) (scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(setq inhibit-startup-message t)

;; --------- Recherche/complétion ---------
;; Si pas en Doom, on peut activer isearch+occur par défaut
(define-key isearch-mode-map (kbd "M-s o") 'isearch-occur)

;; --------- Grep par défaut ---------
(setq grep-command "grep -nH -R ")

;; --------- Dired ---------
(setq dired-listing-switches "-alh") ; lisible
(put 'dired-find-alternate-file 'disabled nil) ; RET reste dans la même fenêtre

;; --------- Raccourcis quickfix-like ---------
(global-set-key (kbd "M-g n") 'next-error)
(global-set-key (kbd "M-g p") 'previous-error)
(global-set-key (kbd "C-c o") 'occur)

;; --------- Macros ---------
;; C-x ( / C-x ) / C-x e
```

---

## 12) Pack de 20 commandes à mémoriser (Emacs/Doom)

- Mouvement : `C-a` `C-e` `M-f` `M-b` `M-<` `M->`
- Édition : `C-k` `M-d` `C-y` `M-y` `C-/`
- Buffers/Fenêtres : `C-x b` `C-x k` `C-x 2` `C-x 3` `C-x 0` `C-x 1` `C-x o`
- Dired : `C-x d` `RET` `^` `m` `C` `R` `D` `+`
- Recherche multi : `M-x rgrep` / `consult-ripgrep` ; navigation `M-g n`/`M-g p`
- Occur : `M-x occur` (liste les lignes)
- Doom : `SPC /` `SPC f f` `SPC b b` `SPC w /` `SPC TAB`
```
