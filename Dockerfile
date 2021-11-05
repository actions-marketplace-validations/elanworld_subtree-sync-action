FROM alpine

USER root

RUN apk add git \
    openssh \
    git-subtree \
    git-lfs

ADD entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]