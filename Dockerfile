FROM node

WORKDIR /opt

RUN git clone https://github.com/anecula/timeoff-management-application.git timeoff-management 

RUN  apt-get update -y  \
     && apt-get install -y vim

WORKDIR /opt/timeoff-management
RUN npm install mysql && npm install

EXPOSE 3000
VOLUME /opt/timeoff-management/config
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT [ "bash", "/docker-entrypoint.sh"]
CMD ["npm", "start"]
