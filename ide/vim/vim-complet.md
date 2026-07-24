
# Vim — Synthèse complète (vanilla)

Cette synthèse regroupe tout ce que nous avons vu : navigation, édition, buffers, fenêtres, netrw (`:Explore`), recherches/filtrage, Quickfix, registres, et quelques mappings utiles — le tout en **Vim vanilla**.

---

## 1) Navigation & déplacements

- `h j k l` → gauche / bas / haut / droite
- `w` / `b` → mot suivant / précédent
- `0` / `^` / `$` → début de ligne / 1er non-blanc / fin de ligne
- `gg` / `G` → début / fin de fichier
- `Ctrl-u` / `Ctrl-d` → demi-page haut / bas
- `fX` → aller au caractère `X` dans la ligne ; `;` répète, `,` inverse
- `%` → sauter au bracket apparié `()[]{}`

---

## 2) Opérateurs + mouvements (principe clé)

- `d<motion>` → supprimer selon mouvement (ex. `dw`, `d$`, `dG`)
- `c<motion>` → changer (supprimer + passer en INSERT) (ex. `ci"`, `ci(`, `caw`)
- `y<motion>` → copier (yank)
- `>` / `<` → indenter / désindenter
- Répéter : `.`
- Annuler / Rétablir : `u` / `Ctrl-r`
- Copier/Coller ligne : `yy` / `p`

---

## 3) Les modes indispensables

- **NORMAL** : navigation et commandes
- **INSERT** : `i`, `a`, `o`, `O` ; astuces : `Ctrl-w` (effacer mot), `Ctrl-u` (jusqu’au début)
- **VISUAL** : `v` (caract.), `V` (ligne), `Ctrl-v` (bloc)
- **VISUAL BLOCK** : `Ctrl-v` puis `I` (insertion en colonne), `A` (append en colonne)

---

## 4) Buffers, fenêtres (splits) et onglets

### Buffers
- Lister : `:ls` / `:buffers`
- Aller au buffer n°N : `:b N` (ou `:buffer N`)
- Suivant / Précédent : `:bn` / `:bp`
- Alternatif : `:b#` (ou `Ctrl-^`)

### Fenêtres (splits)
- Split horizontal / vertical : `:split` / `:vsplit`
- Naviguer : `Ctrl-w w` (ou `Ctrl-w h/j/k/l`)
- Fermer la fenêtre (sans fermer le buffer) : `:q` (ou `:hide` si non sauvegardé)
- Garder uniquement la courante : `:only`

---

## 5) netrw (`:Explore`) — ouvrir & naviguer

- Ouvrir l’explorateur : `:Explore`
- Ouvrir le fichier : **Entrée**
- Split horizontal / vertical : `s` / `v`
- Nouvel onglet : `t`
- Monter d’un dossier : `-`
- Rafraîchir : `Ctrl-l`
- Basculer affichage : `i`

> Remarque : netrw **n’intègre pas** de recherche avancée; on utilisera `:find`, `:grep`, `:vimgrep` ou des commandes externes avec quickfix.

---

## 6) Recherches et filtrage

### Recherche interactive dans le buffer (ne remplit pas quickfix)
- `/pattern` (puis `n` / `N`)
- `*` recherche le mot sous le curseur

### Rechercher et envoyer vers **Quickfix**
- Dans le **fichier courant** : `:vimgrep /pattern/ % | copen`
  - ⚠️ Erreur **E499** si `%` est vide (buffer anonyme). Dans ce cas `:w nom`, ou utiliser un fichier temporaire (voir plus bas).
- Dans le **projet** : `:vimgrep /pattern/ **/* | copen`
- Avec **grep** et `grepprg` :
  - `:set grepprg=grep\ -R\ -n\ $*`
  - `:grep "pattern" . | copen`
- Avec **ripgrep** (si installé) : `:set grepprg=rg\ --vimgrep` puis `:grep pattern | copen`

### Quickfix — notions et navigation
- Ouvrir / Fermer : `:copen` / `:cclose` (ex. `:copen 20` pour régler la hauteur)
- Suivant / Précédent : `:cn` / `:cp`
- Entrée sur un item → ouvre le fichier à la ligne correspondante
- Astuce d’auto‑redimensionnement : `autocmd FileType qf resize 15`

### Location List (par fenêtre)
- Variante locale : `:lvimgrep /pattern/ %` + `:lwindow`

---

## 7) Global, substitutions et extraction de lignes

### `:global` pour filtrer
- Afficher les lignes qui commencent par `lib` : `:g/^lib/p`

### Envoyer les **lignes filtrées** dans un **nouveau buffer** (plusieurs méthodes)
1. **Yank dans un registre puis coller** :
   - `:g/^lib/y A`  ← `A` (= append) pour accumuler **toutes** les lignes dans le registre `a`
   - `:enew` puis `"ap` pour coller dans le nouveau buffer
2. **Rediriger la sortie** (inclut l’affichage exact de `:g ...`) :
   - `:redir @a` → `:g/^lib/p` → `:redir END` → `:enew` → `"ap`
3. **Écrire directement dans un fichier** : `:g/^lib/w >> resultat.txt` puis `:e resultat.txt`

### Substitutions utiles
- Tout le fichier : `:%s/foo/bar/g` (avec confirmation `c` → `:%s/foo/bar/gc`)
- Cas particulier (ligne courante) montré : `:s/^lib/p` (affiche la ligne modifiée)

---

## 8) Registres : minuscules vs majuscules

- `"a` (minuscule) : **remplace** le contenu du registre `a`
- `"A` (majuscule) : **ajoute** (append) au registre `a`
- Rappels utiles :
  - `"0` = dernier yank ; `"1..9` = deletions ; `"+` = presse‑papiers système (si compilé `+clipboard`)
  - Vider un registre : `:let @a = ''`

---

## 9) Gérer l’erreur `E499` (Empty file name for "%" or "#")

- Cause : buffer **sans nom** (`%` vide) ou pas de *fichier alternatif* (`#`).
- Correctifs :
  1) `:w mon_fichier.txt` puis relancer `:vimgrep /motif/ %`
  2) Utiliser le chemin : `:vimgrep /motif/ %:p`
  3) Sans sauvegarder :
     ```vim
     :let tmp = tempname()
     :execute 'write ' . tmp
     :execute 'vimgrep /motif/ ' . tmp
     :copen
     ```
  4) Si tu viens d’`:Explore` : ouvre d’abord le fichier (Entrée), puis lance la recherche.

---

## 10) `:find` pour rechercher par nom de fichier

- Activer la recherche récursive : `:set path+=**` (et `:set wildmenu` pour une meilleure complétion)
- Chercher et ouvrir : `:find nom`, `:find *serve*`
- Ouvrir en split : `:sfichier` / `:vfichier`

---

## 11) Quickfix — mappings pratiques

```vim
" Taille et ouverture
command! -nargs=? Copen copen <args>
autocmd FileType qf resize 15
nnoremap <leader>q :copen 15<CR>
nnoremap <leader>Q :cclose<CR>
nnoremap ]q :cn<CR>
nnoremap [q :cp<CR>

" Chercher le mot sous le curseur dans le fichier courant
nnoremap <leader>s :if empty(expand('%'))<Bar>echo 'Pas de nom de fichier (E499). :w d\'abord ou tmp'<Bar>else<Bar>execute 'vimgrep /'.escape(expand('<cword>'), '/\').'/ %'<Bar>copen<Bar>endif<CR>
```

---

## 12) Réglages “vanilla” conseillés (`~/.vimrc`)

```vim
set number
set relativenumber        " (optionnel)
set hlsearch
set incsearch
set smartcase
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set wildmenu
set path+=**              " pour :find
" grep rapide (UNIX)
set grepprg=grep\ -R\ -n\ $*
```

---

## 13) Mini pack de 20 commandes à mémoriser

- `gg` / `G` ; `0` `^` `$` ; `w` `b` ; `fX` `;` `,`
- `d<motion>` / `c<motion>` / `.` / `u` / `Ctrl-r` / `yy` / `p`
- `/texte` / `*` / `:%s/foo/bar/g`
- `:ls` / `:b N` / `:bn` / `:bp` / `:b#`
- `:split` / `:vsplit` / `Ctrl-w w` / `:q`
- `:vimgrep /pattern/ % | copen` / `:grep -R pattern . | copen`
- `:g/^lib/y A | :enew | "ap`
```
