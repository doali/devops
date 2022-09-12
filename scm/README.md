# SCM

## Message

_Modifier un message de commit après un **push**_

```bash
git commit --amend -m "New message"
```

```bash
git push --force-with-lease repository-name branch-name
```

> !! Attention avec la commande qui suit !!
```bash
git push --force repository-name branch-name
```

> Unlike `--force`, which will destroy any changes someone else has pushed > to the branch, `--force-with-lease` will abort if there was an upstream > change to the repository.
> -- <cite>[educative](https://www.educative.io/edpresso/how-to-change-a-git-commit-message-after-a-push)</cite>

## Historique

Récupérer l'historique des commits d'une branche `branch_name` créée depuis la branche `develop`

```bash
git log develop..branch_name --oneline
```

> Et du coup le premier commit de `branch_name`

```bash
git log develop..branch_name --oneline | tail -1
```

*Autres commandes possibles*

```bash
git log --oneline origin/develop..branch_name
```

```bash
git log --oneline branch_name --not origin/develop
```

```bash
git log --oneline branch_name ^origin/develop
```

## Restaurer un fichier

```bash
git log --diff-filter=D --summary | grep -i fichier
git rev-list -n 1 HEAD -- chemin/vers/le/fichier.cpp
git checkout ddec0c177ee0400b90c967c9e068a2cef0733a7e^ -- chemin/vers/le/fichier.cpp
```

## Biblio

- [rubygarage](https://rubygarage.org/blog/most-basic-git-commands-with-examples)
- [educatives](https://www.educative.io/edpresso/how-to-change-a-git-commit-message-after-a-push)
