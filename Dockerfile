FROM alpine:3.9.2@sha256:644fcb1a676b5165371437feaa922943aaf7afcfa8bfee4472f6860aad1ef2a0
MAINTAINER Riccardo Balbo <riccardo0blb@gmail.com>
USER root
COPY run.sh /run.sh
RUN  apk add  --no-cache --virtual .build-deps linux-headers gcc musl-dev

RUN  apk add --upgrade  --no-cache libffi-dev openssl-dev dialog  python \
  python-dev \
  py-setuptools py-pip

RUN pip install --upgrade pip \
&& if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi \
&& pip install certbot\
&& apk del .build-deps

