# Seul ARG peut précéder FROM
# ARG 

# Triptyque de base
# ------------------------------------------------------------------------------
# Image de base
FROM debian

# Mainteneur
MAINTAINER Username <user@domain.com>

# Lancé lors du build (après quoi, la layer sera exploitée !!) (relancé seulement si on rebuild)
RUN apt update
# ------------------------------------------------------------------------------

# Lancé une première fois lors du premier run (après quoi, la layer sera exploitée)
RUN apt install curl -y

# Lancé une première fois lors du premier run (après quoi, la layer sera exploitée)
RUN apt install nginx -y

ADD script.sh /usr/bin
RUN chmod ug+x /usr/bin/script.sh

# Indique que le conteneur sera en ecoute sur le port 80 
# Il faudra mapper réellement ce port !! => -p ou -P (port dynamique de l'hôte)
EXPOSE 80/tcp

# Diptyque de fin
# ------------------------------------------------------------------------------
# Sera toujours executé
ENTRYPOINT ["script.sh"]

# Sera executé SAUF si des argumente sont passés en ligne de commande
# - dans ce cas, sera surchargé par ces derniers
CMD ["bash"]

VOLUME /volume/data

ENV MESSAGE "mon message"

# Repertoire d'accueil au lancement du conteneur
WORKDIR /tmp/my-nginx
