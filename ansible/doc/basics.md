# Ansible
_Michael DeHaan_ 

_Créé en 2012 et actuellement sous la responsabilité de Red Hat (IBM)_

---

- `ansible-playbooks`

> Ansible est un outil de gestion de configurations \
> qui permet d'automatiser des tâches avec des scripts d'automatisation,
> d'effectuer des déploiements (via des connexions ssh, des playbooks, paquets, scripts...)

- `ansible-galaxy`

> Galaxy is a hub for finding and sharing Ansible content. \
> Galaxy provides pre-packaged units of work known to Ansible as Roles, and new in Galaxy 3.2, Collections.

## Notions

- playbooks : fichiers YAML décrivant toutes les tâches

- IAC : Infrastructure As Code

```
IAC is the instructions needed to provision and or configure infrastructure services...
e.g. you would run IAC scripts to build and or configure your infrastructure services as needed for your application...
``` 
[Mark Smith](https://www.quora.com/What-is-the-difference-between-IaaS-and-IAC)

## Roadmap, bonnes pratiques

- décomposer l'installation en étapes
- définir l'architecture technique 
- automatiser les tâches d'installation, de déploiement

### Playbooks

- fichiers YAML : définition des tâches à réaliser sur les cibles
  - définition des hôtes
  - définition des variables
  - appel des tâches à exécuter (qui peuvent appeler des modules)
  - utilisation de templates (pour créer des scripts

- `--syntax-check` : vérifier la syntaxe du playbook
- `--check` : réaliser une sIMUlation

### Roles

- `ansible-galaxy install geerlingguy.apache` : récupère des rôles de `Galaxy`

> Les rôles doivent-être téléchargés avant de pouvoir les utiliser dans les `playbooks`

- `touch my_playbook.yml` le fichier `YAML` décrit le playbook !!

```yaml
---
- hosts: all
  roles:
    - geerlingguy.apache
```

- `ansible-playbook -i path/to/custom-inventory my_playbook.yml` exécution 
- `ansible-galaxy list` affiche les rôles installés et leurs versions
- `ansible-galaxy remove [role]` supprime un rôle installé
- `ansible-galaxy info` informations
- `ansible-galaxy init` création d'une hiérarchie de dossiers selon un modèle préconisé par Ansible Galaxy
- `ansible.cfg` fichier de configuration d'Ansible (`ansible --version` ou `ansible-galaxy --version` indique l'emplacement)

#### Cas pratique

- `ansible-galaxy init init_role`

> - init_role was created successfully

```bash
tree
```

```bash
.
└── init_role
    ├── defaults
    │   └── main.yml
    ├── files
    ├── handlers
    │   └── main.yml
    ├── meta
    │   └── main.yml
    ├── README.md
    ├── tasks
    │   └── main.yml
    ├── templates
    ├── tests
    │   ├── inventory
    │   └── test.yml
    └── vars
        └── main.yml

9 directories, 8 files
```

## Bilio

- [geerlingguy](https://galaxy.ansible.com/geerlingguy)
- [openclassroom](https://openclassrooms.com/fr/courses/2035796-utilisez-ansible-pour-automatiser-vos-taches-de-configuration)
- [journaldunet](https://www.journaldunet.fr/web-tech/guide-de-l-entreprise-collaborative/1443876-ansible-outil-star-de-la-gestion-des-configurations-open-source-gratuit/)
