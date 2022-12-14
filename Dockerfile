FROM alpine

USER root

WORKDIR /app

RUN apk add git \
    openssh \
    git-subtree \
    git-lfs

ADD entrypoint.sh ./

RUN chmod 777 "./entrypoint.sh"

ENTRYPOINT ["/app/entrypoint.sh"]