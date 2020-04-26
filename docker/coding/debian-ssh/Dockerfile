FROM debian

MAINTAINER doali doali.phone@gmail.com

RUN apt update && \
  apt install -y \
  openssh-client \
  openssh-server \
  vim

RUN mkdir -p /root/.ssh

COPY id_ecdsa.pub /root/.ssh

RUN mv /root/.ssh/id_ecdsa.pub /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT service ssh start && tail -f /dev/null
