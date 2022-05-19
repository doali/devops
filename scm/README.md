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

## Biblio

- [rubygarage](https://rubygarage.org/blog/most-basic-git-commands-with-examples)
- [educatives](https://www.educative.io/edpresso/how-to-change-a-git-commit-message-after-a-push)
