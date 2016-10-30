#
# Dockerfile for kcptun-server
#

FROM alpine:3.4
MAINTAINER siqi <masiqi@gmail.com>

ENV SSGO_VER 1.1.5
ENV SSGO_URL https://github.com/shadowsocks/shadowsocks-go/releases/download/${SSGO_VER}/shadowsocks-server-linux64-${SSGO_VER}.gz

WORKDIR /tmp/

RUN set -ex \
  && apk update \
  && apk add --no-cache --virtual .build-deps curl \
  && curl -sSL $SSGO_URL -o ssgo.gz
  && gunzip ssgo.gz
  && chmod +x ./* \
  && mv ./ssgo /usr/local/bin \
  && apk del .build-deps

ENV LISTEN_PORT 443
ENV MODE aes-256-cfb
ENV KEY ^password$

EXPOSE $LISTEN_PORT

CMD ssgo -k $KEY \
         -m $MODE \
         -p $LISTEN_PORT
