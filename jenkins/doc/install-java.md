# Java
>_Installation et configuration de Java_

_Java propose différents utilitaires permettant :_
- soit d'exécuter des executables issus de programmes écrits en java via l'installation du ***JRE***
- soit de compiler des sources et de le executer via l'installation du ***JDK***

# Java Run Time Environnement (JRE)
_Si la commande `java --version` indique que java n'est pas installé alors on peut lancer la commande ci-dessous_
```bash
sudo apt install default-jre
```

# Java Developer Kit (JDK)
_Si la commande `javac --version` indique que j'avac n'est pas installé alors on peut lancer la commande suivante_
```bash
sudo apt install default-jdk
```

(!) L'installation du JDK entrainera également l'installation du JRE.

# Configuration
## Installation d'une version spécifique
```bash
sudo apt install openjdk-11-jdk
```
```bash
sudo apt install openjdk-11-jre
```
## Personal Package Archive (PPA) d'Oracle ***obsolète***
- Ajouter le dépôt
  ```bash
  sudo add-apt-repository ppa:webupd8team/java
  ```
- mettre à jour la liste des paquets `sudo apt update`
- installation du paquet
  ```bash
  sudo apt install oracle-java9-installer
  ```

(!) Oracle a récemment pris des disposition concernant ses licences si bien que ce PPA est devenu inutilisable !!

## Gestion de la configuration
### Selection de la version JRE et JDK
_Il est possible d'avoir plusieurs installations de java et de spécifier laquelle utiliser par défaut._

- JRE
  ```bash
  sudo update-alternatives --config java
  ```

- JDK
  ```bash
  sudo update-alternatives --config javac
  ```
> Taper un nombre correspondant aux différents choix pour la configuration par défaut

### Variable d'environnement
(!) Configuration de la variable d'environnement **JAVA_HOME**
qui permet aux programmes écrits en java de déterminer où se situe la JVM.

- déterminer le chemin du JRE/JDK
  ```bash
  update-alternatives --config java
  ```

  > Ici nous avons : /usr/lib/jvm/java-11-openjdk-amd64/bin/java

- ajouter le chemin
  - dans le fichier `/etc/environnement/`
    ```bash
    JAVA_HOME="/usr/lib/jvm/default-java"
    ```
    > JAVA_HOME est alors valable pour tous les utilisateurs du système
  - ou dans le fichier `$HOME/.bashrc`
    ```bash
    export JAVA_HOME="/usr/lib/jvm/default-java"
    ```
    > valable pour l'utilisateur seulement

  > ...default-java est un lien symbolique `default-java ⇒ java-1.11.0-openjdk-amd64`


# Biblio

- [install java](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04#installing-specific-versions-of-openjdk)
- [ppa deconnecte](https://launchpad.net/~webupd8team/+archive/ubuntu/java)

