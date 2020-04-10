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
  - dont l'id est `474af97349ff` (obtenu via : `docker ps`)

#### `docker diff...`

La commande `docker diff 474af` renvoie sur la sortie standard toutes les différences de notre container avec un container instance de notre image de référence debian.

#### `docker commit...`

On peut alors sauvegarder "l'image" modifiée de notre conteneur de la façon suivante : `docker commit 474a debian-vim`

> username@hostname:~$ docker commit 474af debian-vim
> sha256:3eebf9f46f2f8aaa84bb9f3d69f17705674ca98ad9dd92c262f816d17a7d564d

La nouvelle image debian-vim est désormais disponible

> username@hostname-pc:~/git-github$ docker images
> REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
> debian-vim          latest              3eebf9f46f2f        9 minutes ago       165MB
> debian              latest              a8797652cfd9        10 days ago         114MB
> alpine              latest              e7d92cdc71fe        3 weeks ago         5.59MB
> username@hostname-pc:~/git-github$

#### `docker save...`

Pour disposer de cette image, il faut l'exporter : `docker save debian-vim >~/imgdocker/debian-vim.tar`
> _On suppose que_ ~/imgdocker/ _est un chemin existant_

#### `docker rmi...`

- Supprimons maintenant l'image **docker-vim** : `docker rmi 3eebf9f46f2f` (grace à son sha1)
- Cette image n'est désormais plus présente dans la liste des images disponibles : `docker images`
- ...

#### `docker load...`

- ...
- On peut charger une image au format .tar directement dans la "liste" des images docker (`docker images`) en utilisant la commande docker load à laquelle on fournit en entrée une archive (.tar)
  - `docker load < ~/imgdocker/debian-vim.tar`

    ```
    username@hostname-pc:~/git-github/docker/script$ docker images    
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    debian-vim-git      latest              1e08ef61f9da        14 minutes ago      270MB    
    debian-vim          latest              3eebf9f46f2f        37 minutes ago      165MB    
    username@hostname-pc:~/git-github/docker/script$    
    ````

## Biblio

- Conteneur
  - [LXC sur wikipedia](https://fr.wikipedia.org/wiki/LXC)
  - [Docker sur wikipedia](https://fr.wikipedia.org/wiki/Docker_(logiciel))
- Orchestrateur
  - [Kubernetes sur wikipedia](https://fr.wikipedia.org/wiki/Kubernetes)
  - [Minikube](https://kubernetes.io/fr/docs/setup/learning-environment/minikube/)
- Philosophie _(développement d'un conteneur)_
  - [The Twelve-Factor App](https://12factor.net/)
