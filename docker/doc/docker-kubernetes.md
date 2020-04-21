# Docker _(et Kubernetes)_
_Extrait de wikipedia_

> Docker est un logiciel libre permettant de lancer des applications dans des conteneurs logiciels.

_En 2018, le nombre de sociétés utilisant Docker se compte en milliers. L'utilisation de Docker est le plus souvent couplé avec un orchestrateur (tel Kubernetes)._

En chiffres

- 2013 entrée dans l'Open Source de Docker
  - _la virtualisation est déjà vieille de prés de 4 décennies en 2020_
- en moyenne 8 conteneurs par hôte,
- durée de vie d'un conteneur
  - 12 heures *avec* orchestrateur
  - 6 jours *sans* orchestrateur

Le développement de Docker s'est réalisé en suivant au mieux _The Twelve-Factor App_.

***Most-clefs*** : docker-compose, LXC, Kubernetes, orchestrateur, conteneur, chroot (CHange ROOT),

---

Sommaire

- Historique
- VM (Virtual Machine) vs Conteneur
- Pratique
  - Runtime
  - Réseau
  - Stockage
  - Sécurité
  - Registry
- Orchestrateur
  - Théorie
  - Kubernetes & Minikube
    - Concepts et composants
    - Ingress
    - Cluster
    - Configuration yaml
    - Montée en charge
    - Déploiement
      - Namespaces
      - Labels
      - Affinités
      - Noeuds et workloads
      - Configuration
        - Volume
        - Secrets
- Biblio

---

## Historique
|Annee|Outil|En bref|
|-----|-----|-------|
|1979|CHROOT|permet de changer le paramètre racine (root /), de changer le système de fichiers et ainsi d'isoler les processus|
|2000|BSD JAIL|permet de changer le système de fichiers (comme CHROOT) ***et*** en plus d'isoler les processus, les utilisateurs et le réseau ; processus placés dans des _sandbox_. Un jail est un environnement virtuel.|
|2001 - 2008|VSERVER|Virtualisation au niveau du système d'exploitation. Cependant, *non* intégré au noyau linux ce qui implique de le patcher sur le noyau.|
|2002|Linux NAMESPACES|Intégrés dans le noyau. namespace (mount|pid|net|ipc...)|
|2005|Solaris ZONES|Conteneurs Solaris, conceptuellement prochent des _jails_, système de fichier ZFS, BrandZ (BRanded Zones).|
|2005|OPENVZ|Non intégré de base au noyau Linux, disponible sous la forme de patches.|
|2006|Process Containers|Développés par Google pour optimiser les ressources exploitées par les processus (cpu, mémoire, disques io, réseau, ...). Renommés Control Groups (cgroups). Intégrés dans le noyau Linux.|
|2008|LXC|LinuX Containers combinent les _cgroups_ et _namespaces_. Intégrés au noyau Linux. Sécurité permissive (root d'un conteneur peut lancer process sur la machine ***hôte*** en root).|
|2011|WARDEN|CloudFoundry Warden (basée initialement sur LXC). Utilise un modèle client-serveur pour gérer les conteneurs. Warden daemon permet de gérer les _cgroups_ et _namespaces_ et les cycles de vie de processus.|
|2013 - 2015|LMCTFY|Let Me Contain That For You est la version open source du conteneur _runtime_ utilisé en interne par Google (et notamment Borg). Supporte des _cgroups_ hiérarchisés. ARRETE en main 2015|
|2013|Docker|Hérite de LXC. Exécute un démon sur la machine hôte qui propose une API et un modèle client-serveur Docker CLI. Dockerfile : fichier texte permettant la création d'un conteneur en référençant une image de base. Docker Registry : partage d'images docker. docker-compose permet de définir une application multi-conteneurs via un fichier de configuration yaml|
|2014|RKT|Rocket est le _runtime_ de CoreOS, alternative à Docker. Utilise le standard _appc_ (Application Container) et le format d'image ACI.|
|2016|RUNC, CONTAINERD, CRI-O|RunC est le _runtime_ bas niveau chargé de l'exécution des conteneurs (utilisé par Docker engine...). Containerd est le _runtime_ de haut niveau permettant de contrôler les _runC_.|

_La popularité de la conténeurisation a mené à l'utilisation d'orchestrateurs tels que : Kubernetes (CNCF), Mesos (Apache), Swarm (Docker), Cattle (Rancher Labs), ..._

Kubernetes s'est imposé et propose une interface CRI (Container Runtime Interface) afin de pouvoir supporter davantage de _runtimes_ (comme cri-o porté par Redhat, Intel, Suse, ...).

## Exemples

### Docker file

```
FROM ubuntu

MAINTAINER foo

RUN apt update && apt install -y nginx && apt clean
COPY index.html /var/www/html

EXPOSE 80, 443

CMD nginx -g 'daemon off;'
```

## Decouverte

### Principe
- Docker daemon : processus serveur Docker à l'écoute d'instruction
- Docker's CLI : client Docker en ligne de commandes
- Docker Images : images modèle de création de conteneurs (Base image <- [layer ...] <- last_layer)
- Docker Containers : instances d'images
- Docker Store : registry

_Boot2Docker :_ machine virtuelle proposée pour utiliser Docker sur Mac et Windows.

**wikipedia**
_Docker est un logiciel libre permettant de lancer des applications dans des conteneurs logiciels_

- isolement des applications, outils dans un container 
- isolé du système d'exploitation
- exécution par un daemon
- possibilité de définir des images (modèle de création d'un container)
- sécurité, réseau, volumes, services, ...

### Images docker

_Une image est un empilement de couches correspondant à d'autres images_

> En conséquence, on ne récupère que les layers (images) dont on a besoin

### Container

_Un container est une instance d'une image_

### Recuperaton d'une image

- `docker pull debian`

> L'image debian (version latest) sera téléchargée depuis docker hub

- `docker run debian`

> Si l'image debian (version latest) n'est pas présente sur la machine où cette commande est réalisée
> alors, elle sera téléchargée depuis docker hub

### Image de base modifiée : diff -> commit -> save

Contexte

- on récupère une image debian : `docker pull debian`
- on créé un container depuis cette image : `docker run debian`
  - dont l'id est `474af97349ff` (obtenu via : `docker ps` : visualisation de l'ensemble des containers actifs)

#### `docker diff...`

La commande `docker diff 474af` renvoie sur la sortie standard toutes les différences de notre container avec un container instance de notre image de référence debian.

#### `docker commit...`

On peut alors sauvegarder "l'image" modifiée de notre conteneur de la façon suivante : `docker commit 474a debian-vim`

> username@hostname:~$ docker commit 474af debian-vim
> sha256:3eebf9f46f2f8aaa84bb9f3d69f17705674ca98ad9dd92c262f816d17a7d564d

La nouvelle image debian-vim est désormais disponible

```bash
> username@hostname-pc:~/git-github$ docker images
> REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
> debian-vim          latest              3eebf9f46f2f        9 minutes ago       165MB
> debian              latest              a8797652cfd9        10 days ago         114MB
> alpine              latest              e7d92cdc71fe        3 weeks ago         5.59MB
> username@hostname-pc:~/git-github$
```

On peut dès lors utiliser notre nouvelle image `debian-vim`

- `docker run -it debian-vim`

- `-i` : Keep STDIN open even if not attached. The default is false.
- `-t` : Allocate a pseudo-TTY. The default is false.

```bash
user@pc:~/git-github/devops/docker/doc$ docker run -it debian-vim
root@273bfb77f358:/# exit
exit
user@pc:~/git-github/devops/docker/doc$ 
```

#### `docker save...`

Pour sauvegarder de cette image, il faut l'exporter : `docker save debian-vim >~/img-docker/debian-vim.tar`

> _On suppose que_ ~/img-docker/ _est un chemin existant_

#### `docker rmi...`

- Supprimons maintenant l'image **docker-vim** : `docker rmi 3eebf9f46f2f` (grace à son sha1)
- Cette image n'est désormais plus présente dans la liste des images disponibles : `docker images`
- ...

#### `docker load...`

- ...
- On peut charger une image au format .tar directement dans la "liste" des images docker (`docker images`) en utilisant la commande `docker load` à laquelle on fournit en entrée une archive (.tar)
  - `docker load < ~/imgdocker/debian-vim.tar`

    ```bash
    username@hostname-pc:~/git-github/docker/script$ docker images    
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    debian-vim-git      latest              1e08ef61f9da        14 minutes ago      270MB    
    debian-vim          latest              3eebf9f46f2f        37 minutes ago      165MB    
    username@hostname-pc:~/git-github/docker/script$    
    ```

#### `docker (image|container) prune`

- `docker container prune` : supprime tous les containers (i.e. les instances d'images)

- `docker image prune` : supprime toutes les images

*RM* 

> Le prompt invite à confirmer les demandes de suppressions

_La suppression via la commande `docker image prune` malgré le fait que j'ai confirmé la demande de suppression n'a pas supprimé mes images..._

- `docker images`

```bash
user@pc:~/img-docker$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              latest              58075fe9ecce        11 days ago         114MB
debian-vim-git      latest              1e08ef61f9da        8 weeks ago         270MB
user@pc:~/img-docker$ docker image prune
WARNING! This will remove all dangling images.
Are you sure you want to continue? [y/N] y
Total reclaimed space: 0B
user@pc:~/img-docker$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              latest              58075fe9ecce        11 days ago         114MB
debian-vim-git      latest              1e08ef61f9da        8 weeks ago         270MB
user@pc:~/img-docker$ 
```

> Il est alors possible de supprimer comme ceci

```bash
for i in $(docker images | awk '{print($3)}' | tail +2); do docker rmi $i; done
```

ce qui nous donne

```bash
user@pc:~/img-docker$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              latest              58075fe9ecce        11 days ago         114MB
debian-vim-git      latest              1e08ef61f9da        8 weeks ago         270MB
user@pc:~/img-docker$ docker images | awk '{print($3)}' | tail +2
58075fe9ecce
1e08ef61f9da
user@pc:~/img-docker$ for i in $(docker images | awk '{print($3)}' | tail +2); do docker rmi $i; done
Untagged: debian:latest
Untagged: debian@sha256:125ab9ab9718f4dba6c3342407bb1923afce4f6b2a12b3a502d818274db9faf9
Deleted: sha256:58075fe9eccee217ff713b4b500f6caeaa68e88bc4834b2d1e3407f20e124315
Deleted: sha256:24efcd549ab5e1786f787e7dc03590dcb222e7e95242524d97fedeb05393e891
Untagged: debian-vim-git:latest
Deleted: sha256:1e08ef61f9da88a242b6dd5d6b5688ef4286b4e4964c8125cce4b942ff613709
Deleted: sha256:03bd3ce2aa8fcb1a2b28eee40c495036c6b35c6064f2c14631337e5e1af45e05
Deleted: sha256:ce8168f123378f7e04b085c9672717013d1d28b2aa726361bb132c1c64fe76ac
user@pc:~/img-docker$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
user@pc:~/img-docker$ 
```

#### `docker run -d -p (host-port:container_port) [...]`

_Plug le `<host-port>` de la machine hote sur le `<container_port>` du container_

- `-p, --publish ip:[hostPort]:containerPort | [hostPort:]containerPort`

  > Publish a container's port, or range of ports, to the host.

- `-d, --detach=true|false`

  > Detached mode: run the container in the background and print the new container ID. The default is false.

```bash
docker run -d -p 8080:2368 ghost
```

#### `docker run -v (host-path:container-path) [...]`

_Monte un volume de la machine hote dans le conteneur._

- `-v|--volume[=[[HOST-DIR:]CONTAINER-DIR[:OPTIONS]]]`

	> Create a bind mount. If you specify, -v /HOST-DIR:/CONTAINER-DIR, Docker
	> bind mounts /HOST-DIR in the host to /CONTAINER-DIR in the Docker
	> container. If 'HOST-DIR' is omitted,  Docker automatically creates the new
	> volume on the host.

```bash
docker run -it -v ${HOME}/git-github:/home debian
```

#### `docker run --name <some-name>`

_Permet d'associer le sha1 à `<some-name>`_

```bash
docker run --name my-ghost -d -p 8080:2368 ghost
```

```bash
user@pc:~/git-github/devops/docker/doc$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
user@pc:~/git-github/devops/docker/doc$ docker run -d -p 8080:2368 ghost
1a71e8ff30586125b7a98abc900be9ddbf4b92fd7a6e0bbedccb5fcb15e31a70
user@pc:~/git-github/devops/docker/doc$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
1a71e8ff3058        ghost               "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds        0.0.0.0:8080->2368/tcp   crazy_einstein
user@pc:~/git-github/devops/docker/doc$ docker stop 1a71e8ff3058
1a71e8ff3058
user@pc:~/git-github/devops/docker/doc$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
user@pc:~/git-github/devops/docker/doc$ docker run --name my-ghost -d -p 8080:2368 ghost
83eb010dffac6d0b099773a59402e8231689025196aea08d0c7e2eca6f1fdad3
user@pc:~/git-github/devops/docker/doc$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
83eb010dffac        ghost               "docker-entrypoint.s…"   4 seconds ago       Up 2 seconds        0.0.0.0:8080->2368/tcp   my-ghost
user@pc:~/git-github/devops/docker/doc$ docker stop my-ghost
my-ghost
user@pc:~/git-github/devops/docker/doc$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
user@pc:~/git-github/devops/docker/doc$
```

#### `docker stop ...`

- `docker [container] stop <sha1|name>` : stoppe l'exécution du conteneur (que l'on peut vérifier avec `docker ps`)

#### `docker rm ...`

- `docker [container] rm <sha1|name>` : supprime le conteneur
- `docker rm -f <sha1|name>` : réalise un `stop` suivi d'un `rm` sur un conteneur

#### `docker exec ...`

_Execute une commande dans un conteneur en cours d'exécution_

- `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`
- `docker exec -it relaxed_germain bash`

> - (!) le conteneur doit être en cours d'exécution !! \
> - relaxed_germain est le nom associé au conteneur \
> - bash est la commande à executer

exemple

> Copier une ressource depuis l'hote dans un container en cours d'exécution

`tar -c <resource> | docker exec -i <nom_container> /bin/tar -C /tmp -x`

> (!) utiliser `docker cp <resource> <nom_container>:/tmp`

> Les options `-it` indique que l'on passe en mode interactif avec une demande d'un terminal

#### `docker logs [-f] ...`

- `docker run --rm -name my-ghost -d -p 8080:2368 ghost`
- `docker logs --follow my-ghost`

_Lancer la page : `firefox http://localhost:8080` et observer les logs..._

## Biblio

Presentation

  - [stack overflow](https://stackoverflow.com/questions/41603822/docker-how-to-update-images/41604309)
  - [docker overview](https://docs.docker.com/get-started/)
  - [docker command-line](https://docs.docker.com/engine/reference/commandline/tag/#examples)
  - [grafikart](https://www.grafikart.fr/tutoriels/docker-intro-634)

Commandes

  - [docker docs exec](https://docs.docker.com/engine/reference/commandline/exec/)
  - [docker docs logs](https://docs.docker.com/engine/reference/commandline/logs/)

Registry

  - [Docker HUB](https://hub.docker.com/)
  - [nginx](https://hub.docker.com/_/nginx)

Conteneur
  
  - [LXC sur wikipedia](https://fr.wikipedia.org/wiki/LXC)
  - [Docker sur wikipedia](https://fr.wikipedia.org/wiki/Docker_(logiciel))

Orchestrateur
  
  - [Kubernetes sur wikipedia](https://fr.wikipedia.org/wiki/Kubernetes)
  - [Minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/)

Philosophie _(développement d'un conteneur)_
  
  - [The Twelve-Factor App](https://12factor.net/)
