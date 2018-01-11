FROM node

WORKDIR /opt

RUN git clone https://github.com/anecula/timeoff-management-application.git timeoff-management 

WORKDIR /opt/timeoff-management
RUN npm install mysql && npm install

EXPOSE 3000
VOLUME /opt/timeoff-management/config
CMD ["npm", "start"]
