# VSCode in docker

## Pratique

- récupérer l'image `docker pull codercom/code-server`

### Lancer le container

#### Avec `ssh`

- `docker run -it -p 127.0.0.1:8080:8080 -p 192.168.0.2:8080:8080 -e PASSWORD=mon_mot_de_passe -v "/:/tmp/test" -u "$(id -u):$(id -g)"  codercom/code-server:latest --disable-ssh`

#### Sans `ssh`

- `docker run -it -p 127.0.0.1:8080:8080 -p 192.168.0.2:8080:8080 -e PASSWORD=mon_mot_de_passe -v "/:/tmp/test" -u "$(id -u):$(id -g)"  codercom/code-server:latest`

### Se connecter dans le navigateur

- `http://localhost:8080`

## Biblio

- [docker hub](codercom/code-server)
- [image](https://github.com/cdr/code-server)
- [g++](https://code.visualstudio.com/docs/cpp/config-linux)
