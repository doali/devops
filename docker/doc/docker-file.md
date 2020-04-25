# Dockerfile

## Principales instructions

_Les instructions sont en lettres capitales_

### `FROM`

- requis
- première instuction
- image de base (base layer) sur laquelle est bâtie notre image

### `MAINTAINER` 

- mainteneur de l'image  `Nom <email>`

### `RUN`

- lance une commande
- créé un layer (resultant de cette commande) apposé au layer précédent

### `COPY`

- copie fichiers / répertoires 

> depuis l'hôte vers le conteneur

### `ADD`

- copie fichiers / répertoires
- URL
- extrait directement le contenu d'une archive 

> depuis l'hôte vers le conteneur

### `EXPOSE`

- (merely a hint) indique qu'un port est exposé par le container 

> _i.e. que le conteneur écoute sur ce port_ \
> (!) ne publie pas le port \
> pour publier le port il faut l'indiquer

- `-P` : bind tout port exposé du conteneur à un port aléatoire de l'hôte
- `-p localhost:8000:5000` : bind le port 8000 de l'hôte sur le port 5000 du conteneur (`docker run -p localhost:8000:5000 [...]`)

_Utiliser la commande `docker logs -f <nom_container>` afin de visualiser les logs_

```bash
docker logs -f compassionate_jang 
```

- ou encore : `docker logs compassionate_jang`

> `-f` permet de revoyer *continuellement* le flux des logs sur la sortie standard

### `CMD` et `ENTRYPOINT`

_Il doit au moins exister un `ENTRYPOINT` ou une entrée `CMD` dans un Dockerfile_

#### `CMD` 

- commande à exécuter au démarrage du conteneur (unlike RUN : pas de nouveau layer)
- il existe uniquement **un** `CMD` dans un Dockerfile
- exploité par `ENTRYPOINT` qui utilise les paramètres de `CMD` comme arguments
- les paramètres de `CMD` sont surchargés sitôt que des arguments sont présents en ligne de commande

#### `ENTRYPOINT` 

- permet d'ajouter une commande qui sera exécutée par défaut, et ce, même si on choisit d'exécuter une commande différente de la commande standard
- exploite les arguments introduits par `CMD`

### `WORKDIR` 

- définit le dossier de travail pour toutes les autres commandes (par exemple RUN, CMD, ENTRYPOINT et ADD)

### `ENV` 

- définit des variables d'environnements qui pourront ensuite être modifiées grâce au paramètre de la commande `run --env <key>=<value>`

- `docker run -it -p 8080:80 -v /tmp/my-nginx:/volume/data -e MESSAGE="coucou toi" tuto/debian-nginx`

> `-e` : introduit le couple CLEF=VALEUR pour la variable d'environnement MESSAGE

_Utiliser la commande `docker exec -it <nom_container> <CMD>` pour entrer dans le conteneur_

- avec `<CMD>` une commande qui sera `bash`

```bash
user@domain:$ docker exec -it keen_diffie bash
root@d7af8a6e0e3e:/tmp/my-nginx# echo $MESSAGE
coucou toi
```

### `VOLUMES` 

- créé un point de montage assurant la persitance des données. 
- on pourra alors choisir de monter ce volume dans un dossier spécifique en utilisant la commande `run -v :`

_Utiliser la commande `docker inspect [...]` pour observer le container_

```bash
user@domain:$ docker inspect unruffled_edison | less
```

> unruffled_edison est le nom de notre container

## Scenario

- création du fichier (en respectant la casse proposée) : `touch Dockerfile`

- exemple de fichier : `cat Dockerfile`

```Dockerfile
# Seul ARG peut précéder FROM
# ARG

# Triptyque de base
# ------------------------------------------------------------------------------
# Image de base
FROM debian

# Mainteneur
MAINTAINER Username <user@domain.com>

# Lancée lors du build (après quoi, la layer sera exploitée notamment via le cache !!) 
# (relancée seulement si on rebuild avec l'option --no-cache)
RUN apt update
# ------------------------------------------------------------------------------

# Nouveau layer avec mise en cache
RUN apt install curl -y

# Nouveau layer avec mise en cache
RUN apt install nginx -y

ADD script.sh /usr/bin
RUN chmod ug+x /usr/bin/script.sh

# Indique que le conteneur sera en écoute sur le port 80
# Il faudra mapper réellement ce port !! => -p ou -P (port dynamique de l'hôte)
EXPOSE 80/tcp

# Diptyque de fin
# ------------------------------------------------------------------------------
# Sera toujours executé
ENTRYPOINT ["script.sh"]

# Sera executé SAUF si des arguments sont passés en ligne de commande
# - dans ce cas, sera surchargé par ces derniers
CMD ["bash"]

# Création d'un volume que l'on exploitera via la ligne de commande
# Ce volume est automatiquement monté sur le file system du container
# Analyser via `docker inspect <nom_container|sha1_container>`
VOLUME /volume/data

# Declaration, définition d'une variable d'environnement
# Analyser via `docker exec -it <nom_container|sha1_container> bash` puis echo $MESSAGE
ENV MESSAGE "mon message"

# Repertoire d'accueil au lancement du conteneur
WORKDIR /tmp/my-nginx
```

- creation de l'image décrite par le `Dockerfile` : `docker build -t doali/debian-test .` (attention au `.`)
- `-t <TAG>` : définition d'un TAG

> Forme usuelle du TAG : `[<component>|<comp_part1>/<comp_part2>:<version>|<registry>:<port>/<component>:<version>|<user>/<component>:<version>`

- `docker tag <comp_part2> <comp_part1>/<comp_part2>:<version>`
- `docker tag httpd fedora/httpd:version1.0`
- `docker tag <sha1> myregistry:5000/<comp_part1>/comp_part2>:<version>`

> `docker tag <sha1> user/image-name`

- création d'un container (instanciation d'une image): `docker run -it --rm doali/debian-update`

- `-i` : mode interactif
- `-t` : attache un terminal

- `--rm` : supprime le container lorsque ce dernier 

> - termine son exécution
> - est quitté (si mode interactif)

**(!)** `--no-cache` : permet de s'abstraire du cache et ainsi de reconstruire tous les layers

> cela permet entre autre dans le cas de notre `Dockerfile` d'exemple de ré-exécuter la commande `apt update -y` et ainsi de mettre à jour les paquets

- `docker build --no-cache -t doali/debian-update .` : reconstruit tous les layers

## Astuces

### Bonnes pratiques

- versionner le Dockerfile

### Reconstruire le layer `--no-cache`

- `--no-cache` : `docker build --no-cache [...] .` : permet de ne pas utiliser le cache et de ce fait de reconstruire tous les layers
- `RUN apt update --no-cache` : dans un Dockerfile permet de ne pas utiliser le cache sur la commande

### Renommer un conteneur

- `--name` : `docker run --name my-ghost [...] <nom_image>` : permet de nommer le conteneur : `docker run --name my-ghost -d -p 8080:2368 ghost`

### Stopper et Supprimmer un conteneur

- `--rm -f` : `docker build --rm -t tuto/debian-curl-copy .` : permet de supprimer et de stopper un conteneur

### Garder un conteneur actif

- `docker run -d --name <name_container> tail -f /dev/null` : garder un conteneur `d`etached actif en renvoyant en permanence sur ``/dev/null`

```Dockerfile
FROM <some base>
CMD tail -f /dev/null
```

> Pour éviter le `exit` du conteneur, on renvoie sur `/dev/null` en permanence

### Supprimer des images

- `docker images -q` : renvoie les SHA-1 des images (pratiques pour supprimer les <none>)
- `docker rmi $(docker images -q | head -7)` permet de supprimer les 7 premières images

## Multi-stage builds

```Dockerfile
FROM golang:1.7.3 AS builder
WORKDIR /go/src/github.com/alexellis/href-counter/
RUN go get -d -v golang.org/x/net/html
COPY app.go    .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
CMD ["./app"]
```

## Biblio

- [stack overflow](https://stackoverflow.com/questions/41603822/docker-how-to-update-images/41604309)
- [docker docs](https://docs.docker.com/engine/reference/builder/)
- [grafikart Dockerfile](https://www.grafikart.fr/tutoriels/Dockerfile-636)
- [vsupalov EXPOSE](https://vsupalov.com/docker-expose-ports/)
- [docker docs EXPOSE](https://docs.docker.com/engine/reference/builder/#expose)
- [ADD vs COPY](https://nickjanetakis.com/blog/docker-tip-2-the-difference-between-copy-and-add-in-a-dockerile)
- [docker docs ENTRYPOINT / CMD](https://docs.docker.com/engine/reference/builder/#expose)
- [AUFS wikipedia](https://en.wikipedia.org/wiki/Aufs)
- [multistage](https://docs.docker.com/develop/develop-images/multistage-build/)
