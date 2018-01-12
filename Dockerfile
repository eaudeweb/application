FROM node

RUN  apt-get update -y  \
     && apt-get install -y vim
     && apt-get install -y git

WORKDIR /opt
RUN git clone https://github.com/timeoff-management/application.git timeoff-management

WORKDIR /opt/timeoff-management
RUN git checkout v0.6.2

RUN rm  /opt/timeoff-management/views/partials/footer.hbs
RUN rm  /opt/timeoff-management/views/partials/header.hbs
RUN rm  /opt/timeoff-management/views/index.hbs

ADD application/views/partials/footer.hbs  /opt/timeoff-management/views/partials/footer.hbs
ADD application/views/partials/header.hbs  /opt/timeoff-management/views/partials/header.hbs
ADD application/views/index.hbs  /opt/timeoff-management/views/index.hbs

EXPOSE 3000

VOLUME /opt/timeoff-management/config
ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN npm install mysql && npm install
ENTRYPOINT [ "bash", "/docker-entrypoint.sh"]
CMD ["npm", "start"]
