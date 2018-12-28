FROM rcarmo/alpine:3.6-armhf

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    dumb-init \
 && pip install paho-mqtt broadlink

ADD rootfs /

USER www-data

CMD ["/init.sh"]
