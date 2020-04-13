# Dockerfile

- `FROM` requis; première instuction; image de base (base layer) sur laquelle est bâtie notre image
- `MAINTAINER` mainteneur de l'image  `Nom <email>`
- `RUN` lance une commande; créé un layer (resultant de cette commande) apposé au layer précédent
- `COPY` copie depuis l'hôte vers le conteneur
- `ADD` copie un fichier depuis la machine hôte ou depuis une URL dans le container
- `EXPOSE` (merely a hint) indique qu'un port est exposé (ne publie pas le port !!); 

> Pour publier le port il faut l'indiquer

  - `-P` : bind chaque port exposé du conteneur à un port aléatoire de l'hôte
  - `-p localhost:8000:5000` : bind le port 8000 de l'hôte sur le port 5000 du conteneur (`docker run -p localhost:8000:5000 [...])`

- `CMD` commande à exécuter au démarrage du conteneur (unlike RUN : pas de nouveau layer); uniquement **un** `CMD` dans un Dockerfile
- `ENTRYPOINT` permet d'ajouter une commande qui sera exécutée par défaut, et ce, même si on choisit d'exécuter une commande différente de la commande standard
- `WORKDIR` définit le dossier de travail pour toutes les autres commandes (par exemple RUN, CMD, ENTRYPOINT et ADD)
- `ENV` définit des variables d'environnements qui pourront ensuite être modifiées grâce au paramètre de la commande `run --env <key>=<value>`
- `VOLUMES` créé un point de montage assurant la persitance des données. On pourra alors choisir de monter ce volume dans un dossier spécifique en utilisant la commande `run -v :`

## Step 1

- création du fichier (en respectant la casse proposée) : `touch Dockerfile`

- exemple de fichier : `cat Dockerfile`

```bash
# Image de base
FROM debian

# Mainteneur
MAINTAINER Username <user@domain.com>

RUN apt update -y
```

- instanciation de l'image décrite par le `Dockerfile` : `docker build -t doali/debian-update`
- `-t <TAG>` : définition d'un TAG

> Forme usuelle du TAG : [<component>|<comp_part1>/<comp_part2>:<version>|<registry>:<port>`

- `docker tag <comp_part2> <comp_part1>/<comp_part2>:<version>`
- `docker tag httpd fedora/httpd:version1.0`
- `docker tag <sha1> myregistry:5000/<comp_part1>/comp_part2>:<version>`

> `docker tag <sha1> user/image-name`

## Bonnes pratiques

- versionner le Dockerfile

## Biblio

- [grafikart Dockerfile](https://www.grafikart.fr/tutoriels/Dockerfile-636)
- [vsupalov EXPOSE](https://vsupalov.com/docker-expose-ports/)
