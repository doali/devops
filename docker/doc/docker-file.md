# Dockerfile

- `FROM` image de référence sur laquelle bâti notre image
- `MAINTAINER` mainteneur de l'image  `Nom <email>`
- `RUN` lance une commande, créé une image intermédiaire
- `COPY` copie depuis l'hôte vers le conteneur
- `ADD` copie un fichier depuis la machine hôte ou depuis une URL dans le container
- `EXPOSE` permet d'exposer un port du container vers l'extérieur
- `CMD` commande à exécuter au démarrage du conteneur
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
MAINTAINER XavL <xou.xavl@gmail.com>

RUN apt update -y
```

- instanciation de l'image décrite par le `Dockerfile` : `docker build -t doali/debian-update`
- `-t <TAG>` : définition d'un TAG

## Bonnes pratiques

- versionner le Dockerfile

## Biblio

- [grafikart Dockerfile](https://www.grafikart.fr/tutoriels/Dockerfile-636)
