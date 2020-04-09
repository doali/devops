# Bash Code Style
_Utilisation de `shfmt` pour formater le code._

## Installation

- `snap install shfmt`
- `shfmt --version` renvoie `v2.6.4`

## Utilisation

### En console

- `shfmt <source_file_bash>`

  > resultat du formatage sur la sortie standard

- `shfmt -w <source_file_bash>`

  > modifications sur le fichier

### Vim

- ouvrir le fichier <source_file_bash> : `vim <source_file_bash>`

et lancer l'appel à shfmt depuis vim

- `:!shfmt <source_file_bash>`

## Biblio

- [shfmt](https://github.com/mvdan/sh)
