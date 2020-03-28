
# Jenkins
_Jenkins est un outil open-source d'intégration continue._

# Installation
- ajout de la clef poiur les paquets jenkins
  ```bash
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  ```
- modification de la liste des paquets
  ```bash
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  ```
- mise a jour de la liste des paquets `sudo apt update`
- installation des paquets jenkins `sudo apt install jenkins`

# Decouverte
_Premier lancement de Jenkins_
- lancement de jenkins
  ```bash
  sudo systemctl start jenkins
  ```

  `sudo systemctl status jenkins` pour vérifier que jenkins est actif

- configuration
  - ```bash
    firefox http://localhost:8080
    ```

    > une page indique qu'un mot de passe est présent à deux endroits (il s'agit du même mot de passe) `/var/lib/jenkins/secrets/initialAdminPassword`

  - copier/coller le resultat de la commande
    ```bash
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
    dans le champ de saisie présent sur http://localhost:8080

  - saisie du formulaire de création du premier ***administrateur***

# Jobs
## Creation
- `firefox http://localhost:8080`
  > On suppose que Jenkins tourne sur la machine locale sur son port par défaut

- cliquer sur `Nouveau item`
- remplir le champ `Saisisser un nom`
- sélectionner `Construire un projet free-style`
- cliquer `OK`

_Le job est ainsi créé et peut-être défini._

### Exemple
- _On souhaite récupérer un projet sur un serveur git_
- _Le serveur git considéré sera hébergé à titre d'exemple à cette adresse `http://localhost/projet.git`_

Prérequis
- les étapes du paragraphe `Création` (au-dessus)
  - on référencera notre job par le nom `JobTest`

Configuration
- dans la section `Gestion de code source`
  - cocher `Git`
  - dans le champ `Repository URL` y copier notre adresse `http://localhost/projet.git`

- puis cliquer sur `Apply` et `Sauver`

> On est ramené à la page du projet (ou job)

_Il suffit alors de cliquer sur `Lancer un build` pour exécuter le projet_

> La puce de couleur ***bleue*** indique que le projet s'est exécuté de façon nominale

- en cliquant sur la puce bleue (correspondant à notre premier build marqué par `#1`)

  > L'URL du serveur Jenkins est de la forme suivante
  >- `http://localhost:8080/job/computing/1/`

  > C'est à dire
  > - `<serveur_jenkins>/job/<nom_projet>/<numero_de_build>`

  _Au niveau de la machine hôte de Jenkins, le répertoire associé est le suivant_
  ```bash
  /var/lib/jenkins/jobs/computing/builds/1
  ```
> Notre projet (ou job) `computing` correspond à l'adresse `http://localhost:8080/job/computing/`

> Le répertoire de travail noté `Espace de travail` qui lui est associé est à l'adresse `http://localhost:8080/job/computing/ws/`

_Au niveau de la machine hôte de Jenkins, le répertoire associé est le suivant_

```bash
/var/lib/jenkins/workspace/computing
```
> Dans cet exemple le répertoire `computing` contient un autre répertoire `langage-c` contenant des sources `*.c` que l'on souhaite compiler via jenkins.
> une méthode fonctionnelle pourrait-être
- au niveau du job cliquer sur `configurer`
- aller dans la section `Build`
- cliquer sur `Ajouter une étape`
  - sélectionner `Exécuter un script shell`
  - coller le code suivant
    ```bash
    # compilation de chaque <nom_fichier>.c en <nom_fichier>.exe
    # RM : on utilise une substitution introduite par le symbole %
    echo "Working directory"
    echo $PWD
    echo "Start compiling..."
    [ -d langage-c ] && cd langage-c && for i in *.c; do echo $i.c && sudo gcc -o "${i%.*}".exe $i; done; cd -
    echo "...compilation done"
    ```
    _Ce script compile chaque `<fichier>.c` en `<fichier>.exe` présent dans le répertoire `langage-c`_
- cliquer sur `Apply`
- cliquer sur `Sauver`

_Pour tester_
- cliquer sur `Lancer un build`
- cliquer sur le numéro du build `#<numero_build>`
- cliquer sur `Espace de travail` puis `langage-c`
  > Des fichiers .exe devraient avoir été générés

# Droits d'exécution
_On présente ici une configuration possible pour exécuter des scripts via jenkins nécessitant des privilèges administrateur._
_La configuration concerne la machine hôte sur laquelle s'exécute jenkins qui requiert des privilièges supplémentaires._

- s'assurer que le groupe jenkins existe
  ```bash
  cat /etc/group | grep jenkins
  ```
- `sudo visudo`
  > permet l'edition en mode super utilisateur du fichier `/etc/sudoers`
  - ajouter la ligne suivante
    ```bash
    jenkins ALL=(ALL) NOPASSWD:ALL
    ```
  _Il n'est ***pas nécessaire*** de relancer jenkins via `sudo systemctl restart jenkins`_

# Biblio

- [install jenkins ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-ubuntu-18-04)
- [install server jenkins](https://linuxize.com/post/how-to-install-jenkins-on-ubuntu-18-04/)
- [parefeu ufw](https://doc.ubuntu-fr.org/ufw)
- [jenkins mot de passe](https://wiki.jenkins.io/display/JENKINS/Logging)
- [ssl lors de la configuration de jenkins](https://www.digitalocean.com/community/tutorials/how-to-configure-jenkins-with-ssl-using-an-nginx-reverse-proxy-on-ubuntu-18-04)
