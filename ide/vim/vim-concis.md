
# Vim — Synthèse concise (cheatsheet)

> Raccourcis et commandes **vanilla** les plus utiles au quotidien.

## Navigation
| Action | Touche |
|---|---|
| Début/Fin fichier | `gg` / `G` |
| Début/Fin ligne | `0` / `^` / `$` |
| Mot suivant / précédent | `w` / `b` |
| Aller au caractère X ; répéter ; inverser | `fX` ; `;` ; `,` |
| Bracket apparié | `%` |
| Demi‑page haut/bas | `Ctrl-u` / `Ctrl-d` |

## Édition
| Action | Touche |
|---|---|
| Supprimer selon mouvement | `d<motion>` |
| Changer selon mouvement | `c<motion>` |
| Répéter dernière action | `.` |
| Undo / Redo | `u` / `Ctrl-r` |
| Copier ligne / Coller | `yy` / `p` |
| Visual / Ligne / Bloc | `v` / `V` / `Ctrl-v` |
| Bloc : insertion / append | `I` / `A` (après `Ctrl-v`) |

## Buffers & Fenêtres
| Action | Commande |
|---|---|
| Lister buffers | `:ls` |
| Aller au buffer n°N | `:b N` |
| Suivant / Précédent | `:bn` / `:bp` |
| Alternatif | `:b#` (ou `Ctrl-^`) |
| Split H / V | `:split` / `:vsplit` |
| Changer de fenêtre | `Ctrl-w w` |
| Fermer la fenêtre | `:q` |
| Garder uniquement | `:only` |

## netrw (`:Explore`)
| Action | Touche |
|---|---|
| Ouvrir | `:Explore` |
| Ouvrir le fichier | **Entrée** |
| Split H / V | `s` / `v` |
| Nouvel onglet | `t` |
| Monter d’un dossier | `-` |
| Rafraîchir | `Ctrl-l` |

## Rechercher (buffer) & Substituer
| Objectif | Commande |
|---|---|
| Rechercher dans le buffer | `/pattern` ; `n` / `N` |
| Mot sous curseur | `*` |
| Substituer fichier entier | `:%s/foo/bar/g` (ajoute `c` pour confirmer) |

## Quickfix (QF)
| Objectif | Commande |
|---|---|
| Chercher dans fichier courant → QF | `:vimgrep /pattern/ % \| copen` |
| Chercher dans projet → QF | `:vimgrep /pattern/ **/* \| copen` |
| Grep (UNIX) → QF | `:grep -R pattern . \| copen` |
| Ouvrir / Fermer QF | `:copen` / `:cclose` |
| Naviguer (suiv./préc.) | `:cn` / `:cp` |
| Redimensionner QF | `:copen 20` ou `:resize 20` dans QF |

## Location List (locale à la fenêtre)
| Objectif | Commande |
|---|---|
| Remplir & ouvrir | `:lvimgrep /pattern/ %` ; `:lwindow` |

## `:find` (recherche par nom)
| Étape | Commande |
|---|---|
| Activer la recherche récursive | `:set path+=**` (et `:set wildmenu`) |
| Chercher / ouvrir | `:find nom` (Tab pour compléter) |
| Ouvrir en split | `:sfichier` / `:vfichier` |

## `:global` & Extraction
| Objectif | Commande |
|---|---|
| Lignes commençant par `lib` | `:g/^lib/p` |
| Collecter lignes → nouveau buffer | `:g/^lib/y A` → `:enew` → `"ap` |
| Redirection (texte affiché) | `:redir @a` → `:g/^lib/p` → `:redir END` → `:enew` → `"ap` |
| Écrire direct dans un fichier | `:g/^lib/w >> resultat.txt` |

## Registres
| Info | Détail |
|---|---|
| Minuscule vs Majuscule | `"a` remplace / `"A` ajoute (append) |
| Registres utiles | `"0` (dernier yank), `"1..9` (deletions), `"+` (presse‑papiers) |
| Vider un registre | `:let @a = ''` |

## E499 ("%" vide)
| Situation | Solution |
|---|---|
| Buffer sans nom | `:w nom_de_fichier` puis relancer |
| Sans sauvegarder | écrire vers `tempname()` puis `:vimgrep` dessus |
| Depuis netrw | ouvrir d’abord un fichier (Entrée), puis chercher |

## Réglages conseillés (`~/.vimrc`)
| Objet | Réglage |
|---|---|
| Numéros & recherche | `set number` · `set relativenumber` · `set hlsearch` · `set incsearch` · `set smartcase` |
| Indentation & tabs | `set expandtab` · `set shiftwidth=4` · `set tabstop=4` · `set autoindent` |
| Complétion & path | `set wildmenu` · `set path+=**` |
| Grep (UNIX) | `set grepprg=grep\ -R\ -n\ $*` |
