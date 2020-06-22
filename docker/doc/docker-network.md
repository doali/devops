# Docker Network

# Network

> Docker utilise un réseau par défaut bridgé sur l'hôte d'adresse 172.17.0.0
> L'adresse 172.17.0.1 est utilisée par l'hôte (on peut le vérifier via la commande `ip a` et observant la ligne `docker0`)

> Attention, les adresses IPs ne sont pas fixes et peuvent potentiellement changer à chaque lancement du conteneur.

- il est par conséquent judicieux de se baser sur les noms des conteneurs plutôt que les adresses IPs.

## Exemple *introductif*

- lancer dans une console un conteneur (en background)

```bash
docker run --rm -it -d --name tuto alpine
```

- s'y connecter depuis une autre console

```bash
docker exec -it tuto sh
```

*Au sein du conteneur, on peut observer les adresses via la commande `ip a`*

- `ip a` : renvoie `172.17.0.2` (l'adresse `172.17.0.1` étant utilisée par le bridge mis en place par docker sur l'hôte)

## Création

> Commande très simple sans personnalisation pour créer un réseau

- `docker network nom_reseau`

Personnalisation du bridge via la création de réseaux

```bash
docker network create -d bridge --subnet 172.30.0.0/16 reseau_trente
```

> On indique que l'on créé un bridge (il existe aussi : overlay, macvlan, ...)
> On peut observer les informations sur le réseau créé via `docker inspect`

```bash
docker inspect reseau_trente
```

## Utilisation

```bash
docker run --name tuto_net_trente --rm -it -d --network reseau_trente alpine
```

> *Le conteneur est lancé en mode `detached`*
> *On peut entrer dans le conteneur `tuto_net_trente` et vérifier son ip, `ip a`*

- `docker exec -it tuto_net_trente sh`
- `ip a` : dans le conteneur

> Ou plus directement

- `docker exec tuto_net_trente ip a`

### Scénario de tests

On créé différents conteneurs sur le *même* réseau et l'on vérifie les adresses ip associées

#### Création des conteneurs 

Sur le même réseau !!

- `docker run --rm -d --name tuto_1 --network reseau_trente alpine tail -f /dev/null` : pour créer un conteneur en tâche de fond et le maintenir via `tail -f /dev/null`
- `docker run --rm -d --name tuto_2 --network reseau_trente alpine tail -f /dev/null` : pour créer un conteneur en tâche de fond et le maintenir via `tail -f /dev/null`
- `docker run --rm -d --name tuto_3 --network reseau_trente alpine tail -f /dev/null` : pour créer un conteneur en tâche de fond et le maintenir via `tail -f /dev/null`

#### Vérification des adresses ip

- `docker exec tuto_1 ip a`
- `docker exec tuto_2 ip a`
- `docker exec tuto_3 ip a`


#### `ping` adresses / nom conteneur

- `docker exec ping 172.30.0.3`
- `docker exec ping tuto_3`

## Suppression

- `docker network rm reseau_trente` : pour supprimer le réseau reseau_trente

## Types de réseau

> On peut observer via la commande `docker network ls` dans la colonne `NAME` différents types

`--net`

- `none` : aucun accès à l'hôte, pas d'ouverture sur le réseau
- `host` : accès uniquement à l'hôte (soit la machine hébergeant docker)
- `container:<nom_conteneur` : accès uniquement à un conteneur particulier

`--link`

- `<nom_conteneur>` : (idem que pour `--net` *mais* en plus renseigne le fichier `/etc/hosts` do conteneur)

`--add-host` `<nom_host>:ip` (pas des conteneurs, d'autres machines physiques sur le réseau)

- complète le fichier /etc/hosts

`--dns` : pour ajouter les IPs de serveurs `dns` (qui seront ajoutées à `/etc/resolv.conf`)

### Exemple *d'options*

#### `--link`

- création d'un conteneur `c_1`

```bash
docker run --rm -it --name c_1 debian
```

- création d'un conteneur `c_2` linké sur `c_1`

```bash
docker run --rm -it --name c_2 --link c_1 debian
```

> On peut observer en entrant dans le conteneur `c_2` le fichier `/etc/hosts`

```bash
root@a16a2689e42a:/# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	c_1 24a49e6fc8e8
172.17.0.3	a16a2689e42a
root@a16a2689e42a:/#
```

> ... et constater que `c_1` a été ajouté (ainsi que son `id`)

#### `--add-host`

```bash
docker run --rm -it --name c_3 --add-host titi:192.168.0.14 debian
```

```bash
root@9313ecffa5f7:/# cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
192.168.0.14	titi
172.17.0.3	9313ecffa5f7
root@9313ecffa5f7:/#
```

> On observe dans le fichier `/etc/hosts` l'ajout de l'@IP et du nom associé

#### `--ip`

- `docker network create -d bridge --subnet 192.85.0.0/16 net_yo` : création du réseau net_yo 
- `docker run --rm -it --name c_1 --network net_yo --ip 192.85.0.85 debian` : spécification de l'adresse ip

```bash
root@b082e52e50be:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
84: eth0@if85: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:c0:55:00:55 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.85.0.85/16 brd 192.85.255.255 scope global eth0
       valid_lft forever preferred_lft forever
root@b082e52e50be:/#
```
