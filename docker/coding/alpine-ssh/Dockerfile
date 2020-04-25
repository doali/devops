#
# THIS STILL DOES NOT WORK !!
#
FROM alpine

RUN apk update --no-cache add \
  openrc \
  openssh

RUN rc-update add sshd \
  && rc-status \
  && touch /run/openrc/softlevel \
  && rc-service sshd start

EXPOSE 22/tcp

# https://github.com/gliderlabs/docker-alpine/issues/437
#VOLUME ["/sys/fs/cgroup"]

#ENTRYPOINT ["rc-service", "sshd", "start"]
CMD ["tail", "-f", "/dev/null"]
