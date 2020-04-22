# Common git commands

- create local repository
- create a file
- prepare file to be commited
- checkout
- pull, fetch from repositories
- commit file
- check logs
- diff
- about branch
- grep
  - Exemples : `git grep`

---

## create local repository

```bash
mkdir localRepository
```

- `git init`
> Create an empty git repository
- `git config user.email "...@..."`
- `git config user.name "..."`
- `git remote add origin https://github.com/doali/git.git`
- `git remote -v` indique tous les dépots référencés
> on peut également les consulter dans .git/config


## create a file

```bash
touch info.txt
```

## prepare file to be commited

|*command*|*revert*|
| ------- | ------ |
|`git add info.txt`|- `git rm --cached info.txt`|
|                  |- `git reset HEAD info.txt`|
|                  |- `git stash`|
|`git status`||
|`git commit -m "info message"`|`git reset --soft HEAD^`|
|`git status`||

```bash
git status
```

- compare l'état de sa copie de travail avec la zone d'index et la zone du repository local (.git) par rapport à ***la dernière*** image (vue, snapshot) que l'on a du repository distant.

```bash
git stash
```

- fonctionne uniquement sur les fichiers suivis
  - ayant fait l'objet d'un `git add` auparavant
  - ayant fait l'objet d'un `git commit` auparavant
> Permet de sauvegarder dans la remise *tous les fichiers* ***indexés*** (i.e issus d'un `git add`) sans modifier les autres zones : copie locale (working tree), repository local (.git)

> Par exemple, on pourrait être dans la situation

> - où le repository local serait en avance de 2 commits
> - avec 3 fichiers indexés et donc prêts à être commités
> - ainsi que 4 nouveaux fichiers non encore suivis.
>
> Effectuer un `git stash` aurait pour conséquence de sauvegarder dans la remise

> - les 3 fichiers indexés
>
> Et de conserver

> - les 2 commits d'avance
> - les 4 nouveaux fichiers non suivis
>
> tels qu'ils étaient avant le `git stash`

## checkout

```bash
git checkout
```

- `git checkout <nom_branche>` permet de changer de branche et d'y positionner le pointeur HEAD
- `git checkout` renvoie des infos concernant les fichiers dans la zone d'index
- `git checkout .`
  - écrase toutes les modifications des fichiers présents dans la copie de travail
    - par l'état de ces mêmes fichiers si ils sont présents dans la zone d'index
    - par l'état de ces mêmes fichies tels qu'ils le sont dans le dépôt local (i.e. qu'ils ne sont pas présents dans la zone d'index et que l'on conserve alors leurs deniers états définis dans le dépôt local)
  - n'a pas d'effet sur les fichiers
    - mis dans la remise (`git stash`)
    - non suivis
> Par exemple

> - ***si*** on dispose d'un fichier index_1 dans la zone d'index
> - ***et*** que l'on modifie ensuite ce meme fichier index_1
> - ***alors*** l'état du fichier index_1 (dans la zone d'index) ***ecrasera les modifications*** du fichier index_1 ***de la copie de travail***

## pull, fetch from repositories

- `git pull origin master`
  - `git pull` est idendique au combo : `git fetch` suivi de `git merge FETCH_HEAD`
  - > `git pull --help`
>
> Incorporates changes from a remote repository into the current branch. In its default mode, git pull is shorthand for git fetch followed by git merge FETCH_HEAD.
>
>
> More precisely, git pull runs git fetch with the given parameters and calls git merge to merge the
> retrieved branch heads into the current branch. With --rebase, it runs git rebase instead of git merge.

- `git pull --rebase origin master`
> récupère à l'@ contenue dans l'alias origin, toutes les modifications de la branche master
- `git fetch`récupère toutes les branches, tags... distants pour les mettre sur le repository local (.git) ainsi que les références des commits distants

## commit file

- `git push origin master`
> envoie tous les derniers commits du repository local (.git) sur la branche master du repository distant à l@ origin

## check logs

- `git log`

> `git log --oneline --graph`
>
> Pour une vue concise

> - affichant avance et retard sur le dépot local
> - le positionnement courant de la HEAD
> - une representation semi-graphique

## diff

- `git diff` compare la copie de travail avec le dépot local (.git)
- `git diff --cached` compare la zone d'index avec le dépot local
- `git diff HEAD` compare
  - la copie de travail avec le dépot local
  - la zone d'index avec le dépot local

> Par exemple

> - on cree deux fichiers index_1 et index_2 dans la copie de travail
> - `git diff` et `git diff --cached` affichent aucune difference car les fichiers ne sont pas suivis
> - si on ajoute dans l'index le fichier index_1 par `git add index_1`
>   - alors `git diff` renvoie aucune difference
>   - et `git diff --cached` affiche une différence, car la zone d'index est différente de la copie de travail, en indiquant que index_1 est un nouveau fichier
> - puis, si on commite le fichier index_1 précédemment indexé
>   - `git diff` renvoie aucune difference (car la copie de travail est alignée avec le repository local)
>   - `git diff --cached` renvoie aucune différence car le fichier index_1 n'est plus indexé
> - maintenant, si on modifie le fichier index_1 uniquement présent dans la copie de travail
>   - `git diff` indique les différence car le fichier index_1 est désormais présent dans le depot local et différent de son état dans la copie de travail
>   - `git diff --cached` ne renvoie aucune information car le fichier n'est pas dans la zone d'index
> - puis, si on ajoute le fichier index_1 dans la zone d'index `git add index_1` alors
>   - `git diff` ne renvoie aucune information car la copie de travail est désormais alignée avec le repository local
>   - `git diff --cached` indique les différences entre le fichier index_1 désormais présent dans la zone d'index et sa version dans le dépot local (.git)

## about branch

_Tout est branche !!_

- `git branch` permet

> - d'afficher toutes les branches récupérées localement
> - de créer des branches
> - de supprimer des branches

- `git branch --list` pour lister toutes les branches locales (.git)
- `git checkout -b dev` crée en local (.git) une branche nommée dev et bascule sur cette branche
- `git push --set-upstream origin dev` pousse à l'@ origin la nouvelle branche dev

## grep

_La commande `git grep`_

- _est l'alter ego de la commande `grep` traditionnelle._
- _renvoie le résultat sur la sortie standard._

> `git grep` ne fonctionne que sur les ***fichiers suivis***
>
> _C'est à dire, les fichiers_
> - présents dans la zone d'index (ayant fait l'objet d'un `git add`)
> - présents dans le dépot local (ayant fait l'objet d'un `git commit`)
> - présents dans la copie de travail ***mais ayant déjà*** fait l'objet d'un `git add` ou d'un `git commit`
>
> *Ne fonctionne donc pas sur* les fichiers issus d'un `git stash`, ni sur les fichiers présents dans la copie de travail n'ayant ***jamais été*** suivis

### Exemples : `git grep`

- ```bash
  git grep -i 'tes' -- :^'*ind*'
  ```

> Renvoie
> - tous les fichiers contenant `tes` (en ignorant la casse `-i`)
> - et dont le ***nom*** ne contient pas `ind` (`-- :^'<pattern_fichier>'`)

- ```bash
  git grep 'tes'
  ```

> Renvoie
> - tous les fichiers contenant `tes`

- ```bash
  git grep -i cou -- :'*.md'
  ```

> Renvoie
> - tous les fichiers contenant `cou`
> - et dont le nom termine par `.md`

## Biblio

- [atlassian](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
- [git-scm](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified)
