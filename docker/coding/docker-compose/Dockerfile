FROM nginx

COPY js /usr/share/nginx/js
COPY css /usr/share/nginx/css

EXPOSE 80/tcp

VOLUME /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
