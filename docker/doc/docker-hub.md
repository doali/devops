# Docker Registry

_Utilisation du registry ou Docker Hub_

## Step 1

- créer un compte : [docker hub](https://hub.docker.com/)

## Step 2

- se logger : `docker login`

## Step 3

_Pousser une image dans le Docker Hub._

- `docker push <user_name>/<component>`

## Step 4

- se délogger : `docker logout`

## Step 5

_Récupérer une image depuis le Docker Hub._

- `docker pull <user_name>/<component>`

## Scenario

- `docker tag debian-vim-git:latest doali/debian-vim-git:0.0.1`
- `docker login`
- `docker push doali/debian-vim-git`
- `docker logout`

## Biblio

- [docker labs](https://github.com/docker/labs/blob/master/beginner/chapters/webapps.md#232-write-a-dockerfile)
- [docker hub](https://hub.docker.com)
