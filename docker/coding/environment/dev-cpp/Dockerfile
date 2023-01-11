FROM ubuntu:latest

ARG UID=1000
ARG GID=1000

LABEL maintener="doali"

RUN apt-get update && apt-get install -y \
  build-essential \
  vim \
  git

VOLUME /volume/data

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u ${UID} ubuntu
USER ubuntu

RUN mkdir -p /home/ubuntu/.local/bin \
    && ls /home/ubuntu/.local/bin
ENV PATH=${PATH}:/home/ubuntu/.local/bin
COPY --chown=${UID} script.sh /home/ubuntu/.local/bin
RUN chmod u+x /home/ubuntu/.local/bin/script.sh

WORKDIR /home/ubuntu

ENTRYPOINT ["script.sh"]
CMD ["/bin/bash"]
