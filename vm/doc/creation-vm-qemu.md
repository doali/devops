# Récupération et lancement de deux VM debian arm64

Ce script permet récuperer deux VM debian arm64 qui sont disponibles sur le NAS et ainsi les lancer, les images sont préconfigurées de sorte @ ce qu'elles disposent de tous les paquets nécessaires a la communication entre VM (série ou tcp)

## Getting started

Pour lancer ces VM, il suffit juste de lancer le script:
```bash
./launch.sh
```

## Explication du script

### Récupération des images
```
wget -nc -P /tmp ftp://admin:<USER>@nas/images_vms/...
```
permet la récuperation des images de debian. Les fichiers debian1 et debian2 sont les images de debian, ainsi que varstore1 et varstore2 qui permettent de stocker les variables EFI. QEMU_EFI est un bootloader pour une architecture ARM.

### Création du lien série ainsi que les configurations réseaux

Cette commande crée un pipe bi-directionnel permettant la communication du lien série entre les deux VM.
```bash
mkfifo /tmp/serie
```

Création de deux interfaces réseaux, une pour chaque VM.
```bash
sudo tunctl -u $USER -t tap0
sudo tunctl -u $USER -t tap1
```

Création et attribution d'une adresse IP d'un pont réseau.
```bash
sudo brctl addbr br0
sudo ifconfig br0 192.168.1.1 netmask 255.255.255.0 up
```

Ajout d'une lien permettant la communication entre les VM et la machine hote
```bash
sudo brctl addif br0 tap0
sudo brctl addif br0 tap1
```

Activation des liens réseaux avant la mise en marche des VM
```bash
sudo ifconfig tap0 0.0.0.0 promisc up
sudo ifconfig tap1 0.0.0.0 promisc up
```

### Lancement des vm grace a qemu

Nous lançons les VM grâce à qemu, virt-manager permet le lancement de machines ARM

Voici la description des différentes options:

- -cpu cortex-a53       Choix du cpu
- -M virt               Choix de la machine, ici nous utilisons la machine virt de qemu
- -m 1024               Choix de la RAM
- -nographic            Ne pas lancer la VM dans une nouvelle fenetre

- -drive if=pflash,format=raw,file=/tmp/QEMU_EFI.img        Choix du bootloader
- -drive if=pflash,file=/tmp/varstore.img                   Ajout d'un stockage pour les variables EFI
- -drive if=virtio,file=/tmp/debian.img                     Choix de l'image

#### Ces trois dernières commandes utilisent des fichiers qui ont été recupérés préalablement.

- -chardev pipe,id=serie,path=/tmp/serie   Utilisation du lien série que l'on a créé précédemment
 -device pci-serial,chardev=serie         Activation du lien ttyS0 dans la VM pour l'utilisation du lien série
- -net nic,macaddr=XX:XX:XX:XX:XX:XX       Attribution d'une adresse MAC pour l'utilisation d'un lien réseau

- -net tap,ifname=tap0,script=no           Gestion du lien réseau et affectation de l'interface reseau créée
