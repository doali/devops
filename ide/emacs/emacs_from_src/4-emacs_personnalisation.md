# Installation des dépendances système

Certaines fonctionnalités ou modules activés dans ~/.doom.d/init.el (ou config.el) nécessitent des outils système complémentaires.

Voici la liste des dépendances externes à installer selon les modules utilisés :

- cmake : requis pour la compilation du module de terminal vterm.

```bash
sudo dnf install -y cmake
```
