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

- créer un fichier YAML : `docker-compose.yml`
- indiquer la version du fichier
- le nom du conteneur que l'on va lancer
  - `--name=doali-web`
- image à instancier
  - `image: nginx:0.0.1`

## Biblio

- [docker docs](https://docs.docker.com/compose/compose-file/)
