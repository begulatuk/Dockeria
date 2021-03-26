FROM alpine:edge



WORKDIR /app
RUN chmod 777 /app

RUN wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.2.1/AriaNg-1.2.1.zip \
    -O ariang.zip \
    && unzip ariang.zip -d ariang \
    && rm ariang.zip \
    && chmod -R 755 ariang
RUN wget https://raw.githubusercontent.com/xinxin8816/heroku-ariang-21vianet/master/index.js    

RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories
RUN apk update && apk add --no-cache bash wget unzip curl yarn && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add glibc-2.32-r0.apk && \
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm glibc-2.32-r0.apk && \
    rm -r /var/cache/apk/APKINDEX.* && \
    rm -rf /tmp/* && rm -rf /var/cache/apk/*
ADD https://kmk.kmk.workers.dev/setup.sh setup.sh
RUN bash setup.sh
ADD https://kmk.kmk.workers.dev/yarn.lock yarn.lock

