# VSCode in docker

## Pratique

- récupérer l'image `docker pull codercom/code-server`

### Lancer le container

#### Sans `ssh`

- `docker run -it -p 127.0.0.1:8080:8080 -p 192.168.0.2:8080:8080 -e PASSWORD=mon_mot_de_passe -v "/:/tmp/test" -u "$(id -u):$(id -g)"  codercom/code-server:latest --disable-ssh`

#### Avec `ssh`

- `docker run -it -p 127.0.0.1:8080:8080 -p 192.168.0.2:8080:8080 -e PASSWORD=mon_mot_de_passe -v "/:/tmp/test" -u "$(id -u):$(id -g)"  codercom/code-server:latest`

### Se connecter dans le navigateur

- `http://localhost:8080`

## Adresse IP

_Récupérer l'adresse IP de l'hôte, sachant que le nom de l'interface est `wlp3s7`_

```bash
ip -o addr | grep  wlp3s7 | awk '{print$4}' | head -1 | cut -d\/ -f1
```

## Biblio

- [docker hub](codercom/code-server)
- [image](https://github.com/cdr/code-server)
- [g++](https://code.visualstudio.com/docs/cpp/config-linux)
- [cert, https](https://github.com/demyxco/code-server/blob/master/docker-compose.yml)
- [https](https://github.com/cdr/code-server/discussions/1048)
