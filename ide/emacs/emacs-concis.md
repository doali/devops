
# Emacs & Doom Emacs — Synthèse concise (cheatsheet)

> Raccourcis **vanilla** + équivalents **Doom (SPC)**.

## Navigation
| Action | Emacs | Doom |
|---|---|---|
| Début/fin ligne | `C-a` / `C-e` | — |
| Mot suivant/précédent | `M-f` / `M-b` | — |
| Début/fin buffer | `M-<` / `M->` | — |
| Page ↓ / ↑ | `C-v` / `M-v` | — |
| Aller à sexp (prog) | `C-M-f` / `C-M-b` | — |
| Jump rapide | `avy`/`consult-line` | `SPC j j` / `SPC s l` |

## Édition
| Action | Emacs | Doom |
|---|---|---|
| Couper, copier, coller | `C-w`, `M-w`, `C-y` | `SPC "+` (kill-ring), `C-y` |
| Cycle kill-ring | `M-y` | `SPC "` (show-kill-ring) |
| Supprimer jusqu’à fin ligne | `C-k` | — |
| Undo | `C-/` | `C-/` |
| Rectangles | `C-x r`… | — |

## Buffers & Fenêtres
| Action | Emacs | Doom |
|---|---|---|
| Switch buffer / tuer | `C-x b` / `C-x k` | `SPC b b` / `SPC b d` |
| Splits H / V | `C-x 2` / `C-x 3` | `SPC w -` / `SPC w /` |
| Fermer / seulement cette | `C-x 0` / `C-x 1` | `SPC w d` / `SPC w m` |
| Changer de fenêtre | `C-x o` | `SPC w w` |

## Dired (explorateur)
| Action | Emacs | Doom |
|---|---|---|
| Ouvrir Dired | `C-x d` | `SPC .` |
| Entrer / Parent | `RET` / `^` | idem |
| Marquer / Démarquer | `m` / `u` | idem |
| Copier / Déplacer | `C` / `R` | idem |
| Supprimer / Créer dir | `D` / `+` | idem |

## Recherche (buffer) & Substitution
| Objectif | Emacs | Doom |
|---|---|---|
| Isearch avant / arrière | `C-s` / `C-r` | idem |
| Occur (lister lignes) | `M-x occur` / `M-s o` | `SPC s o` |
| Query-replace (regex) | `M-%` (`C-M-%`) | idem |

## Multi-fichiers (≈ Quickfix)
| Objectif | Emacs | Doom |
|---|---|---|
| Grep récursif | `M-x rgrep` | `SPC /` (ripgrep) |
| Ouvrir un résultat | `RET` | `RET` |
| Suiv./préc. erreur | `M-g n` / `M-g p` | `] e` / `[ e` (selon modules) |

## Recherche par nom de fichier
| Objectif | Emacs | Doom |
|---|---|---|
| Ouvrir fichier | `C-x C-f` | `SPC f f` |
| Fichiers projet | `project-find-file` | `SPC p f` / `SPC p p` |

## Extraction / Filtrage
| Objectif | Emacs | Doom |
|---|---|---|
| Lister lignes par motif | `M-x occur` | `SPC s o` |
| Restreindre à une région | `C-x n n` / `C-x n w` | `SPC n n` (si activé) |
| Macros clavier | `C-x (` / `C-x )` / `C-x e` | `SPC m k` (selon modules) |

## Réglages utiles
| Objet | Emacs |
|---|---|
| Lignes, UI | `(global-display-line-numbers-mode 1)`, désactiver menu/tool/scroll-bar |
| Dired lisible | `(setq dired-listing-switches "-alh")` |
| Grep par défaut | `(setq grep-command "grep -nH -R ")` |
| Raccourcis erreurs | `M-g n` / `M-g p` |
```
