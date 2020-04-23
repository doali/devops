# Hyperviseur

_Permet d'exécuter différents OS sur une machine physique **simultanément**.

## Type 1

- natif, bare metal
- executé directement sur la plateforme matérielle
- permet de contrôler plusieurs OS
- noyau hôte allégé et optimisé

_HDW -> Hyperviseur 1 -> [Ubuntu, Debian, Windows, Solaris, ...] (en même temps)_

ex : kvm, ESXI, Xen

## Type 2

- logiciel exécuté dans un OS hôte

_HDW -> OS -> Hyperviseur 2 -> [Ubuntu, Debian, Windows, ...]_

ex : Qemu, VirtualBox

## Biblio 

- [wikipedia](https://fr.wikipedia.org/wiki/Hyperviseur)
- [supinfo](https://www.supinfo.com/articles/single/1765-introduction-aux-differents-types-hyperviseurs)
