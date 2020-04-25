#
# THIS DOES NOT WORK !!
#
FROM alpine

MAINTAINER doali xou.xavl@gmail.com

RUN apk update --no-cache
RUN apk add openrc
RUN apk add openssh
RUN rc-update add sshd

RUN rc-status
RUN touch /run/openrc/softlevel
RUN rc-service sshd start

EXPOSE 22/tcp

# https://github.com/gliderlabs/docker-alpine/issues/437
#VOLUME ["/sys/fs/cgroup"]

#ENTRYPOINT ["rc-service", "sshd", "start"]
CMD tail -f /dev/null
