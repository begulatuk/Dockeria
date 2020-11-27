FROM alpine:latest

RUN apk update && apk add --no-cache bash wget unzip curl yarn
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
    apk add glibc-2.32-r0.apk && \
    rm /etc/apk/keys/sgerrand.rsa.pub && \
    rm glibc-2.32-r0.apk && \
    rm -r /var/cache/apk/APKINDEX.*

WORKDIR /app

COPY package.json setup.sh yarn.lock /app/
RUN bash setup.sh
RUN yarn
RUN apk del wget unzip curl yarn && \
    rm -rf /tmp/* && rm -rf /var/cache/apk/* 
COPY . .
ENV PORT=8080
EXPOSE 8080
CMD ["bash", "start.sh"]
