# Python

Installation et configuration Python pour **Doom Emacs**.

## Outils utilisés

Dans la configuration actuelle :

- **Pyright** : analyse statique et complétion LSP
- **Corfu** : affichage des complétions
- **DAPE + debugpy** : débogage Python
- **Ruff** : linting, formatage et gestion des imports

---

## Installation des outils système

### Pyright

```bash
pip install pyright
```

Vérification :

```bash
pyright --version
```

### Ruff

```bash
pip install ruff
```

Vérification :

```bash
ruff --version
```

### debugpy

```bash
pip install debugpy
```

Vérification :

```bash
python -m debugpy --version
```

---

## Installation dans un environnement virtuel

Pour un projet Python utilisant un environnement virtuel :

```bash
python -m pip install pyright ruff debugpy
```

ou individuellement :

```bash
python -m pip install pyright
python -m pip install ruff
python -m pip install debugpy
```

---

## Configuration Pyright dans Doom Emacs

Dans `config.el` :

```elisp
(after! lsp-pyright
  (setq lsp-pyright-typechecking-mode "strict"
        lsp-pyright-auto-import-completions t
        lsp-pyright-use-library-code-for-types t))
```

Cette configuration apporte :

- auto-complétion enrichie ;
- complétion basée sur les types ;
- auto-imports ;
- analyse stricte des types.

---

## Débogage Python avec DAPE

Doom Emacs utilise DAPE.

Lancer le débogueur :

```text
SPC d d
```

Choisir :

```text
debugpy
```

Principales commandes :

```text
SPC d b   Breakpoint
SPC d c   Continue
SPC d n   Next
SPC d s   Step Into
SPC d o   Step Out
SPC d q   Quit
SPC d R   REPL
SPC d i   Informations de débogage
```

---

## Configuration Ruff par projet

À la racine du projet :

```toml
[tool.ruff]
line-length = 88
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I", "B", "UP"]

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
```

---

## Vérifications

### Vérifier Pyright

Créer :

```python
from pathlib import Path

p = Path(".")
p.
```

Corfu doit proposer les méthodes de `Path`.

---

### Vérifier DAPE

Créer :

```python
def addition(a: int, b: int) -> int:
    resultat = a + b
    return resultat


x = 10
y = 20

z = addition(x, y)

print(z)
```

Poser un breakpoint sur :

```python
resultat = a + b
```

Puis :

```text
SPC d d
```

Choisir :

```text
debugpy
```

Le programme doit s'arrêter sur le breakpoint.

---

### Vérifier Ruff

```bash
ruff check .
```

et :

```bash
ruff format .
```

---

## Remarque importante

La configuration actuelle utilise **Pyright** comme serveur LSP.

L'installation de `python-lsp-server` n'est donc pas nécessaire :

```bash
pip install python-lsp-server
```

peut être omise.

La pile Python actuellement utilisée est :

```text
Pyright
+ Corfu
+ Ruff
+ DAPE
+ debugpy
```
