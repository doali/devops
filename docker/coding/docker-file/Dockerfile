# Seul ARG peut précéder FROM
# ARG 

# Triptyque de base
# ------------------------------------------------------------------------------
# Image de base
FROM debian

# Mainteneur
MAINTAINER Username <user@domain.com>

# Lancée lors du build (après quoi, la layer sera exploitée !!) (relancée seulement si on rebuild)
RUN apt update
# ------------------------------------------------------------------------------

# Lancée une première fois lors du premier run (après quoi, la layer sera exploitée)
RUN apt install curl -y

# Lancée une première fois lors du premier run (après quoi, la layer sera exploitée)
RUN apt install nginx -y

# Presuppose que le répertoire courant contient script.sh
ADD script.sh /usr/bin
RUN chmod ug+x /usr/bin/script.sh

# Indique que le conteneur sera en écoute sur le port 80 
# (!) Il faudra mapper réellement ce port !! => -p ou -P (port dynamique de l'hôte) (!)
# Exemple
# - on suppose que : docker build -t doali/nginx .
# => docker run --name doali-nginx -p 8080:80 -v $(pwd)/tmp:/volume/data -it doali/nginx
EXPOSE 80/tcp

# Diptyque de fin
# ------------------------------------------------------------------------------
# Sera toujours executée
ENTRYPOINT ["script.sh"]

# Sera executée SAUF si des argumente sont passés en ligne de commande
# - dans ce cas, sera surchargée par ces derniers
CMD ["bash"]

# Point de montage du conteneur
# (!) il faudra réelement monter le volume !! (!)
# Exemple
# - on suppose que : docker build -t doali/nginx .
# => docker run --name doali-nginx -p 8080:80 -v $(pwd)/tmp:/volume/data -it doali/nginx
VOLUME /volume/data

# Variable d'environnement du conteneur
ENV MESSAGE "mon message"

# Repertoire d'accueil au lancement du conteneur
WORKDIR /tmp/my-nginx
