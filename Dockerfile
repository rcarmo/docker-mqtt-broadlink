FROM rcarmo/alpine:3.6-armhf

RUN apk add --update \
    python \
    python-dev \
    gcc \
    musl-dev \
    py-pip \
    dumb-init \
 && pip install paho-mqtt broadlink

ADD rootfs /

USER nobody

CMD ["/init.sh"]
