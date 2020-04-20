# docker-compose

_Permet de lancer à la volée différents conteneurs._

- `docker-compose` : commande
- `docker-compose.yml` : fichier descriptif des actions à réaliser

## En pratique

Les étapes suivantes montrent comment passer

- de lignes de commandes `docker`
- au `Dockerfile`
- à un fichier `docker-compose.yml`

_Exemple utilisant l'image docker `nginx`_

### Lignes de commandes

_Recupérer l'image, la tagger l'exécuter_

- `docker pull nginx`
- `docker tag nginx:latest doali/nginx:0.0.1`
- `docker run --name doali-web -it -p 8080:80 doali/nginx:0.0.1`
- `docker cp index.html doali-web:/usr/share/nginx/html` (le répertoire courant doit contenir le fichier index.html)

_S'attacher à un conteneur s'exécutant_

- `docker exec -it doali-web bash`

### Dockerfile

```text
FROM nginx
COPY index.html /usr/share/nginx/html
```

- `docker build -t doali/nginx:0.0.1 .`
- `docker run --name doali-web -p 8080:80 doali/nginx:0.0.1`

### `docker-compose.yml`

_En se basant sur les commandes suivantes à traduire_

```bash
docker run --name doali-web -p 8080:80 -v ${PWD}/html:/usr/share/nginx/html nginx:0.0.1
```

où `${PWD}/html` contient le fichier `index.html`

- créer un fichier YAML : `docker-compose.yml`
- indiquer la version du fichier (doit-être en phase avec le moteur docker `docker --version`)

> par exemple : `version: "3.8"` [versions](https://docs.docker.com/compose/compose-file/)

- `<nom_container>:` le nom du conteneur que l'on va lancer, doali-web
- `image:` image à instancier
- `restart: [always]` pour lancer l'exécution du `docker-compose.yml` sitôt que le daemon docker tourne
- `volumes:` introduit les volumes à monter sur le conteneur

## Biblio

- [docker docs](https://docs.docker.com/compose/compose-file/)
- [quora $(pwd)](https://www.quora.com/Do-docker-volumes-not-work-with-relative-paths)
