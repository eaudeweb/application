FROM node
MAINTAINER "Eau de Web" <office@eaudeweb.ro>

RUN runDeps="curl build-essential vim git" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $runDeps \
    && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get install -y nodejs \
    && rm -vrf /var/lib/apt/lists/*

ENV WORK_DIR=/opt/lamunca-management
RUN mkdir -p $WORK_DIR

WORKDIR  $WORK_DIR
ADD  application/  $WORK_DIR

RUN npm install mysql && npm install

EXPOSE 3000
VOLUME /opt/lamunca-management/config
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "bash", "/docker-entrypoint.sh"]
