# Ubuntu 18.04

# libvirt-qemu

## Permissions

Suite à des erreurs rencontrées lors de la création du domain (de la VM)

- `sudo getfacl -e /media/blackpc/`
- `sudo setfacl -m u:libvirt-qemu:rx /media/blackpc/`

Concernant le montage de la clef USB

- donner les droits d'accès nécessaires à libvirt-qemu !

```bash
sudo mount -t vfat /dev/sdb1 /media/blackpc/USB_KEY -o uid=1000,gid=1000,utf8,dmask=020,fmask=137
```

> Le point important est concernant `fmask=137` qui donne les droits `rwx` pour `o(thers)`

**Attention**, il faudra plutôt utiliser `fmask=130` (soit aucun droit) pour les autres

## Biblio

- [group permission libvirt](https://github.com/jedi4ever/veewee/issues/996)
