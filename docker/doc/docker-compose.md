# docker-compose

```text
Compose is a tool for defining and running multi-container Docker applications.
```

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

- `docker pull nginx` récupération de nginx
- `docker tag nginx:latest doali/web:0.1` tag de l'image src vers target
- `docker run --name doali-web -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html doali/web:0.1` lancement
- `docker cp css doali-web:/usr/share/nginx` copier le répertoire css
- `docker cp js doali-web:/usr/share/nginx` copier le répertoire js

Scénario de commandes docker

- `docker pull nginx` récupération de nginx
- `docker tag nginx:latest doali/web:0.1` tag de l'image src vers target
- `docker run --name doali-web -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html doali/web:0.1` lancement
- `docker logs doali-web -f` verifier les logs
- `docker exec -it doali-web bash` entrer dans le conteneur depuis un autre terminal
- `docker cp css doali-web:/usr/share/nginx` copier le répertoire css
- `docker cp js doali-web:/usr/share/nginx` copier le répertoire js
- `docker stop doali-web` stopper le conteneur
- `docker diff doali-web` diff du conteneur avec le conteneur issu de l'image de base
- `docker start doali-web` relancer le conteneur
- `docker rm doali-web` supprimer le conteneur

### Dockerfile

```Dockerfile
FROM nginx

COPY js /usr/share/nginx/js
COPY css /usr/share/nginx/css

EXPOSE 80/tcp

VOLUME /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
```

> (!) `COPY js /usr/share/nginx/js` 
> copie le contenu de `js` et non le répertoire... 
> => [...]/js en destination

- `docker build -t doali/web:0.1 .`
- `docker run --name doali-web -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html doali/web:0.1`

### `docker-compose.yml`

On se base sur la construction de l'image `doali/web:0.1` vue précédemment

- soit en utilisant les lignes de commandes (voir au-dessus)
- soit via l'utilisation du Dockerfile : `docker build -t doali/web:0.1 .`

_La commande que l'on souhaite réaliser dans le `docker-compose.yml`_

- docker run --name doali-web -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html doali/web:0.1

où `$(PWD)/html` contient le fichier `index.html`

- créer un fichier YAML : `docker-compose.yml`
- indiquer la version du fichier (doit-être en phase avec docker engine `docker --version`)

> par exemple : `version: "3.8"` [versions](https://docs.docker.com/compose/compose-file/)

- `<nom_container>:` le nom du conteneur que l'on va lancer, doali-web (.i.e service)
- `image:` image à instancier
- `restart: [always]` pour lancer l'exécution du `docker-compose.yml` sitôt que le daemon docker tourne
- `volumes:` introduit les volumes à monter sur le conteneur

```yaml
doali-web:
  image: doali/web:0.1
  volumes:
    - ./html:/usr/share/nginx/html
  ports:
    - 8080:80
```

- `docker-compose up` pour démarrer le service (dans le répertoire contenant le docker-compose.yml)
- `docker-compose stop doali-web` pour stopper le service `doali-web`

> Ou encore `docker stop dockercompose_doali-web_1`

- `docker-compose images` : pour lister les images utilisées par docker-compose
- `docker-compose ps` : pour lister les processus initiés par docker-compose
- `docker-compose exec doali-web bash` (`docker-compose exec <nom_service> <commande>`)

_Autre description du fichier_

```yaml
version: "3.3"
services:
  doali-web:
    image: doali/web:0.1
    ports:
      - 8080:80
    volumes:
      - ./html:/usr/share/nginx/html
```

_Autre description du fichier en se basant **directement** sur le `Dockerfile`_

```yaml
version: "3.3"
services:
  doali-web:
    image: doali/web:0.2
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 8080:80
    volumes:
      - ./html:/usr/share/nginx/html
```

- `image: doali/web:0.2` sera le tag de notre image ainsi construite 

> (!) doit aller de paire avec `build` sinon _Compose_ cherchera une image du nom `doali/web:0.2` qui n'existe pas encore...
> Du coup...

- `build:` doit être présent :-)

## Important

### Lignes de commandes

#### Volume

Pour monter un volume depuis l'invite de commande, il faut indiquer le chemin **absolu**

- docker run --name doali-web -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html doali/web:0.1

> Utiliser : `$(pwd)` ou encore `${PWD}`

### Dockerfile

Pour copier un **répertoire** depuis l'hôte vers le conteneur, il faut spécifier le répertoire destination
La commande copie le contenu du répertoire source !!
Il faut donc reprendre le nom du répertoire source pour l'indiquer dans le chemin destination

- `COPY <nom_repertoire>:/chemin/dans/container/<nom_repertoire>`
- `COPY css /usr/share/nginx/css`

### docker-composer

Pour observer les logs

- `docker-compose logs -f <nom_service>`
- `docker-compose logs -f doali-web`

> On peut aussi utiliser `docker logs -f dockercompose_<nom_service>_<numero>`

- `docker logs -f dockercompose_doali-web_1`

### Links entre services (containers) `MySQL`

```text
Links allow you to define extra aliases by which a service is reachable from another service
```

En repartant du docker-compose, on ajoute un base de données `MySQL`


## Biblio

- [docker docs](https://docs.docker.com/compose/compose-file/)
- [quora $(pwd)](https://www.quora.com/Do-docker-volumes-not-work-with-relative-paths)
- [docker compose](https://docs.docker.com/compose/)
- [docker compose specs](https://docs.docker.com/compose/compose-file/)
- [docker-compose chaines](https://runnable.com/docker/advanced-docker-compose-configuration)
- [docker compose network](https://runnable.com/docker/docker-compose-networking)
- [flask, python, docker](https://docs.docker.com/compose/gettingstarted/)
- [docker docs](https://docs.docker.com/compose/networking/#links)
