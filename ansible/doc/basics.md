# Ansible

- `Galaxy`

> Galaxy is a hub for finding and sharing Ansible content. \
> Galaxy provides pre-packaged units of work known to Ansible as Roles, and new in Galaxy 3.2, Collections.

## Notions



### Playbooks



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

```tree````

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
